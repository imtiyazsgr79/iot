<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" >

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>ESP Output Control</title>
</head>
<body>
	<h2>ESP Output Control</h2>
	<?php echo $html_buttons; ?>
	<br>
	<br>
	<?php echo $html_boards; ?>
	<br>
	<br>
	<!-- onsubmit="return createOutput();" -->
	<div>
		<form:form action="addoutput" method="post" modelAttribute="outputs">
			<h3>Create New Output</h3>
			<label for="outputName">Name</label>
			<form:input type="text" path="name" id="outputName" />
			<br>
			<label for="outputBoard">Board ID</label>
			<form:input type="number" path="board" min="0" id="outputBoard" />
			<label for="outputGpio">GPIO Number</label>
			<form:input type="number" path="gpio" min="0" id="outputGpio" />
			<label for="outputState">Initial GPIO State</label>
			<form:select id="outputState" path="state">
				<form:option value="0">0 = OFF</form:option>
				<form:option value="1">1 = ON</form:option>
			</form:select>
			<input type="submit" value="Create Output">
			<p>
				<strong>Note:</strong> in some devices, you might need to refresh
				the page to see your newly created buttons or to remove deleted
				buttons.
			</p>
		</form:form>
	</div>

	<script>
        function updateOutput(element) {
            var xhr = new XMLHttpRequest();
            if(element.checked){
                xhr.open("GET", "http://localhost:8080/outputs="+element.id+"&state=1", true);
            }
            else {
                xhr.open("GET", "/outputs="+element.id+"&state=0", true);
            }
            xhr.send();
        }

       function deleteOutput(element) {
            var result = confirm("Want to delete this output?");
            if (result) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "esp-outputs-action.php?action=output_delete&id="+element.id, true);
                xhr.send();
                alert("Output deleted");
                setTimeout(function(){ window.location.reload(); });
            }
        } 

        function createOutput(element) { 
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "esp-outputs-action.php", true);
            //xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.setRequestHeader("Content-Type", "application/json");

           //alert(xhr);
            xhr.onreadystatechange = function(data) { console.log('res'+data.response);
                if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
                    alert("Output created");
                    setTimeout(function(){ window.location.reload(); });
                }
            }
            var outputName = document.getElementById("outputName").value;
            var outputBoard = document.getElementById("outputBoard").value;
            var outputGpio = document.getElementById("outputGpio").value;
            var outputState = document.getElementById("outputState").value;
            var httpRequestData = "action=output_create&name="+outputName+"&board="+outputBoard+"&gpio="+outputGpio+"&state="+outputState;
            xhr.send(httpRequestData);
        }
    </script>
</body>
</html>