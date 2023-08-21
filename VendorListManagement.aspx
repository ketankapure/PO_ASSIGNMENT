<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VendorListManagement.aspx.cs" Inherits="PO_ASSIGNMENT.VendorListManagement" %>

<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor List Management</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-12">
            <h2>Vendor List Management</h2>
            <button class="btn btn-primary mt-3" id="createVendor" onclick="redirectToVendorEntry()">Create Vendor</button>
            <table class="table mt-4">
                <thead>
                    <tr>
                        <th>Vendor Code</th>
                        <th>Name</th>
                        <th>Number</th>
                        <th>Email</th>
                        <th>Valid Till Date</th>
                        <th>IsActive</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody id="vendorTableBody">
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>

    document.getElementById("createVendor").addEventListener("click", function () {
        window.location.href = "VendorEntryForm.aspx";
    });

    function addVendorToTable(data) {
        var tableBody = document.getElementById("vendorTableBody");
        var newRow = tableBody.insertRow();
        var cell1 = newRow.insertCell(0);
        var cell2 = newRow.insertCell(1);
        var cell3 = newRow.insertCell(2);
        var cell4 = newRow.insertCell(3);
        var cell5 = newRow.insertCell(4);
        var cell6 = newRow.insertCell(5);
        var cell7 = newRow.insertCell(6);
        var cell8 = newRow.insertCell(7);

        cell1.innerHTML = data.vendorCode;
        cell2.innerHTML = data.name;
        cell3.innerHTML = data.number;
        cell4.innerHTML = data.email;
        cell5.innerHTML = data.validTillDate;
        cell6.innerHTML = data.isActive ? "Yes" : "No";
        cell7.innerHTML = '<button class="btn btn-primary btn-sm" onclick="editVendor()">Edit</button>';
        cell8.innerHTML = '<button class="btn btn-danger btn-sm" onclick="deleteVendor()">Delete</button>';
    }

    function checkNewVendorData() {
        var newVendorData = localStorage.getItem('newVendor');
        if (newVendorData) {
            var parsedData = JSON.parse(newVendorData);
            addVendorToTable(parsedData);
            localStorage.removeItem('newVendor');
        }
    }

    window.onload = function () {
        checkNewVendorData();
    };

    function editVendor(vendorCode) {
        window.location.href = `VendorEntryForm.aspx?edit=true&vendorCode=${data.vendorCode}`;
    }

    function deleteVendor(vendorCode) {
        var confirmDelete = confirm("Are you sure you want to delete this vendor?");
        if (confirmDelete) {
            var rowToRemove = document.getElementById(`vendorRow_${vendorCode}`);
            if (rowToRemove) {
                rowToRemove.remove();
            }
        }
    }
</script>

</body>
</html>
