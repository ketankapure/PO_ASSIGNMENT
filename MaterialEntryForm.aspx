<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialEntryForm.aspx.cs" Inherits="PO_ASSIGNMENT.MaterialEntryForm" %>

<!DOCTYPE html>
<html>
<head>
    <title>Material Entry Form</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2>Material Entry Form</h2>
        <form id="materialForm" runat="server">
            <div class="form-group">
                <label for="txtMaterialCode">Material Code:</label>
                <input type="text" class="form-control" id="txtMaterialCode" runat="server" />
            </div>
            <div class="form-group">
                <label for="txtShortText">Short Text:</label>
                <input type="text" class="form-control" id="txtShortText" runat="server" />
            </div>
            <div class="form-group">
                <label for="txtReorderLevel">Reorder Level:</label>
                <input type="number" class="form-control" id="txtReorderLevel" runat="server" />
            </div>
            <div class="form-group">
                <label for="txtMinOrderQuantity">Minimum Order Quantity:</label>
                <input type="number" class="form-control" id="txtMinOrderQuantity" runat="server" />
            </div>
            <div class="form-group">
                <label for="txtUnit">Unit:</label>
                <input type="text" class="form-control" id="txtUnit" runat="server" />   
            </div>
            <div class="form-group">
                <label for="txtLongText">Long Text:</label>
                <textarea class="form-control" id="txtLongText" rows="4" runat="server"></textarea>
            </div>
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="chkIsActive" runat="server" />
                <label class="form-check-label" for="chkIsActive">Is Active</label>
            </div>
            <button type="button" class="btn btn-primary" id="btnSaveClick" onclick=" return SaveMaterial();">Save</button>
            <button type="button" class="btn btn-secondary" id="btnCancel" runat="server">Cancel</button>
        </form>
    </div>
    <script>
        // Client-side validation and submission can be added here
        $(document).ready(function () {
            debugger;
		});

        $("#btnSaveClick").click(function () {
            debugger;
			//SaveMaterial();
        });

        function SaveMaterial() {
            debugger;
            var isActive = $("#chkIsActive").prop("checked");
            var materialCode = $("#txtMaterialCode").val();
            var shortText = $("#txtShortText").val();
			var reorderLevel = $("#txtReorderLevel").val();
			var minOrderQuantity = $("#txtMinOrderQuantity").val();
			var unit = $("#txtUnit").val();
			var longText = $("#txtLongText").val();


            
            var requestData = {
				MaterialCode: materialCode,
                ShortText: shortText,
				ReorderLevel: reorderLevel,
				MinOrderQuantity: minOrderQuantity,
				Unit: unit,
                LongText: longText,
				IsActive: isActive
            };

			$.ajax({
				type: "POST",
				url: "MaterialEntryForm.aspx" + "/InsertMaterialOrder", // Change to your server-side method URL
				data: JSON.stringify({ orderData: requestData }),
				contentType: "application/json; charset=utf-8",
				async: false,
				cache: false,
				dataType: "json",
				success: function (response) {
					// Handle the server response
					if (response.d === "success") {
						alert("Material submitted successfully!");
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

            return false;
        }


    </script>
</body>
</html>

