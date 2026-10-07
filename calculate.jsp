<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<%
    // ---------- Read & validate input ----------
    String name = request.getParameter("name");
    String unitsStr = request.getParameter("units");

    double units;
    try {
        units = Double.parseDouble(unitsStr);
        if (units < 0) throw new NumberFormatException();
    } catch (Exception e) {
        response.sendRedirect("index.jsp?error=" +
            java.net.URLEncoder.encode("Please enter a valid, non-negative number of units.", "UTF-8"));
        return;
    }
    if (name == null || name.trim().isEmpty()) {
        name = "Consumer";
    }

    // ---------- Slab-wise calculation ----------
    double slab1 = 0, slab2 = 0, slab3 = 0, slab4 = 0;   // units in each slab
    double rate1 = 3.50, rate2 = 4.00, rate3 = 5.20, rate4 = 6.50;
    double remaining = units;

    // First 50 units
    slab1 = Math.min(remaining, 50);
    remaining -= slab1;

    // Next 100 units (51 - 150)
    if (remaining > 0) {
        slab2 = Math.min(remaining, 100);
        remaining -= slab2;
    }

    // Next 100 units (151 - 250)
    if (remaining > 0) {
        slab3 = Math.min(remaining, 100);
        remaining -= slab3;
    }

    // Above 250 units
    if (remaining > 0) {
        slab4 = remaining;
    }

    double cost1 = slab1 * rate1;
    double cost2 = slab2 * rate2;
    double cost3 = slab3 * rate3;
    double cost4 = slab4 * rate4;

    double totalEnergyCharge = cost1 + cost2 + cost3 + cost4;

    // Optional standard charges (kept simple / transparent)
    double meterRent = 30.00;                 // fixed meter rent
    double dutyRate = 0.05;                    // 5% electricity duty on energy charge
    double electricityDuty = totalEnergyCharge * dutyRate;

    double grandTotal = totalEnergyCharge + meterRent + electricityDuty;

    DecimalFormat df = new DecimalFormat("#,##0.00");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bill Summary</title>
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
        background: #fff;
        width: 100%;
        max-width: 520px;
        border-radius: 16px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.3);
        overflow: hidden;
    }

    .card-header {
        background: linear-gradient(135deg, #11998e, #38ef7d);
        padding: 26px 24px;
        text-align: center;
        color: #063;
    }

    .card-header h1 { font-size: 21px; }
    .card-header p  { margin-top: 4px; font-size: 13px; }

    .card-body { padding: 24px; }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 18px;
        font-size: 14px;
    }

    th, td {
        text-align: left;
        padding: 10px 8px;
        border-bottom: 1px solid #eee;
    }

    th { color: #203a43; font-size: 12.5px; text-transform: uppercase; letter-spacing: 0.5px; }
    td.num, th.num { text-align: right; }

    .summary-row td {
        font-weight: 600;
        color: #203a43;
    }

    .total-box {
        background: #f4f6f7;
        border-radius: 10px;
        padding: 16px 18px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 6px;
    }

    .total-box .label { font-size: 14px; color: #555; }
    .total-box .amount { font-size: 24px; font-weight: 700; color: #11998e; }

    .btn {
        display: block;
        width: 100%;
        text-align: center;
        margin-top: 20px;
        padding: 12px;
        background: linear-gradient(135deg, #0f2027, #203a43);
        color: #fff;
        text-decoration: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 600;
    }

    @media (max-width: 480px) {
        table { font-size: 12.5px; }
        .total-box .amount { font-size: 20px; }
    }
</style>
</head>
<body>

<div class="card">
    <div class="card-header">
        <h1>✅ Bill Generated Successfully</h1>
        <p>Consumer: <strong><%= name %></strong> &nbsp;|&nbsp; Units Consumed: <strong><%= df.format(units) %></strong></p>
    </div>

    <div class="card-body">
        <table>
            <tr>
                <th>Slab</th>
                <th class="num">Units</th>
                <th class="num">Rate</th>
                <th class="num">Amount (Rs.)</th>
            </tr>
            <tr>
                <td>First 50 units</td>
                <td class="num"><%= df.format(slab1) %></td>
                <td class="num"><%= df.format(rate1) %></td>
                <td class="num"><%= df.format(cost1) %></td>
            </tr>
            <tr>
                <td>Next 100 units</td>
                <td class="num"><%= df.format(slab2) %></td>
                <td class="num"><%= df.format(rate2) %></td>
                <td class="num"><%= df.format(cost2) %></td>
            </tr>
            <tr>
                <td>Next 100 units</td>
                <td class="num"><%= df.format(slab3) %></td>
                <td class="num"><%= df.format(rate3) %></td>
                <td class="num"><%= df.format(cost3) %></td>
            </tr>
            <tr>
                <td>Above 250 units</td>
                <td class="num"><%= df.format(slab4) %></td>
                <td class="num"><%= df.format(rate4) %></td>
                <td class="num"><%= df.format(cost4) %></td>
            </tr>
            <tr class="summary-row">
                <td colspan="3">Energy Charge</td>
                <td class="num">Rs. <%= df.format(totalEnergyCharge) %></td>
            </tr>
            <tr class="summary-row">
                <td colspan="3">Meter Rent</td>
                <td class="num">Rs. <%= df.format(meterRent) %></td>
            </tr>
            <tr class="summary-row">
                <td colspan="3">Electricity Duty (5%)</td>
                <td class="num">Rs. <%= df.format(electricityDuty) %></td>
            </tr>
        </table>

        <div class="total-box">
            <span class="label">Total Payable Amount</span>
            <span class="amount">Rs. <%= df.format(grandTotal) %></span>
        </div>

        <a href="index.jsp" class="btn">Calculate Another Bill</a>
    </div>
</div>

</body>
</html>
