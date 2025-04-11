const Cycle = require('../models/Cycle');

const CycleController = {
    async getAvailableCycles(req, res) {
        try {
            const cycles = await Cycle.getAvailableCycles();
            res.json(cycles);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },

    async addCycle(req, res) {
        try {
            const { cycleNumber, location } = req.body;
            if (!cycleNumber || !location) {
                return res.status(400).json({ message: "Cycle number and location are required" });
            }

            const newCycle = await Cycle.addCycle(cycleNumber, location);
            res.status(201).json(newCycle);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },

    async updateCycleStatus(req, res) {
        try {
            const { id } = req.params;
            const { status } = req.body;
            const allowedStatuses = ['available', 'booked', 'maintenance'];

            if (!allowedStatuses.includes(status)) {
                return res.status(400).json({ message: "Invalid status" });
            }

            const updatedCycle = await Cycle.updateCycleStatus(id, status);
            if (!updatedCycle) {
                return res.status(404).json({ message: "Cycle not found" });
            }

            res.json(updatedCycle);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }
};

module.exports = CycleController;
