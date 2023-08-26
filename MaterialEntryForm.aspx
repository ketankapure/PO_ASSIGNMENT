<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialEntryForm.aspx.cs" Inherits="PO_ASSIGNMENT.MaterialEntryForm" %>

<!DOCTYPE html>
<html>
<head>
    <title>Material Entry Form</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
         /* Chrome, Safari, Edge, Opera */
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Firefox */
        input[type=number] {
            -moz-appearance: textfield;
        }
    </style>
</head>
<body>
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
    <div class="modal fade" id="savealert" tabindex="-1" aria-labelledby="savealertLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="savealertLabel">Vendor Creation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Material submitted successfully!
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="closeAlertBtn" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
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
            <button type="button" class="btn btn-primary" id="btnSaveClick">Save</button>
            <button type="button" class="btn btn-secondary" id="btnCancel" runat="server">Cancel</button>
        </form>
    </div>
    <script>
        $(document).ready(function () {
            debugger;
		});

        $("#btnSaveClick").click(function () {
            var isValid = true;

            // Validate Order Date
            var txtMaterialCode = $("#txtMaterialCode").val();
            if (txtMaterialCode === "") {
                isValid = false;
                alert("Material Code required.");
                return;
            }
            var txtShortText = $("#txtShortText").val();
            if (txtShortText === "") {
                isValid = false;
                alert("Short Text required.");
                return;
            }
            var txtReorderLevel = $("#txtReorderLevel").val();
            if (txtReorderLevel === "") {
                isValid = false;
                alert("Reorder Level required.");
                return;

            }
            var txtMinOrderQuantity = $("#txtMinOrderQuantity").val();
            if (txtMinOrderQuantity === "") {
                isValid = false;
                alert("Minimum Order Quantity required.");
                return;
            }
            var txtUnit = $("#txtUnit").val();
            if (txtUnit === "") {
                isValid = false;
                alert("Unit required.");
                return;
            }
            var txtLongText = $("#txtLongText").val();
            if (txtLongText === "") {
                isValid = false;
                alert("Long Text required.");
                return;
            }

            if (isValid) {

                SaveMaterial();
            }
           
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
				url: "MaterialEntryForm.aspx" + "/InsertMaterialOrder", 
				data: JSON.stringify({ orderData: requestData }),
				contentType: "application/json; charset=utf-8",
				async: false,
				cache: false,
				dataType: "json",
				success: function (response) {
					
                    if (response.d === "success") {
                        document.getElementById("btnSaveClick").addEventListener("click", function () {
                            $('#savealert').modal('show');
                        });

					} else if (response.d.startsWith("error")) {
						var errorMessage = response.d.substring(6); 
						alert("Error: " + errorMessage);
					} else {
						alert("Unknown response: " + response.d);
					}
				},
				error: function (xhr, status, error) {
					console.error(error);
					console.log(xhr); 
					alert("An error occurred during the AJAX request. Check the console for details.");
				}
            });

            return false;
        }

        document.getElementById("btnCancel").addEventListener("click", function () {
            $('#cancelConfirmationModal').modal('show');
        });

        document.getElementById("confirmCancel").addEventListener("click", function () {
            window.location.href = "Home.aspx";
        });

        document.getElementById("closeAlertBtn").addEventListener("click", function () {
            location.reload();
        });


    </script>
</body>
</html>

