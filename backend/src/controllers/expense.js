const db = require('../models/db');

exports.createExpense = (req, res) => {
    const { accountId, amount, description, date } = req.body;
    const query = 'INSERT INTO expenses (account_id, amount, description, date) VALUES (?, ?, ?, ?)';
    db.query(query, [accountId, amount, description, date], (err, result) => {
        if (err) return res.status(500).send(err);
        res.status(201).send({ message: 'Expense created successfully' });
    });
};

exports.getExpenses = (req, res) => {
    const userId = req.user.id;
    const query = `
        SELECT e.id, e.account_id, e.amount, e.description, e.date 
        FROM expenses e
        JOIN accounts a ON e.account_id = a.id
        WHERE a.user_id = ?`;
    db.query(query, [userId], (err, results) => {
        if (err) return res.status(500).send(err);
        res.send(results);
    });
};

exports.updateExpense = (req, res) => {
    const { amount, description, date } = req.body;
    const expenseId = req.params.id;
    const userId = req.user.id;
    const query = `
        UPDATE expenses e
        JOIN accounts a ON e.account_id = a.id
        SET e.amount = ?, e.description = ?, e.date = ?
        WHERE e.id = ? AND a.user_id = ?`;
    db.query(query, [amount, description, date, expenseId, userId], (err, result) => {
        if (err) return res.status(500).send(err);
        if (result.affectedRows === 0) return res.status(404).send({ message: 'Expense not found' });
        res.status(200).send({ message: 'Expense updated successfully' });
    });
};

exports.deleteExpense = (req, res) => {
    const expenseId = req.params.id;
    const userId = req.user.id;
    const query = `
        DELETE e FROM expenses e
        JOIN accounts a ON e.account_id = a.id
        WHERE e.id = ? AND a.user_id = ?`;
    db.query(query, [expenseId, userId], (err, result) => {
        if (err) return res.status(500).send(err);
        if (result.affectedRows === 0) return res.status(404).send({ message: 'Expense not found' });
        res.status(200).send({ message: 'Expense deleted successfully' });
    });
};