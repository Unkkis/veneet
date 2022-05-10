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
<style>
html { background-image:url(images/marina2.jpg); 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
</style>
<title>Veneen muuttaminen</title>
</head>
<body id="muutavene">
	<div class="container">
		<form id="muokkaa">
			<table id="taulu" border="1" class="listaus">
				<thead>	
					<tr>
						<th colspan="6"><a href="listaaveneet.jsp">Takaisin venelistaukseen</a><span id="ilmo">Veneen muokkaus</span></th>
					</tr>
					<tr>
						<th>Nimi</th>
						<th>Merkki ja malli</th>
						<th>Pituus</th>
						<th>Leveys</th>
						<th>Hinta</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" name="nimi" id="nimi"></td>
						<td><input type="text" name="merkkimalli" id="merkkimalli"></td>
						<td><input type="number" name="pituus" id="pituus"></td>
						<td><input type="number" name="leveys" id="leveys"></td>
						<td><input type="number" name="hinta" id="hinta"></td> 
						<td><input type="submit" id="tallenna" value="Lisää"></td>
					</tr>
				
				</tbody>		
			</table>
			<input type="hidden" name="tunnus" id="tunnus">	
		</form>
	</div>
</body>
<script>
$(document).ready(function(){

	var tunnus = requestURLParam("tunnus");
	$.ajax({url:"veneet/haeyksi/"+tunnus, type:"GET", dataType:"json", success:function(result){
		$("#tunnus").val(result.tunnus);
		$("#nimi").val(result.nimi);
		$("#merkkimalli").val(result.merkkimalli);
		$("#pituus").val(result.pituus);
		$("#leveys").val(result.leveys);
		$("#hinta").val(result.hinta);
	}});
	$("#muokkaa").validate({						
		rules: {
			nimi:  {
				required: true,
				minlength: 3				
			},	
			merkkimalli:  {
				required: true,
				minlength: 3				
			},
			pituus:  {
				required: true,
				min: 3,
				max: 90,
				number: true
			},	
			leveys:  {
				required: true,
				min: 1,
				max: 30,
				number: true
			},
			hinta:  {
				required: true,
				min: 100,
				digits: true
			}	
		},
		messages: {
			nimi: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt"			
			},
			merkkimalli: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			pituus: {
				required: "Puuttuu",
				min: "Liian pieni numero",
				max: "Liian suuri",
				number: "Syötä vain numeroita"
			},
			leveys: {
				required: "Puuttuu",
				min: "Liian pieni numero",
				max: "Liian suuri",
				number: "Liian pieni"
			},
			hinta: {
				required: "Puuttuu",
				min: "Liian halpa",
				digits: "Syötä vain kokonaislukuja"
			}
		},	
		submitHandler: function(form) {	
			paivitaTiedot();
			
	}		
});
});
</script>
</html>