using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using Newtonsoft.Json;


namespace PO_ASSIGNMENT
{
    public partial class PurchaseOrderEntry : System.Web.UI.Page
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

        //[WebMethod]
        //public static string SavePurchaseOrder(OrderData orderData) 
        //{ 

        //}


        [WebMethod]
        public static List<Vendor> GetVendorNames()
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
                        Code = Convert.ToString(row["Code"]),
                        VendorName = row["Name"].ToString()
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
        public static List<MaterialOption> GetMaterialCode()
        {
            List<MaterialOption> codeOptions = new List<MaterialOption>();
            try
            {
                DatabaseUtility dbUtility = new DatabaseUtility();

                DataTable resultTable = dbUtility.ExecuteBindMaterialStoredProcedure("GetBindFetchMaterialsDetails");

                
                foreach (DataRow row in resultTable.Rows)
                {
                    MaterialOption option = new MaterialOption
                    {
                        Code = row["Code"].ToString()
                    };
                    codeOptions.Add(option);
                }  
            }
            catch (Exception ex) 
            { 
            
            }

            return codeOptions;
        }

        [WebMethod]
        public static List<MaterialOption> GetShortTextOptions()
        {
            List<MaterialOption> shortTextOptions = new List<MaterialOption>();

            try
            {
                DatabaseUtility dbUtility = new DatabaseUtility();
                DataTable resultTable = dbUtility.ExecuteBindMaterialStoredProcedure("GetBindFetchMaterialsDetails");

                foreach (DataRow row in resultTable.Rows)
                {
                    MaterialOption option = new MaterialOption
                    {
                        ShortText = row["ShortText"].ToString()
                    };
                    shortTextOptions.Add(option);
                }

            }
            catch (Exception ex) 
            { 

            }
            return shortTextOptions;

        }
        [WebMethod]
        public static List<MaterialOption> GetUnitByCode(string selectedCode)
        {
            List<MaterialOption> codeOptions = new List<MaterialOption>();
            try
            {
                DatabaseUtility dbUtility = new DatabaseUtility();

                DataTable resultTable = dbUtility.ExecuteBindMaterialStoredProcedure("GetBindFetchMaterialsDetails",
                    new SqlParameter("@SelectedCode", selectedCode));


                foreach (DataRow row in resultTable.Rows)
                {
                    MaterialOption option = new MaterialOption
                    {
                        //Code = row["Code"].ToString(),
                        //ShortText = row["ShortText"].ToString(),
                        Unit = row["Unit"].ToString()
                    };
                    codeOptions.Add(option);
                }
            }
            catch (Exception exception)
            {

            }

            return codeOptions;
        }

        public class OrderData { 
            
        }

        public class Vendor
        {
            public string Code { get; set; }
            public string VendorName { get; set; }
        }

        public class MaterialOption
        {
            public string Code { get; set; }
            public string ShortText { get; set; }
            public string Unit { get; set; }

        }

    }
}