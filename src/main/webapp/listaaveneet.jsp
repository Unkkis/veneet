<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="https://fonts.googleapis.com/css2?family=Oleo+Script+Swash+Caps&family=Roboto&display=swap" rel="stylesheet">
<meta charset="ISO-8859-1">
<title>Veneiden listaus</title>
<style>
html { background-image:url(images/marina2.jpg); 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
</style>
</head>
<body id="listaaveneet">
	<div class="container">
	<table  id="listaus" border="1" class="listaus">
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
</body>
<script>
$(document).ready(function(){
	haeVeneet();
	
	$("#listaaveneet").on("keydown", function(event){
		if(event.which==13){ //Kun Enteriä on painettu, ajetaan haku
		haeVeneet();
		 }
	});
		
	$("#hakunappi").click(function(){		
		haeVeneet();
		$("#hakusana").focus();
	});
	
	$("#hakusana").focus();
	
	$("#tyhjennys").click(function() {
		$('#hakusana').val('');
		haeVeneet();
   });

	
});
</script>
</html>