const nodemailer = require('nodemailer');
require('dotenv').config();

const transporter = nodemailer.createTransport({
    service: 'gmail', // Use any email provider (e.g., SMTP server)
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
    }
});

const EmailService = {
    async sendEmail(to, subject, text) {
        const mailOptions = {
            from: process.env.EMAIL_USER,
            to,
            subject,
            text
        };

        try {
            await transporter.sendMail(mailOptions);
            console.log(`📧 Email sent to ${to}`);
        } catch (err) {
            console.error("❌ Error sending email:", err);
        }
    }
};

module.exports = EmailService;
