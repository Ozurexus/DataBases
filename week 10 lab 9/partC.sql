drop table IF EXISTS accounts cascade;
CREATE TABLE IF NOT EXISTS accounts (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    credit FLOAT NOT NULL,
    currency VARCHAR(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS Ledger (
    ID INT PRIMARY KEY,
    FromID INT NOT NULL,
    ToID INT NOT NULL,
    Fee FLOAT NOT NULL,
    Amount FLOAT NOT NULL,
    TransactionDateTime TIMESTAMP NOT NULL
);
ALTER TABLE accounts ADD COLUMN BankName VARCHAR(50) NOT NULL;
INSERT INTO accounts (id, name, credit, currency, BankName) 
VALUES (1, 'Account 1', 1000, 'RUB', 'Sberbank'),
       (2, 'Account 2', 1000, 'RUB', 'Tinkoff'),
       (3, 'Account 3', 1000, 'RUB', 'Sberbank'),
       (4, 'Account 4', 0, 'RUB', 'Fees');
CREATE OR REPLACE FUNCTION transfer_money(from_acc_id INT, to_acc_id INT, amount FLOAT) RETURNS void AS $$
DECLARE
    from_acc_bank_name VARCHAR(50);
    to_acc_bank_name VARCHAR(50);
    from_acc_credit FLOAT;
    to_acc_credit FLOAT;
    fee FLOAT;
BEGIN
    SELECT credit, bankname INTO from_acc_credit, from_acc_bank_name FROM accounts WHERE id = from_acc_id;
    SELECT credit, bankname INTO to_acc_credit, to_acc_bank_name FROM accounts WHERE id = to_acc_id;
    SELECT count(*) INTO fee FROM Ledger;
    IF from_acc_bank_name = to_acc_bank_name THEN
        UPDATE accounts SET credit = from_acc_credit - amount WHERE id = from_acc_id;
        UPDATE accounts SET credit = to_acc_credit + amount WHERE id = to_acc_id;
        INSERT INTO Ledger (ID, FromID, ToID, Fee, Amount, TransactionDateTime) VALUES (fee, from_acc_id, to_acc_id, 0, amount, now());
    ELSE
        UPDATE accounts SET credit = from_acc_credit - amount - 30 WHERE id = from_acc_id;
        UPDATE accounts SET credit = to_acc_credit + amount WHERE id = to_acc_id;
        UPDATE accounts SET credit = credit + 30 WHERE id = 4;
        INSERT INTO Ledger (ID, FromID, ToID, Fee, Amount, TransactionDateTime) VALUES (fee, from_acc_id, to_acc_id, 30, amount, now());
    END IF;
END;
$$ LANGUAGE plpgsql;
begin transaction;
	savepoint saver;
    SELECT transfer_money(1, 3, 500);
    SELECT transfer_money(2, 1, 700);
    SELECT transfer_money(2, 3, 100);
commit;
SELECT * from ledger;
