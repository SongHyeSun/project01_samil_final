<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">
<meta charset="UTF-8">
<title>급여 명세서</title>
</head>
<style type="text/css">
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 20px;
}

main {
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    margin: 0 auto;
    max-width: 600px;
    text-align: center;
}

h3 {
    color: #333;
    border-bottom: 2px solid #8C8C8C;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
}

th, td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background-color: #6E6E6E;
    color: white;
}

input[type="text"] {
    width: 90%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
    background-color: #f9f9f9;
    text-align: right;
}
</style>
<body>
<main>
    <h3>${joinList.SALNUM } 급여 명세서</h3>
    급여 지급일 : ${joinList.SALDATE}
    <table>
        <thead>
            <tr><th>지급 항목명</th><th>금액 (${joinList.EMPNO}, ${joinList.NAME })</th></tr>
        </thead>
        <tbody>
            <tr><th>기본급</th><td><input type="text" value="<fmt:formatNumber value='${joinList.SALBASE}' type='currency' />" class="text" readonly="readonly" id="base">  </td></tr>
            <tr><th>식대</th><td><input type="text" value="<fmt:formatNumber value='${joinList.SALFOOD}' type='currency' />" class="text" readonly="readonly" id="food"></td></tr>
            <tr><th>상여금</th><td><input type="text" value="<fmt:formatNumber value='${joinList.SALBONUS}' type='currency' />" class="text" readonly="readonly" id="bonus"></td></tr>
            <tr><th>추가수당</th><td><input type="text" value="<fmt:formatNumber value='${joinList.SALNIGHT}' type='currency' />" class="text" readonly="readonly" id="night"></td></tr>
            <tr><th>지급합계</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="total" value="<fmt:formatNumber value='${joinList.SALTOTAL}' type='currency' />" class="text"></th></tr>
            <tr><th>소득세</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="tax" value="<fmt:formatNumber value='${joinList.TAX}' type='currency' />" class="text"></th></tr>
            <tr><th>공제총합</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="taxSum" value="<fmt:formatNumber value='${joinList.TAX}' type='currency' />" class="text"></th></tr>
            <tr><th>차인지급액</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="salFinal" value="<fmt:formatNumber value='${joinList.SALFINAL}' type='currency' />" class="text"></th></tr>
        </tbody>
    </table>
    <button class="btn btn-secondary" onclick="window.close()">닫기</button>
</main>
</body>
</html>
