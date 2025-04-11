const express = require('express');
const router = express.Router();
const BookingController = require('../controllers/bookingController');
const authMiddleware = require('../middleware/authMiddleware');

// Book a cycle (User only)
router.post('/book', authMiddleware, BookingController.createBooking);

// Complete a booking (User/Admin)
router.put('/complete/:id', authMiddleware, BookingController.completeBooking);

// Get active bookings for a user
router.get('/active', authMiddleware, BookingController.getActiveBookingsByUser);

module.exports = router;
