const db = require('../models/db');

exports.createGoal = (req, res) => {
    const { accountId, targetAmount, description } = req.body;
    const query = 'INSERT INTO goals (account_id, target_amount, description) VALUES (?, ?, ?)';
    db.query(query, [accountId, targetAmount, description], (err, result) => {
        if (err) return res.status(500).send(err);
        res.status(201).send({ message: 'Goal created successfully' });
    });
};

exports.getGoals = (req, res) => {
    const userId = req.user.id;
    const query = `
        SELECT g.id, g.account_id, g.target_amount, g.description 
        FROM goals g
        JOIN accounts a ON g.account_id = a.id
        WHERE a.user_id = ?`;
    db.query(query, [userId], (err, results) => {
        if (err) return res.status(500).send(err);
        res.send(results);
    });
};

exports.updateGoal = (req, res) => {
    const { targetAmount, description } = req.body;
    const goalId = req.params.id;
    const userId = req.user.id;
    const query = `
        UPDATE goals g
        JOIN accounts a ON g.account_id = a.id
        SET g.target_amount = ?, g.description = ?
        WHERE g.id = ? AND a.user_id = ?`;
    db.query(query, [targetAmount, description, goalId, userId], (err, result) => {
        if (err) return res.status(500).send(err);
        if (result.affectedRows === 0) return res.status(404).send({ message: 'Goal not found' });
        res.status(200).send({ message: 'Goal updated successfully' });
    });
};

exports.deleteGoal = (req, res) => {
    const goalId = req.params.id;
    const userId = req.user.id;
    const query = `
        DELETE g FROM goals g
        JOIN accounts a ON g.account_id = a.id
        WHERE g.id = ? AND a.user_id = ?`;
    db.query(query, [goalId, userId], (err, result) => {
        if (err) return res.status(500).send(err);
        if (result.affectedRows === 0) return res.status(404).send({ message: 'Goal not found' });
        res.status(200).send({ message: 'Goal deleted successfully' });
    });
};