# Integrator - Exploring Kristian's database

[Link to Kristian's 04b github](https://github.com/kris13m/systemintegration_opgaver/tree/main/04b_besvarelse)

## Running the database

As Kristian has only provided a .sql file, I have chosen to put together a Compose file to spin up his database quickly within a container.

Kristian also has not specified what version of MySQL he is using. I am choosing to use the latest version of the previous major version 8, which is 8.4.4 at the time of writing.

The database is spun up by running:

`podman compose --file docker-compose.yml up --detach`

An interactive shell is achieved by running: 

`podman exec -ti mysql /bin/bash`

## Logging in as Bill

```
bash-5.1# mysql --user=Bill --password bank_db
Enter password:
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 33
Server version: 8.4.4 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
```

## Showing all tables

```
mysql> SHOW TABLES;
+-------------------+
| Tables_in_bank_db |
+-------------------+
| employee_view     |
| employees         |
+-------------------+
2 rows in set (0.00 sec)
```

## Doing a Select on employees table

```
mysql> SELECT * FROM employees;
+----+--------+-----------------+------------+----------+------------------+----------------+
| id | name   | email           | department | salary   | user_id          | employeeStatus |
+----+--------+-----------------+------------+----------+------------------+----------------+
|  1 | John   | john@bank.com   | Admin      | 90000.00 | John@localhost   | active         |
|  2 | Bill   | bill@bank.com   | Finance    | 50000.00 | Bill@localhost   | active         |
|  3 | Howard | howard@bank.com | Finance    | 55000.00 | Howard@localhost | active         |
+----+--------+-----------------+------------+----------+------------------+----------------+
3 rows in set (0.00 sec)
```

Kristian's README says that Bill should only be able to see his own information. 

Doing a Select on employee_view limits Bill to only seeing his own data:

```
mysql> SELECT * FROM employee_view;
+------+---------------+------------+----------+----------------+
| name | email         | department | salary   | employeeStatus |
+------+---------------+------------+----------+----------------+
| Bill | bill@bank.com | Finance    | 50000.00 | active         |
+------+---------------+------------+----------+----------------+
1 row in set (0.00 sec)
```

## Updating Howard's salary

Let's make Howard's next month one to remember.

```
mysql> UPDATE employees SET salary = 100.00 WHERE name = "Howard";
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM employees;
+----+--------+-----------------+------------+----------+------------------+----------------+
| id | name   | email           | department | salary   | user_id          | employeeStatus |
+----+--------+-----------------+------------+----------+------------------+----------------+
|  1 | John   | john@bank.com   | Admin      | 90000.00 | John@localhost   | active         |
|  2 | Bill   | bill@bank.com   | Finance    | 50000.00 | Bill@localhost   | active         |
|  3 | Howard | howard@bank.com | Finance    |   100.00 | Howard@localhost | active         |
+----+--------+-----------------+------------+----------+------------------+----------------+
3 rows in set (0.00 sec)
```

## Perusing the init script

I suspect the following lines 44 to 46 in `population.sql` are what is causing Bill, as well as other employees, to have priviliges on the employees table:

```
GRANT ALL PRIVILEGES ON bank_db.* TO 'John'@'localhost';  -- John gets all privileges on the database
GRANT ALL PRIVILEGES ON bank_db.* TO 'Bill'@'localhost';  -- Bill gets all privileges on the database
GRANT ALL PRIVILEGES ON bank_db.* TO 'Howard'@'localhost';  -- Howard gets all privileges on the database
```