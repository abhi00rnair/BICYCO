const Booking = require('../models/Booking');
const Cycle = require('../models/Cycle');

const BookingController = {
    async createBooking(req, res) {
        try {
            const userId = req.user.id;
            const { cycleId } = req.body;

            if (!cycleId) {
                return res.status(400).json({ message: "Cycle ID is required" });
            }

            // Check if the user already has an active booking
            const activeBookings = await Booking.getActiveBookingsByUser(userId);
            if (activeBookings.length > 0) {
                return res.status(400).json({ message: "You already have an active booking" });
            }

            // Create booking
            const newBooking = await Booking.createBooking(userId, cycleId);

            // Update cycle status
            await Cycle.updateCycleStatus(cycleId, 'booked');

            res.status(201).json(newBooking);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },

    async completeBooking(req, res) {
        try {
            const { id } = req.params;
            const { fineAmount } = req.body || 0;
            const endTime = new Date();

            const completedBooking = await Booking.completeBooking(id, endTime, fineAmount);

            // Update cycle status to available
            await Cycle.updateCycleStatus(completedBooking.cycle_id, 'available');

            res.json(completedBooking);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },

    async getActiveBookingsByUser(req, res) {
        try {
            const userId = req.user.id;
            const activeBookings = await Booking.getActiveBookingsByUser(userId);
            res.json(activeBookings);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }
};

module.exports = BookingController;
