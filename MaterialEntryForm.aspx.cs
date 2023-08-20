using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PO_ASSIGNMENT
{
	public partial class MaterialEntryForm : System.Web.UI.Page
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
        public static string InsertMaterialOrder(OrderData orderData)
        {
            try
            {
                DatabaseUtility dbUtility = new DatabaseUtility();

                string code = orderData.MaterialCode.Trim();
                string shorttext = orderData.ShortText.Trim();
                decimal reorderlevel = orderData.ReorderLevel;
                int minorderquantity = orderData.MinOrderQuantity;
                string unit = orderData.Unit.Trim();
                string longText = orderData.LongText.Trim();
                string isActive = orderData.IsActive.ToString();

                dbUtility.ExecuteInsertMaterialProcedure(code, shorttext, longText, unit, reorderlevel, minorderquantity,isActive);
                return "success";
            }
            catch (Exception ex)
            {
                // Log the error
                return "error: " + ex.Message;
            }
        }

        public class OrderData { 
            public string MaterialCode { get; set; }
            public string ShortText { get; set; }
            public Decimal ReorderLevel { get; set; }
            public int MinOrderQuantity { get; set; }
            public string Unit { get; set; }
            public string LongText { get; set; }
            public bool IsActive { get; set; }
        }
    }
}