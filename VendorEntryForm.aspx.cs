﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;

namespace PO_ASSIGNMENT
{
	public partial class VendorEntryForm : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack) {

                   
                }
            }
            catch (Exception ex)
            { 

            }
        }

        [WebMethod]
        public static string InsertVendorOrder(OrderData orderData)
        {
            try
            {
                DatabaseUtility dbUtility = new DatabaseUtility();

                string code = orderData.VendorCode.Trim();
                string name = orderData.Name.Trim();
                string addressLine1 = orderData.AddressLine1;
                string addressLine2 = orderData.AddressLine2;
                string contactEmail = orderData.Email;
                string contactNo = orderData.Number;
                DateTime validTillDate = DateTime.Parse(orderData.ValidDate.ToString());
				string isActive = orderData.IsActive.ToString();

				dbUtility.ExecuteVendorInsertProcedure(code, name, addressLine1, addressLine2, contactEmail, contactNo, validTillDate, isActive);
				return "success";
            }
            catch (Exception ex)
            {
                // Log the error
                return "error: " + ex.Message;
            }
        }

        public class OrderData
        {
            public string VendorCode { get; set; }
            public string Name { get; set; }
            public string AddressLine1 { get; set; }
            public string AddressLine2 { get; set; }
            public string Email { get; set; }
            public string Number { get; set; }
            public DateTime ValidDate { get; set; }
            public bool IsActive { get; set; }
            
        }
    }
}