using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Services;
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
            catch (Exception ex)
            {

            }

            return codeOptions;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SavePurchaseOrder(PurchaseOrderViewModel purchaseOrder)
        {
            try
            {
                ExecuteInsertPurchaseOrderProcedure(purchaseOrder.Header, purchaseOrder.TableData);
                return "Purchase order saved successfully";
            }
            catch (Exception ex)
            {
                return "An error occurred while saving the purchase order: " + ex.Message;
            }

        }

        public class PurchaseOrderViewModel
        {
            public PurchaseOrderHeader Header { get; set; }
            public List<PurchaseOrderDetail> TableData { get; set; }

        }

        public class PurchaseOrderDetail
        {
            public string OrderNumber { get; set; }
            public string MaterialCode { get; set; }
            public int ItemQuantity { get; set; }
            public decimal ItemRate { get; set; }
            public decimal ItemValue { get; set; }
            public string ItemNotes { get; set; }
            public DateTime ExpectedDate { get; set; }
        }

        public class PurchaseOrderHeader
        {
            public string OrderNumber { get; set; }
            public DateTime OrderDate { get; set; }
            public string VendorID { get; set; }
            public string Notes { get; set; }
            public decimal OrderValue { get; set; }
            public string OrderStatus { get; set; }
            public string ItemNotes { get; set; }
        }

        private static void ExecuteInsertPurchaseOrderProcedure(PurchaseOrderHeader header, List<PurchaseOrderDetail> details)
        {
           string connectionString = ConfigurationManager.ConnectionStrings["PurchaseOrderDB"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("InsertPurchaseOrder", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@OrderNumber", header.OrderNumber);
                        command.Parameters.AddWithValue("@MaterialIDs", "");
                        command.Parameters.AddWithValue("@ItemQuantities", "");
                        command.Parameters.AddWithValue("@ItemRates", "");
                        command.Parameters.AddWithValue("@ItemValues", "");
                        command.Parameters.AddWithValue("@ItemNotes", "");
                        command.Parameters.AddWithValue("@ExpectedDates", "");
                        command.Parameters.AddWithValue("@OrderDate", header.OrderDate);
                        command.Parameters.AddWithValue("@VendorID", header.VendorID);
                        command.Parameters.AddWithValue("@Notes", header.Notes);
                        command.Parameters.AddWithValue("@OrderValue", header.OrderValue);
                        command.Parameters.AddWithValue("@OrderStatus", "PENDING");
                        // Add other header parameters

                        // Create a table-valued parameter for details
                        DataTable detailsTable = new DataTable();
                        detailsTable.Columns.Add("OrderNumber", typeof(string));
                        detailsTable.Columns.Add("MaterialID", typeof(string));
                        detailsTable.Columns.Add("Quantity", typeof(decimal));
                        detailsTable.Columns.Add("Rate", typeof(decimal));
                        detailsTable.Columns.Add("Amount", typeof(decimal));
                        detailsTable.Columns.Add("ShortText", typeof(string));
                        detailsTable.Columns.Add("ExpectedDate", typeof(DateTime));

                        foreach (var detail in details)
                        {
                            detailsTable.Rows.Add(detail.OrderNumber, detail.MaterialCode, detail.ItemQuantity, detail.ItemRate, detail.ItemValue, detail.ItemNotes, detail.ExpectedDate);
                        }

                        SqlParameter detailsParam = command.Parameters.AddWithValue("@Details", detailsTable);
                        detailsParam.SqlDbType = SqlDbType.Structured;
                        detailsParam.TypeName = "dbo.PurchaseOrderDetailsType";
                        //int insertedOrderID = (int)command.ExecuteScalar();

                        command.ExecuteNonQuery();

                        connection.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }

            
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