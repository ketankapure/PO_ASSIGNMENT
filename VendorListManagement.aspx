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

    $(document).ready(function () {
        // Fetch data from the server and populate the table
        fetchDataAndPopulateTable();
    });

    document.getElementById("createVendor").addEventListener("click", function () {
        window.location.href = "VendorEntryForm.aspx";
    });

    function fetchDataAndPopulateTable() {

        $.ajax({
            type: "POST",
            url: "VendorListManagement.aspx" + "/GetVendorData",
            contentType: "application/json; charset=utf-8",
            async: false,
            cache: false,
            dataType: "json",
            success: function (data) {
                populateTableWithFetchedData(data);
                //var vendors = response.d;
            },
            error: function (xhr, status, error) {
                console.error(error);
                console.log(xhr);
                alert("An error occurred during the AJAX request. Check the console for details.");
            }
        });
    }

    function populateTableWithFetchedData(data) {
        var tableBody = document.getElementById("vendorTableBody");
        tableBody.innerHTML = ""; // Clear existing rows

        data.d.forEach(function (vendor) {
            var newRow = tableBody.insertRow();
            var cell1 = newRow.insertCell(0);
            var cell2 = newRow.insertCell(1);
            var cell3 = newRow.insertCell(2);
            var cell4 = newRow.insertCell(3);
            var cell5 = newRow.insertCell(4);
            var cell6 = newRow.insertCell(5);
            var cell7 = newRow.insertCell(6);
            var cell8 = newRow.insertCell(7);

            cell1.innerHTML = vendor.vendorCode;
            cell2.innerHTML = vendor.name;
            cell3.innerHTML = vendor.number;
            cell4.innerHTML = vendor.email;
            cell5.innerHTML = vendor.validTillDate;
            cell6.innerHTML = vendor.isActive;
            cell7.innerHTML = '<button class="btn btn-primary btn-sm" onclick="editVendor()">Edit</button>';
            cell8.innerHTML = '<button class="btn btn-danger btn-sm delete-button" onclick="deleteVendor()">Delete</button>';

        });

        $("button.delete-button").click(function () {
            var vendorCode = $(this).attr("data-vendor-code");
            deleteVendor(vendorCode);
        });
    }

    

    function editVendor() {
        var vendorCode = $(this).attr("data-vendor-code");
       
    }

    function deleteVendor(vendorCode) {
        var confirmDelete = confirm("Are you sure you want to delete this vendor?");
        if (confirmDelete) {
            $.ajax({
                type: "POST",
                url: "VendorListManagement.aspx" + "/DeleteVendor",
                contentType: "application/json; charset=utf-8",
                data: { vendorCode: vendorCode },
                async: false,
                cache: false,
                success: function (response) {
                    if (response.success) {
                        populateTableWithFetchedData(data);
                    } else {
                        alert("Failed to delete the vendor.");
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error deleting vendor:', error);
                }
            });
        }
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

    //function editVendor(vendorCode) {
    //    window.location.href = `VendorEntryForm.aspx?edit=true&vendorCode=${data.vendorCode}`;
    //}

    //function deleteVendor(vendorCode) {
    //    var confirmDelete = confirm("Are you sure you want to delete this vendor?");
    //    if (confirmDelete) {
    //        var rowToRemove = document.getElementById(`vendorRow_${vendorCode}`);
    //        if (rowToRemove) {
    //            rowToRemove.remove();
    //        }
    //    }
    //}
</script>

</body>
</html>
