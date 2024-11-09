using System.Net;
using System.Net.Mail;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.Extensions.Options;

namespace WEBAPP;

public class EmailSender : IEmailSender
{
    MailSettings mailSettings;
    public EmailSender(IOptions<MailSettings> options)
    {
        mailSettings = options.Value;
    }
    public async Task SendEmailAsync(string email, string subject, string htmlMessage)
    {
        SmtpClient client = new SmtpClient
        {
            Host = mailSettings.Host,
            Port = mailSettings.Port,
            Credentials = new NetworkCredential
            {
                UserName = mailSettings.Email,
                Password = mailSettings.Password
            },
            EnableSsl = true,
            UseDefaultCredentials = false
        };
        MailMessage message = new MailMessage
        {
            From = new MailAddress(mailSettings.Email),
            Subject = subject,
            Body = htmlMessage
        };
        message.To.Add(new MailAddress(email));
        await client.SendMailAsync(message);
    }
}