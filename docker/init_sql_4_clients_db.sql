CREATE DATABASE clients_db;
CREATE USER 'sip_user'@'%' IDENTIFIED BY '123';
CREATE USER 'sip_user'@'localhost' IDENTIFIED BY '123';

GRANT ALL PRIVILEGES ON clients_db.* TO 'sip_user'@'%';
GRANT ALL PRIVILEGES ON clients_db.* TO 'sip_user'@'localhost';

