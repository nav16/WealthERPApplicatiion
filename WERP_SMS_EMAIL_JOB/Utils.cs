﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Configuration;
using System.Net.Mime;
using System.Net.Mail;
using System.Collections;
using System.IO;
using BoCommon;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;


namespace WERP_SMS_EMAIL_JOB
{
    class Utils
    {
        private static string _SMTPServer = ConfigurationSettings.AppSettings["SMTPServer"];
        private static int _SMTPPort = int.Parse(ConfigurationSettings.AppSettings["SMTPPort"]);
        private static string _SMTPUsername = Encryption.Decrypt(ConfigurationSettings.AppSettings["SMTPUsername"]);
        private static string _SMTPPassword = Encryption.Decrypt(ConfigurationSettings.AppSettings["SMTPPassword"]);
        private static string _SMTPFromDisplay = ConfigurationSettings.AppSettings["SMTPFromDisplay"];
        private static string _SMTPFrom = ConfigurationSettings.AppSettings["SMTPFrom"];
        private static bool _SMTPDefaultCredentials=false;

        private static string _SMSURL = ConfigurationSettings.AppSettings["SMSURL"];
        private static string _SMSUsername = Encryption.Decrypt(ConfigurationSettings.AppSettings["SMSUsername"]);
        private static string _SMSPassword = Encryption.Decrypt(ConfigurationSettings.AppSettings["SMSPassword"]);

      

        public static DataSet ExecuteDataSet(string CommandText, SqlParameter[] Params)
        {
            Database D = DatabaseFactory.CreateDatabase("DBConnectionString");
            DbCommand DC = D.GetStoredProcCommand(CommandText);

            foreach (SqlParameter Param in Params)
            {
                D.AddInParameter(DC, Param.ParameterName, Param.DbType, Param.Value);
            }
            DataSet DS = D.ExecuteDataSet(DC);

            return DS;
        }

        public static void ExecuteNonQuery(string CommandText, SqlParameter[] Params)
        {
            Database D = DatabaseFactory.CreateDatabase("DBConnectionString");
            DbCommand DC = D.GetStoredProcCommand(CommandText);

            foreach (SqlParameter Param in Params)
            {
                D.AddInParameter(DC, Param.ParameterName, Param.DbType, Param.Value);
            }
            D.ExecuteNonQuery(DC);
        }

        public static void LogError(string Msg)
        {
            Console.WriteLine(DateTime.Now.ToString() + ": " + Msg);
        }

        public static void Trace(string Msg)
        {
            Console.WriteLine(DateTime.Now.ToString() + ": " + Msg);
        }

        public static void SendMail(string To, string Cc, string Bcc, string Subject, string Body, ArrayList Attachments, string from, DataTable dtAdviserSMTP)
        {          
                                     
              //SetAdviserSMTP(dtAdviserSMTP, from);
              
             
              SmtpClient smtpClient = new SmtpClient();
              MailMessage mail = new MailMessage(_SMTPFromDisplay, To);

              if (_SMTPDefaultCredentials == false)
              {
                  NetworkCredential basicCredential = new NetworkCredential(_SMTPUsername, _SMTPPassword);
                  smtpClient.UseDefaultCredentials = false;
                  smtpClient.Credentials = basicCredential;
              }
              else
              {
                  smtpClient.UseDefaultCredentials = true;
              }

                smtpClient.Host = _SMTPServer;
                if (_SMTPPort > 0)
                    smtpClient.Port = _SMTPPort;

                //Hardcoding SSL settings for gmail SMTP
                if (_SMTPServer.Contains("smtp.gmail.com") || _SMTPServer.Contains("smtp.live.com"))
                {
                    smtpClient.EnableSsl = true;
                    
                }
                if (!string.IsNullOrEmpty(_SMTPFromDisplay.Trim()))
                {
                    MailAddress md1 = new MailAddress(_SMTPUsername, _SMTPFromDisplay);
                    mail.From = md1;

                    if (!string.IsNullOrEmpty(from.Trim()))
                    {
                        MailAddress md3 = new MailAddress(from, _SMTPFromDisplay);
                        mail.ReplyTo = md3;
                    }
                }
                             
                 
               
                
               mail.Subject = Subject;
               mail.IsBodyHtml = false;
               mail.Body = Body;       

               smtpClient.Send(mail);         

           
        }

        public static void SetAdviserSMTP(DataTable dtAdviserSMTP, string from)
        {

            if (!string.IsNullOrEmpty(from.Trim()))
                _SMTPFrom = from;

            if (dtAdviserSMTP.Rows.Count > 0)
            {
                _SMTPServer = dtAdviserSMTP.Rows[0]["ASS_HostServer"].ToString();
                _SMTPPort = Convert.ToInt32(dtAdviserSMTP.Rows[0]["ASS_Port"].ToString());
                _SMTPUsername = dtAdviserSMTP.Rows[0]["ASS_Email"].ToString();
                _SMTPPassword = Encryption.Decrypt(dtAdviserSMTP.Rows[0]["ASS_Password"].ToString());
                _SMTPFromDisplay = dtAdviserSMTP.Rows[0]["ASS_SenderEmailAlias"].ToString();
                if (!string.IsNullOrEmpty(_SMTPFromDisplay) && !string.IsNullOrEmpty(_SMTPFrom))
                {
                    _SMTPFromDisplay = _SMTPFromDisplay + " <" + _SMTPFrom + ">";
                    _SMTPFrom = _SMTPFromDisplay;
                }
                _SMTPDefaultCredentials = !Convert.ToBoolean(Convert.ToInt16(dtAdviserSMTP.Rows[0]["ASS_IsAuthenticationRequired"].ToString()));
            }

            
            

        }



        public static string SendSMS(Dictionary<string, string> SMSDetails)
        {
            string message = SMSDetails["MESSAGE"].ToString();
            string number = SMSDetails["NUMBER"].ToString();
            _SMSURL = SMSDetails["SMSAPI"].ToString();
            _SMSUsername = SMSDetails["USERNAME"].ToString();
            _SMSPassword = SMSDetails["PASSWORD"].ToString();

            if (message.Length > 150)
                message = message.Substring(0, 150);

            string URL = _SMSURL.Replace("#NUMBER#", number);
            // URL = URL.Replace("#MESSAGE#", HttpUtility.UrlEncode(Message));
            URL = URL.Replace("#MESSAGE#", message);
            URL = URL.Replace("#USERNAME#", _SMSUsername);
            URL = URL.Replace("#PASSWORD#", _SMSPassword);
            string Response = GetURL(URL);

            if (Response.IndexOf("Successfully") == -1)
            {
                throw new Exception("SMS-Send Failed: " + Response);

            }
            else
                return "SMS-Send Successfully:" + Response;
        }

        public static string GetURL(string URL)
        {
            string Response = "";
            WebRequest WR = (WebRequest)HttpWebRequest.Create(URL);
            Response = new StreamReader(WR.GetResponse().GetResponseStream()).ReadToEnd();

            return Response;
        }
    }
}
