<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseOrderEntry.aspx.cs" Inherits="PO_ASSIGNMENT.PurchaseOrderEntry" %>

<!DOCTYPE html>
<html>
<head>
    <title>Purchase Order Entry Form</title>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type=number] {
            -moz-appearance: textfield;
        }
    </style>
</head>
<body>
    <div class="container">
		<div class="row">
			<div class="col-md-6">
				<h1>Purchase Order Entry Form</h1>
			</div>
			<div class="col-md-6 text-right">
				<button type="button" class="btn btn-primary" id="btnPurchaseSave">Save</button>
				<button type="button" class="btn btn-secondary" id="cancelButton">Cancel</button>
			</div>
            <div class="modal fade" id="cancelConfirmationModal" tabindex="-1" aria-labelledby="cancelConfirmationModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="cancelConfirmationModalLabel">Cancel Confirmation</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to cancel? Any unsaved changes will be lost.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-danger" id="confirmCancel">Confirm Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
		</div>
        <form id="purchaseOrderForm">
                <div class="form-row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="orderNumber">Order Number</label>
                        <input type="number" class="form-control" id="orderNumber" name="orderNumber" required>
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
						<input type="number" class="form-control" id="rate"  name="rate" required>
					</div>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-6">
					<div class="form-group">
						<label for="amount">Amount</label>
						<input type="number" class="form-control" id="amount" name="amount" readonly required>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="expectedDate">Expected Date</label>
						<input type="date" class="form-control" id="expectedDate" name="expectedDate" required>
					</div>
				</div>
			</div>
			<div class="form-group">
            <button type="button" class="btn btn-primary" id="addLineBtn">Add Line</button>
            <button type="button" class="btn btn-primary" id="updateLineBtn">Update Line</button>
            <button type="button" class="btn btn-primary" id="removeLineBtn">Remove Line</button>
			</div>

            <table class="table" id="orderTable" >
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
                </tbody>
            </table>
        </form>
    </div>
     <script>

		 $(document).ready(function () {

             $("#unit").prop("readonly", true);

             $("#quantity, #rate").on("input", function () {
                 calculateAmount();
             });


             function calculateAmount() {
                 const quantity = parseFloat($("#quantity").val()) || 0;
                 const rate = parseFloat($("#rate").val()) || 0;
                 const amount = (quantity * rate).toFixed(2);
                 $("#amount").val(amount);
             }

             loadVendorDropdown();
             loadCodeDropdown();
             loadShortTextDropdown();

		 });

         //Add Button
         $("#addLineBtn").click(function () {
             var isValid = validateAddLine(); 

             if (isValid) {
                 addNewRow();
             } else {
                 alert("Please fill in all required fields before adding a new line.");
             }

         });
            
		 //Update Button 
         $("#updateLineBtn").click(function () {


             var isValid = validateUpdateLine(); 

             if (isValid) {
                 updateSelectedRow();
             } else {
                 alert("Please select a row and fill in all required fields before updating.");
             }

             
         });

         //Remove Button
         $("#removeLineBtn").click(function () {

             var isValid = validateRemoveLine();

             if (isValid) {
                 removeSelectedRow();
             } else {
                 alert("Please select a row before removing.");
             }

         });

         function validateAddLine() {
             var quantity = $("#quantity").val();
             var rate = $("#rate").val();
             return quantity !== "" && rate !== "";
         }

         function validateUpdateLine() {
             var selectedRow = $("#orderTable").find(".selectRow:checked").closest("tr");
             if (selectedRow.length === 0) {
                 return false;
             }

             var quantityInput = selectedRow.find("td:eq(2) input");
             var rateInput = selectedRow.find("td:eq(3) input");
             return quantityInput.val() !== "" && rateInput.val() !== "";
         }

         function validateRemoveLine() {
             var selectedRow = $("#orderTable").find(".selectRow:checked").closest("tr");
             return selectedRow.length > 0;
         }

         function addNewRow() {
             var materialCode = $("#code").val();
             var quantity = $("#quantity").val();
             var rate = $("#rate").val();
             var amount = $("#amount").val(); 
             var expectedDate = $("#expectedDate").val();



             var newRow = $("<tr>");
             newRow.append("<td><input type='checkbox' class='selectRow'></td>");
             newRow.append("<td>" + materialCode + "</td>");
             newRow.append("<td>" + quantity + "</td>");
             newRow.append("<td>" + rate + "</td>");
             newRow.append("<td>" + amount + "</td>");
             newRow.append("<td>" + expectedDate + "</td>");
             $("#orderTable tbody").append(newRow);

             // Clear input fields
             //$("#code").val("");
             $("#quantity").val("");
             $("#rate").val("");
             $("#amount").val("");
             $("#expectedDate").val("");
         }


         function updateSelectedRow() {
             var selectedRow = $("#orderTable").find(".selectRow:checked").closest("tr");

             var cellsEditable = selectedRow.find(".editCell").length > 0;

             if (!cellsEditable) {
                 selectedRow.find("td:not(:first-child)").each(function (index) {
                     if (index !== 0 && index !== 3) { 
                         var cellValue = $(this).text();
                         $(this).html("<input type='text' class='editCell' value='" + cellValue + "'>");
                     }
                 });
             } else {
                 var quantityInput = parseFloat(selectedRow.find("td:eq(2) input").val()) || 0;
                 var rateInput = parseFloat(selectedRow.find("td:eq(3) input").val()) || 0;
                 var amountCell = selectedRow.find("td:eq(4)");
                 var amount = (quantityInput * rateInput).toFixed(2);
                 amountCell.text(amount);

                 selectedRow.find(".editCell").each(function () {
                     var cellValue = $(this).val();
                     $(this).replaceWith(cellValue);
                 });
             }
         }

         function removeSelectedRow() {

             $("#orderTable").find(".selectRow:checked").closest("tr").remove();
         }

         var selectedVendorCode;

         var ddCodeSelectedValue;
         var ddShortTextSelectedValue;
         $("#code").change(function () {
             ddCodeSelectedValue = $(this).val(); 
             console.log("Selected Code ID: " + ddCodeSelectedValue);
         });

         $("#shortText").change(function () {
             ddShortTextSelectedValue = $(this).val(); 
             console.log("Selected Code ID: " + ddShortTextSelectedValue);
         });

         function loadVendorDropdown() {
             $.ajax({
                 type: "POST",
                 url: "PurchaseOrderEntry.aspx" + "/GetVendorNames", 
                 contentType: "application/json; charset=utf-8",
                 async: false,
                 cache: false,
                 dataType: "json",
                 success: function (response) {
                     var vendors = response.d;
                     var dropdown = $("#vendor");
                     dropdown.empty(); 
                     dropdown.append($("<option>").attr("value", "").text("Select a vendor"));
                     $.each(vendors, function (index, vendor) {
                         dropdown.append($("<option>").attr("value", vendor.Code).text(vendor.VendorName));
                     });
                     dropdown.on("change", function () {
                         selectedVendorCode = $(this).val();
                         
                     });
                 },
                 error: function (xhr, status, error) {
                     console.error(error);
                     console.log(xhr); 
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
                     dropdown.empty(); 
                     dropdown.append($("<option>").attr("value", "").text("Select a code"));

                     var options = response.d;
                     $.each(options, function (index, option) {
                         dropdown.append($("<option>").val(option.Code).text(option.Code));
                     });
                 },


                 error: function (xhr, status, error) {
                     console.error(error);
                     console.log(xhr); 
                     alert("An error occurred during the AJAX request. Check the console for details.");
                 }
             });
         }

         function loadShortTextDropdown() {
             $.ajax({
                 type: "POST",
                 url: "PurchaseOrderEntry.aspx" + "/GetShortTextOptions",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     var shortTextDropdown = $("#shortText");
                     shortTextDropdown.empty(); 
                     shortTextDropdown.append($("<option>").val("").text("Select a Short Text"));

                     var options = response.d;
                     $.each(options, function (index, option) {
                         shortTextDropdown.append($("<option>").val(option.ShortText).text(option.ShortText));
                     });
                 },
                 error: function (xhr, status, error) {
                     console.error(error);
                     console.log(xhr); 
                     alert("An error occurred during the AJAX request. Check the console for details.");
                 }
             });
         }

         $("#btnPurchaseSave").click(function () {
             debugger;

             var isValid = true;

             // Validate Order Date
             var orderDate = $("#orderDate").val();
             if (orderDate === "") {
                 isValid = false;
                 alert("Please select an Order Date.");
                 return;
             }

             // Validate Vendor dropdown
             var selectedVendor = $("#vendor").val();
             if (selectedVendor === "") {
                 isValid = false;
                 alert("Please select a Vendor.");
                 return;
             }

             // Validate Notes textarea
             var notes = $("#notes").val();
             if (notes === "") {
                 isValid = false;
                 alert("Please enter Notes.");
                 return;
             }

             // Validate Order Value
             var orderValue = $("#orderValue").val();
             if (orderValue === "") {
                 isValid = false;
                 alert("Please enter Order Value.");
                 return;
             }

             // If all validations pass, proceed with saving
             if (isValid)
             {
       
                 var orderNumber = $("#orderNumber").val();

                 var headerData = {
                     OrderNumber: orderNumber,
                     OrderDate: orderDate,
                     VendorID: selectedVendorCode, //vendorID
                     Notes: notes,
                     OrderValue: orderValue,
                     ItemNotes: ddShortTextSelectedValue,
                 };

                 var tableData = [];
                 $("#orderTable tbody tr").each(function () {
                     var row = $(this);
                     var rowData = {
                         MaterialCode: row.find("td:eq(1)").text(),
                         ItemQuantity: row.find("td:eq(2)").text(),
                         ItemRate: row.find("td:eq(3)").text(),
                         ItemValue: row.find("td:eq(4)").text(),
                         ExpectedDate: row.find("td:eq(5)").text()
                     };
                     tableData.push(rowData);
                 });

                 var requestData = {
                     Header: headerData,
                     TableData: tableData
                 };
                 savePurchaseOrder(requestData);
             }
         });

         

         function updateUnit() {
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
                         console.log(xhr); 
                         alert("An error occurred during the AJAX request. Check the console for details.");
                     }
                 });
             } else {
                 $("#unit").val("");

             }
         }

         function savePurchaseOrder(requestData) {
             debugger;
             $.ajax({
                 type: "POST",
                 url: "PurchaseOrderEntry.aspx" + "/SavePurchaseOrder",
                 data: JSON.stringify({ purchaseOrder: requestData }),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     alert("Purchase order saved successfully!");
                 },
                 error: function (xhr, status, error) {
                     console.error(error);
                     console.log(xhr);
                     alert("An error occurred during the AJAX request. Check the console for details.");
                 }
             });

         }


         document.getElementById("cancelButton").addEventListener("click", function () {
             $('#cancelConfirmationModal').modal('show');
         });

         document.getElementById("confirmCancel").addEventListener("click", function () {


         });
 
     </script>
    
</body>
</html>

