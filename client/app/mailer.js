import NodeMailer from 'nodemailer';

const smtpTransport =
  NodeMailer.createTransport('SMTP', {
    service: 'Gmail',
    auth: {
      user: 'sam.david.thornton@gmail.com',
      pass: 'fhatsiptepyptukn'
    }
  });

const mailOptions = {
  from: 'Contact Mailer <contact@sam-thornton.com>',
  to: 'mail@sam-thornton.com',
  subject: 'New Contact',
  text: 'Yay! You got an email!',
};
