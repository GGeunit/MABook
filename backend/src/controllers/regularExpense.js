const db = require('../models/db');

exports.createRegularExpense = (req, res) => {
    const { accountId, amount, description, dayOfMonth } = req.body;
    const query = 'INSERT INTO regular_expenses (account_id, amount, description, day_of_month) VALUES (?, ?, ?, ?)';
    db.query(query, [accountId, amount, description, dayOfMonth], (err, result) => {
        if (err) return res.status(500).send(err);
        res.status(201).send({ message: 'Regular expense created successfully' });
    });
};

exports.getRegularExpenses = (req, res) => {
    const userId = req.user.id;
    const query = `
        SELECT re.id, re.account_id, re.amount, re.description, re.day_of_month
        FROM regular_expenses re
        JOIN accounts a ON re.account_id = a.id
        WHERE a.user_id = ?`;
    db.query(query, [userId], (err, results) => {
        if (err) return res.status(500).send(err);
        res.send(results);
    });
};

exports.updateRegularExpense = (req, res) => {
    const { amount, description, dayOfMonth } = req.body;
    const regularExpenseId = req.params.id;
    const userId = req.user.id;
    const query = `
        UPDATE regular_expenses re
        JOIN accounts a ON re.account_id = a.id
        SET re.amount = ?, re.description = ?, re.day_of_month = ?
        WHERE re.id = ? AND a.user_id = ?`;
    db.query(query, [amount, description, dayOfMonth, regularExpenseId, userId], (err, result) => {
        if (err) return res.status(500).send(err);
        if (result.affectedRows === 0) return res.status(404).send({ message: 'Regular expense not found' });
        res.status(200).send({ message: 'Regular expense updated successfully' });
    });
};

exports.deleteRegularExpense = (req, res) => {
    const regularExpenseId = req.params.id;
    const userId = req.user.id;
    const query = `
        DELETE re FROM regular_expenses re
        JOIN accounts a ON re.account_id = a.id
        WHERE re.id = ? AND a.user_id = ?`;
    db.query(query, [regularExpenseId, userId], (err, result) => {
        if (err) return res.status(500).send(err);
        if (result.affectedRows === 0) return res.status(404).send({ message: 'Regular expense not found' });
        res.status(200).send({ message: 'Regular expense deleted successfully' });
    });
};