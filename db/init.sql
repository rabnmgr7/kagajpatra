-- db/init.sql

CREATE DATABASE IF NOT EXISTS kagajpatra;
USE kagajpatra;

CREATE TABLE IF NOT EXISTS documents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    filename VARCHAR(255) NOT NULL
);
