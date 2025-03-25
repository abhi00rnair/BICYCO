const Maintenance = require('../models/Maintenance');

const MaintenanceController = {
    async reportIssue(req, res) {
        try {
            const { cycleId, issueDescription } = req.body;
            const userId = req.user.id;

            if (!cycleId || !issueDescription) {
                return res.status(400).json({ message: "Cycle ID and issue description are required" });
            }

            const newIssue = await Maintenance.reportIssue(cycleId, userId, issueDescription);
            res.status(201).json(newIssue);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },

    async updateStatus(req, res) {
        try {
            const { id } = req.params;
            const { status } = req.body;
            const allowedStatuses = ['pending', 'in_progress', 'resolved'];

            if (!allowedStatuses.includes(status)) {
                return res.status(400).json({ message: "Invalid status" });
            }

            const updatedIssue = await Maintenance.updateStatus(id, status, status === 'resolved' ? new Date() : null);
            if (!updatedIssue) {
                return res.status(404).json({ message: "Maintenance issue not found" });
            }

            res.json(updatedIssue);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },

    async getPendingIssues(req, res) {
        try {
            const pendingIssues = await Maintenance.getPendingIssues();
            res.json(pendingIssues);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }
};

module.exports = MaintenanceController;
