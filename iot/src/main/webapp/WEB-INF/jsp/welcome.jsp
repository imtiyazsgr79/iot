<%@page import="org.apache.taglibs.standard.tag.el.core.ImportTag"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" type="text/css" href="css/style.css">

<title>Dash board Iot</title>

</head>
<body>

	<p style="color: Blue;" align="center">WELCOME TO IOT OUTPUT CONTROL DASHBOARD</p>
	<p style="color: white;" align="center">
		<a href="/addoutput">Click here to create outputs</a>
	</p>
	
<%-- <% response.setIntHeader("Refresh", 6); %> --%>
	
	<c:forEach items="${outputs }" var="output">


		<h3>
			${output.name } - Board ${output.board } - GPIO ${output.gpio } (<i><a
				onclick="deleteOutput(this)" href="javascript:void(0);"
				id="${output.id }">Delete</a></i>)
		</h3>
		 <c:if test = "${output.state ==0}">
         
         <label class="switch">
			<input type="checkbox"
				onchange="updateOutput( this )" value="${output.id }" id="chk${output.id}">
				<span class="slider"></span>
		</label>
         
      </c:if>
      
       <c:if test = "${output.state ==1}">
         
         <label class="switch">
			<input type="checkbox"
				onchange="updateOutput( this )" value="${output.id }" checked id="chk${output.id}">
				<span class="slider"></span>
				
		</label>
         
      </c:if>
		
        



</c:forEach>
<script>

function updateOutput(element) {
	console.log(element);
  var xhr = new XMLHttpRequest();
    //xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    if(element.checked){
       // xhr.open("GET", "/iot="+element.id+"&state=1", true);
        xhr.open("GET", "update/"+element.value+"/1",true);
       // xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    }
    else {
        xhr.open("GET", "/update/"+element.value+"/0", true);
        //xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    }
    xhr.send(); 
    	 
    
}


setInterval(function(){
		console.log('calling');
		var url="/allOutputs"
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.open( "GET", url, false ); // false for synchronous request
        	xmlHttp.send( null );
            var data = JSON.parse(xmlHttp.responseText);
        	data.forEach(function(item){
        		var id="chk"+item.id;
        		if(Number(item.state) === 1){
        			document.getElementById(id).setAttribute("checked", "checked");
        		}
        		else{
        			document.getElementById(id).removeAttribute("checked");
        		}
        	});
        }, 5000);
        


function deleteOutput(element) {
    var result = confirm("Want to delete this output?");
    if (result) {
        var xhr = new XMLHttpRequest();
        xhr.open("DELETE", "delete/"+element.id, true);
        xhr.send();
        alert("Output deleted");
        setTimeout(function(){ window.location.reload(); });
    }
   
}

//setInterval('location.reload()',30000);


</script>









</body>
</html>