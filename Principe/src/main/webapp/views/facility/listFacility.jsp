<%@ page import="dao.FacilityDAO,java.util.*,model.Facility" %>

<%
    FacilityDAO dao = new FacilityDAO();
    List<Facility> list = dao.getAll();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Facilities | Principe Grand</title>
    <meta charset="UTF-8">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)),
                        url('https://images.unsplash.com/photo-1582719508461-905c673771fd');
            background-size: cover;
            background-position: center;
            color: white;
        }

        .container {
            padding: 50px;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 38px;
            color: #d4af37;
            margin-bottom: 25px;
        }

        .top-buttons {
            margin-bottom: 25px;
        }

        .btn {
            padding: 8px 18px;
            border-radius: 25px;
            text-decoration: none;
            font-size: 14px;
            margin-right: 10px;
            transition: 0.3s;
            cursor: pointer;
            display: inline-block;
        }

        .back-btn {
            background: transparent;
            border: 1px solid #d4af37;
            color: #d4af37;
        }

        .back-btn:hover {
            background: #d4af37;
            color: black;
        }

        .add-btn {
            background: #28a745;
            color: white;
        }

        .add-btn:hover {
            background: #218838;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.07);
            backdrop-filter: blur(8px);
            border-radius: 15px;
            overflow: hidden;
        }

        th {
            background: #d4af37;
            color: black;
            padding: 15px;
            text-transform: uppercase;
            font-size: 14px;
        }

        td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        tr:hover {
            background: rgba(212,175,55,0.12);
            transition: 0.3s;
        }

        .action-btn {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            text-decoration: none;
            margin: 0 4px;
            transition: 0.3s;
        }

        .edit-btn {
            background: #17a2b8;
            color: white;
        }

        .edit-btn:hover {
            background: #138496;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
        }

        .delete-btn:hover {
            background: #b02a37;
        }

        .no-data {
            color: #ccc;
            font-size: 15px;
            margin-top: 20px;
        }

    </style>
</head>

<body>

<div class="container">

    <h2>Manage Facilities</h2>

    <div class="top-buttons">
        <button class="btn back-btn"
            onclick="window.location.href='<%= request.getContextPath() %>/views/adminDashboard.jsp'">
             Back to Dashboard
        </button>

        <a href="addFacility.jsp" class="btn add-btn">
             Add Facility
        </a>
    </div>

    <%
    if(list != null && !list.isEmpty()){
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Facility Name</th>
            <th>Description</th>
            <th>Action</th>
        </tr>

        <% for(Facility f : list){ %>
        <tr>
            <td><%=f.getFacilityId()%></td>
            <td><%=f.getFacilityName()%></td>
            <td><%=f.getDescription()%></td>
            <td>
                <a href="editFacility.jsp?facilityId=<%=f.getFacilityId()%>"
                   class="action-btn edit-btn">
                   Edit
                </a>

                <a href="../../FacilityServlet?action=delete&facilityId=<%=f.getFacilityId()%>"
                   class="action-btn delete-btn"
                   onclick="return confirm('Delete this facility?')">
                   Delete
                </a>
            </td>
        </tr>
        <% } %>

    </table>

    <%
    } else {
    %>

        <p class="no-data">No facilities available.</p>

    <%
    }
    %>

</div>

</body>
</html>