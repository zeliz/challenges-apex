# Apex Challenges

## SETUP:
1) Authenticate VS Code to SF Playground
2) RUN: sfdx force:source:deploy -x .\manifest\package.xml
3) Enter playground developer console
4) Ctrl+e
5) Run one of the following:

MyFirstClass c = new MyFirstClass();
c.Add151Accounts();

OR 

MyFirstClass c = new MyFirstClass();
c.DeleteAccounts1to151();

OR 

MyFirstClass c = new MyFirstClass();
c.ProvideContactDetails();

OR 

MyFirstClass c = new MyFirstClass();
c.public void Create200GenericContacts();