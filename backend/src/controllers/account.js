const db = require('../models/db');

exports.createAccount = (req, res) => {
    const { name, balance } = req.body;
    const userId = req.user.id;
    const query = 'INSERT INTO accounts (user_id, name, balance) VALUES (?, ?, ?)';
    db.query(query, [userId, name, balance], (err, result) => {
        if (err) return res.status(500).send(err);
        res.status(201).send({ message: 'Account created successfully' });
    });
};

exports.getAccounts = (req, res) => {
    const userId = req.user.id;
    const query = 'SELECT * FROM accounts WHERE user_id = ?';
    db.query(query, [userId], (err, results) => {
        if (err) return res.status(500).send(err);
        res.send(results);
    });
};

exports.updateAccount = (req, res) => {
    const { name, balance } = req.body;
    const accountId = req.params.id;
    const userId = req.user.id;
    const query = 'UPDATE accounts SET name = ?, balance = ? WHERE id = ? AND user_id = ?';
    db.query(query, [name, balance, accountId, userId], (err, result) => {
        if (err) return res.status(500).send(err);
        if (result.affectedRows === 0) return res.status(404).send({ message: 'Account not found' });
        res.status(200).send({ message: 'Account updated successfully' });
    });
};

exports.deleteAccount = (req, res) => {
    const accountId = req.params.id;
    const userId = req.user.id;
    const query = 'DELETE FROM accounts WHERE id = ? AND user_id = ?';
    db.query(query, [accountId, userId], (err, result) => {
        if (err) return res.status(500).send(err);
        if (result.affectedRows === 0) return res.status(404).send({ message: 'Account not found' });
        res.status(200).send({ message: 'Account deleted successfully' });
    });
};