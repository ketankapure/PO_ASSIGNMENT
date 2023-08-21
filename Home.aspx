<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PO_ASSIGNMENT.Home" %>

<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .btn-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 100px;
        }
        .btn-container .btn {
            margin-bottom: 10px;
        }

         .note-container {
            text-align: center;
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <div class="container">
		<div class="note-container">
			<div class="alert alert-info" role="alert">
				<strong>Please add vendor and material entry!</strong> Once completed, you can access the Purchase Order Entry and Vendor List Management sections.
			</div>
		</div>
        <div class="btn-container">
            <button type="button" class="btn btn-primary" id="vendorEntryBtn">Vendor Entry</button>
            <button type="button" class="btn btn-primary" id="materialEntryBtn">Material Entry</button>
            <button type="button" class="btn btn-primary" id="purchaseOrderEntryBtn">Purchase Order Entry</button> 
            <button type="button" class="btn btn-primary" id="vendorListMngt">Vendor List Management</button>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
		document.getElementById("vendorEntryBtn").addEventListener("click", function () {
			window.location.href = "VendorEntryForm.aspx";
		});

		document.getElementById("materialEntryBtn").addEventListener("click", function () {
			window.location.href = "MaterialEntryForm.aspx";
		});

		document.getElementById("purchaseOrderEntryBtn").addEventListener("click", function () {
			window.location.href = "PurchaseOrderEntry.aspx";
		});

		document.getElementById("vendorListMngt").addEventListener("click", function () {
			window.location.href = "VendorListManagement.aspx";
		});
	</script>
</body>
</html>


