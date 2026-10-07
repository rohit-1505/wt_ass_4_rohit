<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Electricity Bill Calculator</title>
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
        font-family: 'Segoe UI', Arial, sans-serif;
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
        padding: 20px;
    }

    .card {
        background: #ffffff;
        width: 100%;
        max-width: 480px;
        border-radius: 16px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.3);
        overflow: hidden;
    }

    .card-header {
        background: linear-gradient(135deg, #f7971e, #ffd200);
        padding: 28px 24px;
        text-align: center;
    }

    .card-header h1 {
        font-size: 22px;
        color: #1a1a1a;
    }

    .card-header p {
        margin-top: 6px;
        font-size: 13px;
        color: #333;
    }

    .card-body {
        padding: 28px 24px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #203a43;
        font-size: 14px;
    }

    input[type="text"], input[type="number"] {
        width: 100%;
        padding: 12px 14px;
        border: 2px solid #dfe6e9;
        border-radius: 8px;
        font-size: 15px;
        transition: border-color 0.2s;
    }

    input[type="text"]:focus, input[type="number"]:focus {
        outline: none;
        border-color: #f7971e;
    }

    .btn {
        width: 100%;
        padding: 13px;
        background: linear-gradient(135deg, #0f2027, #203a43);
        color: #fff;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.15s, opacity 0.2s;
    }

    .btn:hover { opacity: 0.9; transform: translateY(-1px); }
    .btn:active { transform: translateY(0); }

    .rates {
        margin-top: 22px;
        padding: 14px 16px;
        background: #f4f6f7;
        border-radius: 8px;
        font-size: 12.5px;
        color: #555;
        line-height: 1.6;
    }

    .rates strong { color: #203a43; }

    .error {
        background: #ffe3e3;
        color: #c0392b;
        padding: 10px 14px;
        border-radius: 8px;
        margin-bottom: 18px;
        font-size: 13.5px;
        text-align: center;
    }

    @media (max-width: 480px) {
        .card-header h1 { font-size: 19px; }
        .card-body { padding: 22px 18px; }
    }
</style>
</head>
<body>

<div class="card">
    <div class="card-header">
        <h1>⚡ Electricity Bill Calculator</h1>
        <p>Enter your consumed units to calculate the bill</p>
    </div>
    <div class="card-body">

        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
                <div class="error"><%= error %></div>
        <%
            }
        %>

        <form action="calculate.jsp" method="post">
            <div class="form-group">
                <label for="name">Consumer Name</label>
                <input type="text" id="name" name="name" placeholder="Enter your name" required>
            </div>

            <div class="form-group">
                <label for="units">Units Consumed (kWh)</label>
                <input type="number" id="units" name="units" placeholder="e.g. 175" min="0" step="0.01" required>
            </div>

            <button type="submit" class="btn">Calculate Bill</button>
        </form>

        <div class="rates">
            <strong>Tariff Slabs</strong><br>
            First 50 units &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Rs. 3.50 / unit<br>
            Next 100 units (51&ndash;150) - Rs. 4.00 / unit<br>
            Next 100 units (151&ndash;250) - Rs. 5.20 / unit<br>
            Above 250 units &nbsp; - Rs. 6.50 / unit
        </div>

    </div>
</div>

</body>
</html>
