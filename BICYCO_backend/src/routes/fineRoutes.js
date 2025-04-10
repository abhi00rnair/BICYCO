const express = require('express');
const router = express.Router();
const FineController = require('../controllers/fineController');
const authMiddleware = require('../middleware/authMiddleware');

// Issue a fine (Admin only)
router.post('/issue', authMiddleware, FineController.issueFine);

// Mark fine as paid (User/Admin)
router.put('/pay/:id', authMiddleware, FineController.markFineAsPaid);

// Get all unpaid fines for a user
router.get('/unpaid', authMiddleware, FineController.getUnpaidFines);

module.exports = router;
