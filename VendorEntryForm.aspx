<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VendorEntryForm.aspx.cs" Inherits="PO_ASSIGNMENT.VendorEntryForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vendor Entry Form</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

				var vendorCode = $("#txtVendorCode").val();
				if (vendorCode.trim() === "") {
					$("#vendorCodeError").text("Vendor Code is required.");
					isValid = false;
				}

				var name = $("#txtVendorName").val();
				if (name.trim() === "") {
					$("#nameError").text("Name is required.");
					isValid = false;
				}

				var addressLine1 = $("#txtAddressLine1").val();
				if (addressLine1.trim() === "") {
					$("#addressLine1Error").text("Address Line 1 is required.");
					isValid = false;
				}

				var addressLine2 = $("#txtAddressLine2").val();
				if (addressLine2.trim() === "") {
					$("#addressLine2Error").text("Address Line 2 is required.");
					isValid = false;
				}

				var contactEmail = $("#txtContactEmail").val();
				if (contactEmail.trim() === "") {
					$("#contactEmailError").text("Contact Email is required.");
					isValid = false;
				} else if (!isValidEmail(contactEmail)) {
					$("#contactEmailError").text("Enter a valid email address.");
					isValid = false;
				}


				var contactNumber = $("#txtContactNumber").val();
				if (contactNumber.trim() === "") {
					$("#contactNumberError").text("Contact Number is required.");
					isValid = false;
				} else if (!isValidContactNumber(contactNumber)) {
					$("#contactNumberError").text("Enter a valid contact number.");
					isValid = false;
				}

				var validTillDate = $("#txtValidTillDate").val();
				if (validTillDate.trim() === "") {
					$("#validTillDateError").text("Valid Till Date is required.");
					isValid = false;
				}

				if (isValid) {
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
					url: "VendorEntryForm.aspx" + "/InsertVendorOrder", 
					data: JSON.stringify({ orderData: requestData }),
					contentType: "application/json; charset=utf-8",
					async: false,
					cache: false,
					dataType: "json",
					success: function (response) {
						if (response.d === "success") {
							alert("Order submitted successfully!");
                            var vendorData = {
                                vendorCode: vendorCode,
                                name: name,
                                number: contactNumber,
                                email: contactEmail,
                                validTillDate: validTillDate,
                                isActive: isActive
                            };


                            localStorage.setItem('newVendor', JSON.stringify(vendorData));
						}
						else {

						}
					},


					error: function (xhr, status, error) {
						console.error(error);
						console.log(xhr); 
						alert("An error occurred during the AJAX request. Check the console for details.");
					}
				});

              
                window.close();
			}

			function clearErrorMessages() {
				$(".error-message").text("");
            }

			function isValidEmail(email) {
				var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
				return emailPattern.test(email);
			}

			function isValidContactNumber(number) {
				var contactNumberPattern = /^(\d{10}|\d{3}-\d{4}-\d{3}|\d{3} \d{4} \d{3})$/;
				//var contactNumberPattern = /^(?:\+?\d{1,3})?(?:[\s-]?\d{10,12})$/;
				return contactNumberPattern.test(number);
			}


		});

        var urlParams = new URLSearchParams(window.location.search);
        var vendorCode = urlParams.get("vendorCode");

        populateFormWithVendorDetails(vendorCode);
        function populateFormWithVendorDetails(vendorCode) {
            var vendorData = {
                vendorCode: vendorCode,
                name: name,
                number: contactNumber,
                email: contactEmail,
                validTillDate: validTillDate,
                isActive: isActive
            };
            var vendorData = getVendorDataFromDataSource(vendorCode);
            document.getElementById("txtVendorCode").value = vendorData.vendorCode;
            document.getElementById("txtVendorName").value = vendorData.name;
            document.getElementById("txtContactNumber").value = vendorData.number;
            document.getElementById("txtContactEmail").value = vendorData.email;
            document.getElementById("txtValidTillDate").value = vendorData.validTillDate;
            var isActiveCheckbox = document.getElementById("chkIsActive");
            isActiveCheckbox.checked = vendorData.isActive;
        }
    </script>

</body>
</html>
