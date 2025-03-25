const Fine = require('../models/Fine');

const FineController = {
    async issueFine(req, res) {
        try {
            const { userId, bookingId, amount } = req.body;

            if (!userId || !bookingId || !amount) {
                return res.status(400).json({ message: "User ID, Booking ID, and Amount are required" });
            }

            const newFine = await Fine.issueFine(userId, bookingId, amount);
            res.status(201).json(newFine);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },

    async markFineAsPaid(req, res) {
        try {
            const { id } = req.params;

            const updatedFine = await Fine.markFineAsPaid(id);
            if (!updatedFine) {
                return res.status(404).json({ message: "Fine not found" });
            }

            res.json(updatedFine);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },

    async getUnpaidFines(req, res) {
        try {
            const userId = req.user.id;
            const unpaidFines = await Fine.getUnpaidFines(userId);
            res.json(unpaidFines);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }
};

module.exports = FineController;
