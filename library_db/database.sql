CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    role ENUM('member', 'staff') DEFAULT 'member',
    registered_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories Table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);

-- Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    category_id INT,
    total_copies INT NOT NULL,
    available_copies INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Loans Table
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    book_id INT,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    fine DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Reservations Table
CREATE TABLE Reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    book_id INT,
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Fines Table
CREATE TABLE Fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    loan_id INT,
    amount DECIMAL(5,2) NOT NULL,
    status ENUM('unpaid', 'paid') DEFAULT 'unpaid',
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);

-- Insert sample users
INSERT INTO Users (name, email, phone, role) VALUES
('John Doe', 'john@example.com', '9876543210', 'member'),
('Jane Smith', 'jane@example.com', '8765432109', 'staff'),
('Alice Johnson', 'alice@example.com', '7654321098', 'member'),
('Bob Williams', 'bob@example.com', '6543210987', 'member'),
('Charlie Brown', 'charlie@example.com', '5432109876', 'staff');

-- Insert sample categories
INSERT INTO Categories (category_name) VALUES
('Fiction'),
('Science'),
('History'),
('Technology'),
('Philosophy');

-- Insert sample books
INSERT INTO Books (title, author, isbn, category_id, total_copies, available_copies) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 1, 5, 3),
('A Brief History of Time', 'Stephen Hawking', '9780553380163', 2, 3, 2),
('Sapiens', 'Yuval Noah Harari', '9780099590088', 3, 4, 4),
('Clean Code', 'Robert C. Martin', '9780132350884', 4, 6, 5),
('The Republic', 'Plato', '9780140455113', 5, 2, 1);

-- Insert sample loans
INSERT INTO Loans (user_id, book_id, issue_date, due_date, return_date, fine) VALUES
(1, 1, '2024-02-01', '2024-02-15', NULL, 0),
(2, 2, '2024-02-05', '2024-02-19', '2024-02-18', 0),
(3, 3, '2024-02-07', '2024-02-21', NULL, 5.00),
(4, 4, '2024-02-10', '2024-02-24', '2024-02-23', 0),
(5, 5, '2024-02-12', '2024-02-26', NULL, 2.00);

-- Insert sample reservations
INSERT INTO Reservations (user_id, book_id, reservation_date, status) VALUES
(1, 2, '2024-02-01 10:00:00', 'pending'),
(2, 3, '2024-02-02 11:30:00', 'completed'),
(3, 4, '2024-02-03 14:45:00', 'cancelled'),
(4, 5, '2024-02-04 09:15:00', 'pending'),
(5, 1, '2024-02-05 16:20:00', 'pending');

-- Insert sample fines
INSERT INTO Fines (user_id, loan_id, amount, status) VALUES
(3, 3, 5.00, 'unpaid'),
(5, 5, 2.00, 'unpaid'),
(1, 1, 0.00, 'paid'),
(2, 2, 0.00, 'paid'),
(4, 4, 0.00, 'paid');


-- Select all users
SELECT * FROM Users;

-- Select all categories
SELECT * FROM Categories;

-- Select all books
SELECT * FROM Books;

-- Select all loans
SELECT * FROM Loans;

-- Select all reservations
SELECT * FROM Reservations;

-- Select all fines
SELECT * FROM Fines;
