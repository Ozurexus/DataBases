drop table IF EXISTS accounts cascade;
CREATE TABLE IF NOT EXISTS accounts (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    credit FLOAT NOT NULL,
    currency VARCHAR(10) NOT NULL
);
INSERT INTO accounts (id, name, credit, currency) 
VALUES (1, 'Account 1', 1000, 'RUB'),
       (2, 'Account 2', 1000, 'RUB'),
       (3, 'Account 3', 1000, 'RUB');
begin transaction;
	savepoint saver;
    UPDATE accounts SET credit = credit - 500 WHERE id = 1;
    UPDATE accounts SET credit = credit + 500 WHERE id = 3;	
    UPDATE accounts SET credit = credit - 700 WHERE id = 2;
	UPDATE accounts SET credit = credit + 700 WHERE id = 1;
	UPDATE accounts SET credit = credit - 100 WHERE id = 2;
	UPDATE accounts SET credit = credit + 100 WHERE id = 3;
	rollback to savepoint saver;
commit;
SELECT * from accounts;