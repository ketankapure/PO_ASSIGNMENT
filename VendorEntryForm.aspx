<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VendorEntryForm.aspx.cs" Inherits="PO_ASSIGNMENT.VendorEntryForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vendor Entry Form</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* Add your custom CSS styles here */
    </style>
</head>
<body>
    <form id="vendorForm" runat="server">
        <div class="container mt-4">
			<h2>Vendor Entry Form</h2>
            <div class="form-group">
                <label for="txtVendorCode">Vendor Code</label>
                <input type="text" id="txtVendorCode" runat="server" class="form-control" />
                <span id="vendorCodeError" class="error-message"></span>
            </div>
            <div class="form-group">
                <label for="txtVendorName">Name</label>
                <input type="text" id="txtVendorName" runat="server" class="form-control" />
                <span id="nameError" class="error-message"></span>
            </div>
            <div class="form-group">
                <label for="txtAddressLine1">Address Line 1</label>
                <input type="text" id="txtAddressLine1" runat="server" class="form-control" />
                <span id="addressLine1Error" class="error-message"></span>

            </div>
            <div class="form-group">
                <label for="txtAddressLine2">Address Line 2</label>
                <input type="text" id="txtAddressLine2" runat="server" class="form-control" />
                <span id="addressLine2Error" class="error-message"></span>

            </div>
            <div class="form-group">
                <label for="txtContactEmail">Contact Email</label>
                <input type="email" id="txtContactEmail" runat="server" class="form-control" />
                <span id="contactEmailError" class="error-message"></span>

            </div>
            <div class="form-group">
                <label for="txtContactNumber">Contact Number</label>
                <input type="text" id="txtContactNumber" runat="server" class="form-control" />
                <span id="contactNumberError" class="error-message"></span>

            </div>
            <div class="form-group">
                <label for="txtValidTillDate">Valid Till Date</label>
                <input type="date" id="txtValidTillDate" runat="server" class="form-control"  />
                <span id="validTillDateError" class="error-message"></span>

            </div>
            <div class="form-group">
                <div class="form-check">
                    <input type="checkbox" id="chkIsActive" runat="server" class="form-check-input" />
                    <label class="form-check-label" for="chkIsActive">Is Active</label>
                    <span id="vendorCodeError" class="error-message"></span>
                </div>
            </div>
            <div class="form-group">
                <button type="button" id="btnSave" class="btn btn-primary" onclick=" return SaveVendor();">Save</button>
                <button type="button" id="btnCancel" runat="server" class="btn btn-secondary" onclick="Cancel()">Cancel</button>
            </div>
        </div>
    </form>

    <script>
		$(document).ready(function () {

			setMinDate();

			function setMinDate() {
				var currentDate = new Date();
				var year = currentDate.getFullYear();
				var month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
				var day = currentDate.getDate().toString().padStart(2, '0');

				var formattedDate = year + '-' + month + '-' + day;

				$("#txtValidTillDate").attr("min", formattedDate);
			}

			$("#btnSave").click(function () {
				SaveVendor();
			});

			function SaveVendor() {
				clearErrorMessages();

				var isValid = true;

				// Validate Vendor Code
				var vendorCode = $("#txtVendorCode").val();
				if (vendorCode.trim() === "") {
					$("#vendorCodeError").text("Vendor Code is required.");
					isValid = false;
				}

				// Validate Name
				var name = $("#txtVendorName").val();
				if (name.trim() === "") {
					$("#nameError").text("Name is required.");
					isValid = false;
				}

				// Validate Address Line 1
				var addressLine1 = $("#txtAddressLine1").val();
				if (addressLine1.trim() === "") {
					$("#addressLine1Error").text("Address Line 1 is required.");
					isValid = false;
				}

				// Validate Address Line 2
				var addressLine2 = $("#txtAddressLine2").val();
				if (addressLine2.trim() === "") {
					$("#addressLine2Error").text("Address Line 2 is required.");
					isValid = false;
				}

				// Validate Contact Email
				var contactEmail = $("#txtContactEmail").val();
				if (contactEmail.trim() === "") {
					$("#contactEmailError").text("Contact Email is required.");
					isValid = false;
				} else if (!isValidEmail(contactEmail)) {
					$("#contactEmailError").text("Enter a valid email address.");
					isValid = false;
				}


				// Validate Contact Number
				var contactNumber = $("#txtContactNumber").val();
				if (contactNumber.trim() === "") {
					$("#contactNumberError").text("Contact Number is required.");
					isValid = false;
				} else if (!isValidContactNumber(contactNumber)) {
					$("#contactNumberError").text("Enter a valid contact number.");
					isValid = false;
				}

				// Validate Valid Till Date
				var validTillDate = $("#txtValidTillDate").val();
				if (validTillDate.trim() === "") {
					$("#validTillDateError").text("Valid Till Date is required.");
					isValid = false;
				}



				// If all validations passed, submit the form
				if (isValid) {
					// Perform form submission or other actions here
					// For demonstration purposes, let's show a success message
					$("#successMessage").text("Form submitted successfully!");
				}

				debugger;
				var isActive = $("#chkIsActive").prop("checked");

				var requestData = {
					VendorCode: vendorCode,
					Name: name,
					AddressLine1: addressLine1,
					AddressLine2: addressLine2,
					Email: contactEmail,
					Number: contactNumber,
					ValidDate: validTillDate,
					IsActive: isActive
				};
				$.ajax({
					type: "POST",
					url: "VendorEntryForm.aspx" + "/InsertVendorOrder", // Change to your server-side method URL
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

			// Clear error messages
			function clearErrorMessages() {
				$(".error-message").text("");
            }

			// Email validation function
			function isValidEmail(email) {
				// Basic email format validation using regular expression
				var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
				return emailPattern.test(email);
			}

			// Contact Number validation function
			function isValidContactNumber(number) {
				// Basic contact number format validation using regular expression
				// This example allows numbers with optional dashes or spaces
				var contactNumberPattern = /^(\d{10}|\d{3}-\d{4}-\d{3}|\d{3} \d{4} \d{3})$/;
				//var contactNumberPattern = /^(?:\+?\d{1,3})?(?:[\s-]?\d{10,12})$/;
				return contactNumberPattern.test(number);
			}

		});
	</script>

</body>
</html>
