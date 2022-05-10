
function requestURLParam(sParam){
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split("&");
    for (var i = 0; i < sURLVariables.length; i++){
        var sParameterName = sURLVariables[i].split("=");
        if(sParameterName[0] == sParam){
            return sParameterName[1];
        }
    }
}
function formDataJsonStr(formArray) {
	var returnArray = {};
	for (var i = 0; i < formArray.length; i++){
		returnArray[formArray[i]['name']] = formArray[i]['value'];
	}
	return JSON.stringify(returnArray);
}




function haeVeneet(){
	$("#listaus tbody").empty();
	$.ajax({url:"veneet/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){
		console.log(result);
		$.each(result.veneet, function(i, field){
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.tunnus+"</td>";
        	htmlStr+="<td>"+field.nimi+"</td>";
        	htmlStr+="<td>"+field.merkkimalli+"</td>";
        	htmlStr+="<td>"+field.pituus+"</td>";
        	htmlStr+="<td>"+field.leveys+"</td>";
        	htmlStr+="<td>"+field.hinta+"</td>";
        	htmlStr+="<td><a href='muutavene.jsp?tunnus="+field.tunnus+"'>Muuta</a>&nbsp";
        	htmlStr+="<a href='#' id='poista' onclick=poista('"+field.tunnus+"','"+field.nimi+"')>Poista</a></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        	
		});
	}});
}
function poista(tunnus, nimi){
	if(confirm("Poistetaanko vene numero "+tunnus+ " nimi: "+nimi+"?")){
		$.ajax({url:"veneet/"+tunnus, type:"DELETE", dataType:"json", success:function(result){
			if(result.response==0){
				alert("Veneen " + tunnus + " poisto ep‰onnistui.");
			}else if(result.response==1){
				alert("Veneen tunnus:" + tunnus + " nimi: "+nimi+" poisto onnistui.");
				haeVeneet();
			}
		}});
	}
	
}

function paivitaTiedot(){
	var formJsonStr = formDataJsonStr($("#muokkaa").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	console.log(formJsonStr);
	$.ajax({url:"veneet", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Veneen muokkaaminen ep‰onnistui.");
      	return true;
      }else if(result.response==1){			
      	$("#ilmo").html("Veneen muokkaaminen onnistui.");
      	$("#nimi, #merkkimalli, #pituus, #leveys, #hinta").val("");
		}
  }});	
}
function lisaaVene(){
	var formJsonStr = formDataJsonStr($("#lisaa").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	console.log(formJsonStr);
	$.ajax({url:"veneet", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Veneen lis‰‰minen ep‰onnistui");
      	return true;
      }else if(result.response==1){			
      	$("#ilmo").html("Veneen lis‰‰minen onnistui!");
      	$("#nimi, #merkkimalli, #pituus, #leveys, #hinta").val("");
		}
  }});	
}