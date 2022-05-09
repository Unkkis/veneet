<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta charset="ISO-8859-1">
<title>Veneen lisäys</title>
</head>
<body>
	<div class="container">
		<form id="lisaa">
			<table id="taulu" border="1">
				<thead>	
					<tr>
						<th colspan="6"><a href="listaaveneet.jsp">Takaisin venelistaukseen</a></th>
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
		</form>
	</div>
<script>
$(document).ready(function(){
	$("#nimi").focus();
	$("#lisaa").validate({						
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
				min: 5,
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
			lisaaVene();
			
		}		
	});
});

</script>

</body>
</html>