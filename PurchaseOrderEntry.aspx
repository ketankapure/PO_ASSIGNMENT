<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseOrderEntry.aspx.cs" Inherits="PO_ASSIGNMENT.PurchaseOrderEntry" %>

<!DOCTYPE html>
<html>
<head>
    <title>Purchase Order Entry Form</title>
    <!-- Include Bootstrap and CSS links here -->
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
		<div class="row">
			<div class="col-md-6">
				<h1>Purchase Order Entry Form</h1>
			</div>
			<div class="col-md-6 text-right">
				<button type="button" class="btn btn-primary" id="btnPurchaseSave" onclick="return savePurchaseOrder();">Save</button>
				<button type="button" class="btn btn-secondary">Cancel</button>
			</div>
		</div>
        <form id="purchaseOrderForm">
                <div class="form-row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="orderNumber">Order Number</label>
                        <input type="text" class="form-control" id="orderNumber" name="orderNumber" required>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="orderDate">Order Date</label>
                        <input type="date" class="form-control" id="orderDate" name="orderDate" required>
                    </div>
                </div>
            </div>			
            <div class="form-group">
				<label for="vendor">Vendor</label>
				<select class="form-control" id="vendor" name="vendor">
					<option value="" disabled selected>Select a Vendor</option>
					<option value="vendor1">Vendor 1</option>
					<option value="vendor2">Vendor 2</option>
					<!-- Add more options as needed -->
				</select>
			</div>
			<div class="form-group">
				<label for="notes">Notes</label>
				<textarea class="form-control" id="notes" name="notes" rows="4"></textarea>
			</div>
            <div class="form-row">
				<div class="col-md-6">
					<div class="form-group">
						<label for="orderValue">Order Value</label>
						<input type="number" class="form-control" id="orderValue" name="orderValue" required>
					</div>
				</div>
            </div>
           <div class="form-group">
                <label for="material">Material</label>
                <span class="form-inline">
                <select class="form-control mr-2" id="code" name="code" onchange="updateUnit()">
					<option value="" disabled selected>Select a code</option>
                    <option value="code1">Code 1</option>
                    <option value="code2">Code 2</option>
                </select>
                <select class="form-control mr-2 col-md-6" id="shortText" name="shortText" onchange="updateUnit()">
					<option value="" disabled selected>Select a Short Text</option>
                    <option value="text1">Text 1</option>
                    <option value="text2">Text 2</option>
                </select>
                <input type="text" class="form-control" id="unit" name="unit" placeholder="Unit" required>
                </span>
            </div>

            
			<div class="form-row">
				<div class="col-md-6">
					<div class="form-group">
						<label for="quantity">Quantity</label>
						<input type="number" class="form-control" id="quantity" name="quantity" required>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="rate">Rate</label>
						<input type="number" class="form-control" id="rate" name="rate" required>
					</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-6">
					<div class="form-group">
						<label for="amount">Amount</label>
						<input type="number" class="form-control" id="amount" name="amount" required>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="expectedDate">Expected Date</label>
						<input type="date" class="form-control" id="expectedDate" name="expectedDate" required>
					</div>
				</div>
			</div>
            <!-- Add more form fields here -->
			<div class="form-group">
            <button type="button" class="btn btn-primary" id="addLineBtn">Add Line</button>
            <button type="button" class="btn btn-primary" id="updateLineBtn">Update Line</button>
            <button type="button" class="btn btn-primary" id="removeLineBtn">Remove Line</button>
			</div>
            <!-- Add Line, Update Line, Remove Line buttons here -->

            <table class="table" id="orderTable">
                <thead>
                    <tr>
                        <th>Select</th>
                        <th>Code</th>
                        <th>Quantity</th>
                        <th>Rate</th>
                        <th>Amount</th>
                        <th>Expected Date</th>
                    </tr>
                </thead>
                <tbody id="lineItemsTableBody">
                    <!-- Table rows will be added dynamically -->
                </tbody>
            </table>
        </form>
    </div>
     <script>

		 $(document).ready(function () {

             $("#unit").prop("readonly", true);

             loadVendorDropdown();
             loadCodeDropdown();
             loadShortTextDropdown();

			

            
		 });

         //Add Button
         $("#addLineBtn").click(function () {
             debugger;

             function calculateAmount(quantity, rate) {
                 // Assuming quantity and rate are numbers
                 var numericQuantity = parseFloat(quantity);
                 var numericRate = parseFloat(rate);

                 // Calculate the amount
                 var amount = numericQuantity * numericRate;

                 // Return the calculated amount
                 return amount.toFixed(2); // Return amount with two decimal places
             }

             // Get values from textboxes
             var materialCode = $("#code").val();
             var quantity = $("#quantity").val();
             var rate = $("#rate").val();
             var amount = calculateAmount(quantity, rate); // Implement this function
             var expectedDate = $("#expectedDate").val();

             

             // Create a new row and append it to the table
             var newRow = $("<tr>");
             newRow.append("<td><input type='checkbox' class='selectRow'></td>");
             newRow.append("<td>" + materialCode + "</td>");
             newRow.append("<td>" + quantity + "</td>");
             newRow.append("<td>" + rate + "</td>");
             newRow.append("<td>" + amount + "</td>");
             newRow.append("<td>" + expectedDate + "</td>");
             $("#orderTable tbody").append(newRow);

             // Clear input fields
             $("#code").val("");
             $("#quantity").val("");
             $("#rate").val("");
             $("#expectedDate").val("");
         });
            
		 //Update Button 
         $("#updateLineBtn").click(function () {
             // Find the selected checkbox
             var selectedRow = $("#orderTable").find(".selectRow:checked").closest("tr");

             // Make the cells in the selected row editable
             selectedRow.find("td:not(:first-child)").each(function () {
                 var cellValue = $(this).text();
                 $(this).html("<input type='text' class='editCell' value='" + cellValue + "'>");
             });
         });

         //Remove Button
         $("#removeLineBtn").click(function () {
             // Find selected rows and remove them
             $("#orderTable").find(".selectRow:checked").closest("tr").remove();
         });

         //Save Button
         $("#saveBtn").click(function () {
             var tableData = [];
             $("#orderTable tbody tr").each(function () {
                 var row = $(this);
                 var rowData = {
                     materialCode: row.find("td:eq(1)").text(),
                     quantity: row.find("td:eq(2)").text(),
                     rate: row.find("td:eq(3)").text(),
                     amount: row.find("td:eq(4)").text(),
                     expectedDate: row.find("td:eq(5)").text()
                 };
                 tableData.push(rowData);
             });

             // Perform further processing, e.g., send data to server
         });
         function loadVendorDropdown() {
             $.ajax({
                 type: "POST",
                 url: "PurchaseOrderEntry.aspx" + "/GetVendorNames", // Change to your server-side method URL
                 contentType: "application/json; charset=utf-8",
                 async: false,
                 cache: false,
                 dataType: "json",
                 success: function (response) {
                     var vendors = response.d;
                     var dropdown = $("#vendor");
                     dropdown.empty(); // Clear existing options
                     dropdown.append($("<option>").attr("value", "").text("Select a vendor"));

                     // Populate the dropdown with vendor names
                     $.each(vendors, function (index, vendor) {
                         dropdown.append($("<option>").attr("value", vendor.Code).text(vendor.VendorName));
                     });
                 },

                 //error: function (error) {
                 //    console.log("Error loading vendor names: " + error.responseText);
                 //}
                 error: function (xhr, status, error) {
                     console.error(error);
                     console.log(xhr); // Log the xhr object for more details
                     alert("An error occurred during the AJAX request. Check the console for details.");
                 }
             });

         }

		 function savePurchaseOrder() {

             var ddCodeSelectedValue;
             var ddShortTextSelectedValue;

             var selectedVendorID = $("#vendor").val();

             $("#code").change(function () {
                 ddCodeSelectedValue = $(this).val(); // Gets the selected value
                 console.log("Selected Code ID: " + ddCodeSelectedValue);
             });

             $("#shortText").change(function () {
                 ddShortTextSelectedValue = $(this).val(); // Gets the selected value
                 console.log("Selected Code ID: " + ddShortTextSelectedValue);
             });

             var orderNumber = $("#orderNumber").val();
             var orderDate = $("#orderDate").val();
             var orderNumber = $("#orderNumber").val(); //vendor ID
             var notes = $("#notes").val();
             var orderValue = $("#orderValue").val();  
             //var orderNumber = $("#orderNumber").val(); //order status
             //var selectedValue = $("#orderNumber").val(); // Material code
             var itemQuantity = $("#quantity").val();   // itemQuantity
             var itemRate = $("#rate").val();
             var expectedDate = $("#expectedDate").val();

             var requestData = {
                 OrderNumber: orderNumber,
                 OrderDate: orderDate,
                 VendorID: selectedVendorID, //vendorID
                 Notes: notes,
                 OrderValue: orderValue,
                 //Number: contactNumber,     //order status handle with server side
                 MaterialCode: ddCodeSelectedValue,
                 ItemRate: itemRate,
                 //IsActive: itemValue,       //itemValue handle with server side
                 ShortText: ddShortTextSelectedValue,
                 ExpectedDate: expectedDate
             };

             //string orderNumber,
             //    DateTime orderDate,
             //        int vendorID,
             //            string notes,
             //                decimal orderValue,
             //                    string orderStatus,
             //                        int materialID,
             //                            int itemQuantity,
             //                                decimal itemRate,
             //                                    decimal itemValue,
             //                                        string itemNotes,
             //                                            DateTime expectedDate,


             $.ajax({
                 type: "POST",
                 url: "VendorEntryForm.aspx" + "/SavePurchaseOrder", // Change to your server-side method URL
                 data: JSON.stringify({ orderData: requestData }),
                 contentType: "application/json; charset=utf-8",
                 async: false,
                 cache: false,
                 dataType: "json",
                 success: function (response) {
                     // Handle the server response
                     if (response.d === "success") {
                         alert("Order submitted successfully!");
                         // Clear form inputs or perform other actions
                     } else if (response.d.startsWith("error")) {
                         var errorMessage = response.d.substring(6); // Remove "error: " prefix
                         alert("Error: " + errorMessage);
                     } else {
                         alert("Unknown response: " + response.d);
                     }
                 },
                 error: function (xhr, status, error) {
                     console.error(error);
                     console.log(xhr); // Log the xhr object for more details
                     alert("An error occurred during the AJAX request. Check the console for details.");
                 }
             });
         }

         function loadCodeDropdown() {
             $.ajax({
                 type: "POST",
                 url: "PurchaseOrderEntry.aspx" + "/GetMaterialCode", // Change to your server-side method URL
                 contentType: "application/json; charset=utf-8",
                 async: false,
                 cache: false,
                 dataType: "json",
                 success: function (response) {
                     var vendors = response.d;
                     var dropdown = $("#code");
                     dropdown.empty(); // Clear existing options
                     dropdown.append($("<option>").attr("value", "").text("Select a code"));

                     var options = response.d;
                     $.each(options, function (index, option) {
                         dropdown.append($("<option>").val(option.Code).text(option.Code));
                     });
                 },

                 //error: function (error) {
                 //    console.log("Error loading vendor names: " + error.responseText);
                 //}
                 error: function (xhr, status, error) {
                     console.error(error);
                     console.log(xhr); // Log the xhr object for more details
                     alert("An error occurred during the AJAX request. Check the console for details.");
                 }
             });// Load code dropdown options using AJAX
         }

         function loadShortTextDropdown() {
             $.ajax({
                 type: "POST",
                 url: "PurchaseOrderEntry.aspx" + "/GetShortTextOptions",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     var shortTextDropdown = $("#shortText");
                     shortTextDropdown.empty(); // Clear existing options
                     shortTextDropdown.append($("<option>").val("").text("Select a Short Text"));

                     var options = response.d;
                     $.each(options, function (index, option) {
                         shortTextDropdown.append($("<option>").val(option.ShortText).text(option.ShortText));
                     });
                 },
                 error: function (xhr, status, error) {
                     console.error(error);
                     console.log(xhr); // Log the xhr object for more details
                     alert("An error occurred during the AJAX request. Check the console for details.");
                 }
             });
         }

         function updateUnit() {
             debugger;
             var selectedDdCode = $("#code").val();
             var selectedShortText = $("#shortText").val();

             var selectedValue = selectedDdCode || selectedShortText;

             if (selectedValue) {
                 $.ajax({
                     type: "POST",
                     url: "PurchaseOrderEntry.aspx" + "/GetUnitByCode",
                     data: JSON.stringify({ selectedCode: selectedValue }),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (response) {
                         var unitValue = response.d[0].Unit;
                         $("#unit").val(unitValue);
                     },
                     error: function (xhr, status, error) {
                         console.error(error);
                         console.log(xhr); // Log the xhr object for more details
                         alert("An error occurred during the AJAX request. Check the console for details.");
                     }
                 });
             } else {
                 $("#unit").val("");
                 
             }
         }
		
		
		 // Attach event listener to the Remove Line button
		 //document.getElementById("removeLineBtn").addEventListener("click", removeSelectedLines);

		 

		 
     </script>
    
</body>
</html>

