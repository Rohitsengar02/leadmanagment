const mongoose = require('mongoose');

const LeadSchema = new mongoose.Schema({
    name: { type: String, required: true },
    email: { type: String, required: false },
    phone: { type: String, required: false },
    company: { type: String, required: false },
    source: { type: String, default: 'Manual' },
    status: { type: String, default: 'New', enum: ['New', 'Contacted', 'Qualified', 'Proposal', 'Negotiation', 'Won', 'Lost'] },
    dealValue: { type: Number, default: 0 },
    priority: { type: String, default: 'Medium', enum: ['Low', 'Medium', 'High', 'Urgent 🔥'] },
    tags: [{ type: String }],
    notes: [{ type: String }],
    assignedTo: { type: String },
    expectedCloseDate: { type: Date },
    createdAt: { type: Date, default: Date.now },
    updatedAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Lead', LeadSchema);
