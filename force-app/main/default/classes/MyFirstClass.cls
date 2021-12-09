public with sharing class MyFirstClass {
    private List<Account> accountList;
    private static final String DEFAULT_EMAIL = 'genericContact@fakemail.net';
    private static final String DEFAULT_PHONE = '(777) 888-9999';

    // CONSTRUCTORS
    public MyFirstClass() {
        this(null);
    }
    public MyFirstClass(List<Account> initial) {
        accountList = new List<Account>();
        if (initial == null) {
            return;
        }
        for (Account acc: initial) {
            accountList.add(acc);
        }
    }

    // Add 'quantity' number of Accounts named 'Generic Account ${#}'
    //   Starting at 'startCount', and clear the object accountList if 'clear'
    public void AddGenericAccounts(Integer startNum, Integer quantity, Boolean clear) {
        if (quantity < 1) {
            System.debug('No Accounts Added: quantity must be positive. Arg=' + quantity);
            return;
        }
        for (Integer index = 0; index < quantity; index++) {
            String acctName = 'Generic Account ' + (startNum + index);
            Account newAccount = new Account(name = acctName);
            accountList.add(newAccount);
        }
        Insert accountList;
        if (clear) {
            accountList.clear();
        }
    }

    // Create a class that has a method to add 151 accounts to your org.
    //   These accounts should have unique names.
    public void Add151Accounts() {
        Integer startNum = 1;
        Boolean ifClearAfter = false;
        AddGenericAccounts(startNum, 151, ifClearAfter);
    }

    // Delete 'quantity' accounts, starting generic name at account 'startNum'
    public void DeleteAccounts(Integer startNum, Integer quantity) {

        // First, get list of generic names
        List<String> genericNames = new List<String>();
        for (Integer index = 0; index < quantity; index++) {
            String currName = 'Generic Account ' + (startNum + index);
            genericNames.add(currName);
        }

        // Single set operation rather than one for each name
        Set<String> namesToFilter = new Set<String>();
        namesToFilter.addAll(genericNames);

        List<Account> toDelete = [SELECT name FROM Account WHERE name IN :namesToFilter];
        Delete toDelete;
    }

    // Query for the accounts you made, and then remove them from the database.
    public void DeleteAccounts1to151() {
        Integer startNum = 1;
        DeleteAccounts(startNum, 151);
    }

    // Query for all contacts that do not have a email and/or phone number
    //   associated with them, and provide default data for those fields.
    public void ProvideContactDetails() {
        List<Contact> contactMissingDetails = [SELECT lastName, phone, email FROM Contact
                                               WHERE phone = null OR email = null];
        
        // Apply default email & phone #
        for (Contact currContact: contactMissingDetails) {
            if (currContact.phone == null) {
                currContact.phone = DEFAULT_PHONE;
            }
            if (currContact.email == null) {
                currContact.email = DEFAULT_EMAIL;
            }
        }

        Update contactMissingDetails;
    }

    // Generate list of 'quantity' generic Contacts, with last names 'Lastname${#}'
    //   starting at 'startNum'.
    private List<Contact> GenericContactList(Integer startNum, Integer quantity) {
        List<Contact> contactList = new List<Contact>();
        for (Integer index = 0; index < quantity; index++) {
            Contact newContact = new Contact(lastName = 'Lastname' + (startNum+index));
            contactList.add(newContact);
        }
        return contactList;
    }

    // Create 200 new contacts with different names, plus update all existing
    //   contacts emails to the default. (Use only 1 DML statement).
    public void Create200GenericContacts() {
        List<Contact> allContacts = [SELECT lastName FROM Contact];

        // Add contact 'LastName${#}' from 1 to 200 to Apex List
        Integer addStartNum = 1;
        Integer addQuantity = 200;
        allContacts.addAll(GenericContactList(1, 200));

        // Set default email address to ALL
        for (Contact currContact: allContacts) {
            currContact.email = DEFAULT_EMAIL;
        }

        // Save to DB
        Upsert allContacts;
    }
}