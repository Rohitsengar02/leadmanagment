const Lead = require('../models/Lead');

// Create a new lead
exports.createLead = async (req, res) => {
    try {
        const newLead = new Lead(req.body);
        const savedLead = await newLead.save();
        res.status(201).json(savedLead);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// Get all leads
exports.getAllLeads = async (req, res) => {
    try {
        const leads = await Lead.find().sort({ createdAt: -1 });
        res.status(200).json(leads);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// Get single lead
exports.getLeadById = async (req, res) => {
    try {
        const lead = await Lead.findById(req.params.id);
        if (!lead) return res.status(404).json({ message: 'Lead not found' });
        res.status(200).json(lead);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// Update lead
exports.updateLead = async (req, res) => {
    try {
        const updatedLead = await Lead.findByIdAndUpdate(
            req.params.id,
            { $set: req.body, updatedAt: Date.now() },
            { new: true }
        );
        if (!updatedLead) return res.status(404).json({ message: 'Lead not found' });
        res.status(200).json(updatedLead);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// Delete lead
exports.deleteLead = async (req, res) => {
    try {
        const deletedLead = await Lead.findByIdAndDelete(req.params.id);
        if (!deletedLead) return res.status(404).json({ message: 'Lead not found' });
        res.status(200).json({ message: 'Lead deleted successfully' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};
