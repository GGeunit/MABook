const express = require('express');
const regularExpenseController = require('../controllers/regularExpense');
const authMiddleware = require('../middleware/auth');
const router = express.Router();

router.post('/', authMiddleware, regularExpenseController.createRegularExpense);
router.get('/', authMiddleware, regularExpenseController.getRegularExpenses);
router.put('/:id', authMiddleware, regularExpenseController.updateRegularExpense);
router.delete('/:id', authMiddleware, regularExpenseController.deleteRegularExpense);

module.exports = router;