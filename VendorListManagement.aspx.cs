using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace PO_ASSIGNMENT
{
	public partial class VendorListManagement : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            try
            {
                if (!IsPostBack)
                {

                }

            }
            catch (Exception ex)
            {

            }

        }

        [WebMethod]
        public static List<Vendor> GetVendorData()
        {

            try
            {
                DatabaseUtility dbUtility = new DatabaseUtility();
                DataTable resultTable = dbUtility.ExecuteBindVendorStoredProcedure("BindGetVendorNames");

                List<Vendor> vendors = new List<Vendor>();
                foreach (DataRow row in resultTable.Rows)
                {
                    Vendor vendor = new Vendor
                    {
                        vendorCode = Convert.ToString(row["Code"]),
                        name = row["Name"].ToString(),
                        number = row["ContactEmail"].ToString(),
                        email = row["ContactNo"].ToString(),
                        validTillDate = row["ValidTillDate"].ToString(),
                        isActive = row["IsActive"].ToString()
                    };
                    vendors.Add(vendor);
                }

                return (vendors);

            }
            catch (Exception ex)
            {
                throw;
            }
            
        }

        [WebMethod]
        public static string DeleteVendor(Vendor vendorCode)
        {
            try
            {
                string code = vendorCode.vendorCode;
                DatabaseUtility dbUtility = new DatabaseUtility();
                dbUtility.DeleteVendorData(code);
                return "success";
            }
            catch (Exception ex)
            {
                return "Failed" + ex.Message;

            }

        }

    }

    public class Vendor
    {
        public string vendorCode { get; set; }
        public string name { get; set; }
        public string number { get; set; }
        public string email { get; set; }
        public string validTillDate { get; set; }
        public string isActive { get; set; }
    }
}