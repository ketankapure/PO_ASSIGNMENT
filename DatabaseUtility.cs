using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public class DatabaseUtility
{
    private readonly string connectionString;

    public DatabaseUtility()
    {
        connectionString = ConfigurationManager.ConnectionStrings["PurchaseOrderDB"].ConnectionString;
    }

    public void ExecuteVendorInsertProcedure(
        string code,
        string name,
        string addressLine1,
        string addressLine2,
        string contactEmail,
        string contactNo,
        DateTime validTillDate,
        string isActive)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand("InsertVendor", connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Code", code);
                command.Parameters.AddWithValue("@Name", name);
                command.Parameters.AddWithValue("@AddressLine1", addressLine1);
                command.Parameters.AddWithValue("@AddressLine2", addressLine2);
                command.Parameters.AddWithValue("@ContactEmail", contactEmail);
                command.Parameters.AddWithValue("@ContactNo", contactNo);
                command.Parameters.AddWithValue("@ValidTillDate", validTillDate);
                command.Parameters.AddWithValue("@IsActive", isActive);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }

    public void ExecuteInsertMaterialProcedure(
        string code,
        string shortText,
        string longText,
        string unit,
        decimal reorderLevel,
        int minOrderQuantity,
        string isActive)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand("InsertMaterial", connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Code", code);
                command.Parameters.AddWithValue("@ShortText", shortText);
                command.Parameters.AddWithValue("@LongText", longText);
                command.Parameters.AddWithValue("@Unit", unit);
                command.Parameters.AddWithValue("@ReorderLevel", reorderLevel);
                command.Parameters.AddWithValue("@MinOrderQuantity", minOrderQuantity);
                command.Parameters.AddWithValue("@IsActive", isActive);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }


    public void DeleteVendorData(string vendorCode)      
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            using (SqlCommand command = new SqlCommand("BindGetVendorNames", connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@type", "DELETE");
                command.Parameters.AddWithValue("@Code", vendorCode);
                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }


    public DataTable ExecuteBindVendorStoredProcedure(string procedureName, SqlParameter[] parameters=null)
    {
        DataTable resultTable = new DataTable();

        using (SqlConnection connection = new SqlConnection(connectionString)) 
        {
            
           connection.Open();

           using (SqlCommand command = new SqlCommand(procedureName, connection))
           {
               command.CommandType = CommandType.StoredProcedure;

                if (parameters!=null)
                {
                    command.Parameters.AddRange(parameters);


                }
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(resultTable);
                }
            }
            
        }
        return resultTable;
    }

    public DataTable ExecuteBindMaterialStoredProcedure(string procedureName, params SqlParameter[] parameters)
    {
        DataTable resultTable = new DataTable();

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();

            using (SqlCommand command = new SqlCommand(procedureName, connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddRange(parameters);

                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(resultTable);
                }
            }
        }

        return resultTable;
    }





}
