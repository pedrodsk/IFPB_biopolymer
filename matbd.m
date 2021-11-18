conn = database('Saab Matlab','','');
sqlquery = 'CREATE TABLE Persons (PersonID int,LastName varchar(255),FirstName varchar(255),Address varchar(255),City varchar(255));';
curs = exec(conn,sqlquery);
close(conn);