const express = require('express');
const goalController = require('../controllers/goal');
const authMiddleware = require('../middleware/auth');
const router = express.Router();

router.post('/', authMiddleware, goalController.createGoal);
router.get('/', authMiddleware, goalController.getGoals);
router.put('/:id', authMiddleware, goalController.updateGoal);
router.delete('/:id', authMiddleware, goalController.deleteGoal);

module.exports = router;