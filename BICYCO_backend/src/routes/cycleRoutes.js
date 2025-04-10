const express = require('express');
const router = express.Router();
const CycleController = require('../controllers/cycleController');
const authMiddleware = require('../middleware/authMiddleware');

// Get all available cycles
router.get('/available', CycleController.getAvailableCycles);

// Add a new cycle (Admin only)
router.post('/add', authMiddleware, CycleController.addCycle);

// Update cycle status (Admin only)
router.put('/update/:id', authMiddleware, CycleController.updateCycleStatus);

module.exports = router;
