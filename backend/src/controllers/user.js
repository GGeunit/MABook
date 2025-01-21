const db = require('../models/db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

exports.register = (req, res) => {
    const { username, password } = req.body;
    const hash = bcrypt.hashSync(password, 10);
    const query = 'INSERT INTO users (username, password) VALUES (?, ?)';
    db.query(query, [username, hash], (err, result) => {
        if (err) return res.status(500).send(err);
        res.status(201).send({ message: 'User registered successfully' });
    });
};

exports.login = (req, res) => {
    const { username, password } = req.body;
    const query = 'SELECT * FROM users WHERE username = ?';
    db.query(query, [username], (err, results) => {
        if (err) return res.status(500).send(err);
        if (results.length === 0) return res.status(404).send({ message: 'User not found' });
        const user = results[0];
        if (!bcrypt.compareSync(password, user.password)) {
            return res.status(401).send({ message: 'Invalid password' });
        }
        const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1h' });
        res.send({ token });
    });
};