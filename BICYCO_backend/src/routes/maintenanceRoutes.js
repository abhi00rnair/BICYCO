const express = require('express');
const router = express.Router();
const MaintenanceController = require('../controllers/maintenanceController');
const authMiddleware = require('../middleware/authMiddleware');

// Report a maintenance issue (User/Admin)
router.post('/report', authMiddleware, MaintenanceController.reportIssue);

// Update maintenance status (Admin only)
router.put('/update/:id', authMiddleware, MaintenanceController.updateStatus);

// Get all pending maintenance issues
router.get('/pending', authMiddleware, MaintenanceController.getPendingIssues);

module.exports = router;
