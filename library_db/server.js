const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Database Connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',        // Change if different
    password: '12345',        // Change if different
    database: 'LibraryDB'
});

db.connect(err => {
    if (err) {
        console.error('Database connection failed: ' + err.message);
    } else {
        console.log('Connected to MySQL database');
    }
});

// Get all books
app.get('/books', (req, res) => {
    db.query('SELECT * FROM Books', (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// Get all users
app.get('/users', (req, res) => {
    db.query('SELECT * FROM Users', (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// Get all loans
app.get('/loans', (req, res) => {
    db.query('SELECT * FROM Loans', (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// Get all reservations
app.get('/reservations', (req, res) => {
    db.query('SELECT * FROM Reservations', (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// Get all fines
app.get('/fines', (req, res) => {
    db.query('SELECT * FROM Fines', (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// Start server
app.listen(5000, () => {
    console.log('Server is running on port 5000');
});
