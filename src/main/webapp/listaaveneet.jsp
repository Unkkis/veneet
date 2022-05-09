<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta charset="ISO-8859-1">
<title>Veneiden listaus</title>
</head>
<body>
<body>

	<div class="container">
	<table  id="listaus" border="1" >
		<thead>
			<tr>
				<th colspan="7"><a href="lisaavene.jsp">Lisää uusi vene</a></th>
			</tr>
			<tr>
				<th colspan="2" id="haku">Hakusana:</th>
				<th colspan="2"><input type="text" id="hakusana"></th>
				<th colspan="3"><input type="button" value="Hae" id="hakunappi"><input type="button" value="Tyhjennä" id="tyhjennys"></th>
			</tr>
			<tr>
				<th>Tunnus</th>
				<th>Nimi</th>
				<th>Malli ja merkki</th>
				<th>Pituus</th>
				<th>Leveys</th>
				<th>Hinta</th>
				<th></th>
			</tr>
		
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
<script>
$(document).ready(function(){
	
	haeVeneet();
	$("#hakunappi").click(function(){		
		haeVeneet();
	});
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ //Kun Enteriä on painettu, ajetaan haku
			  haeVeneet();
		  }
	});
	$("#hakusana").focus();
	
	$("#tyhjennys").click(function() {
		$('#hakusana').val('');
		haeVeneet();
	    });
});

</script>
</body>
</html>