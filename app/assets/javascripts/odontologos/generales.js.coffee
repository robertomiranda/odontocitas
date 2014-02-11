#	getCookie = (a) ->
#		c_value = document.cookie
#		c_start = c_value.indexOf(" " + a + "=")
#		if c_start == -1
#			c_start = c_value.indexOf(a + "=")
#
#		if c_start == -1 
#			c_value = null
#		else
#			c_start = c_value.indexOf("=", c_start) + 1
#			c_end = c_value.indexOf(";", c_start)
#
#		if c_end == -1
#			c_end = c_value.length
#			c_value = unescape(c_value.substring(c_start,c_end))
#	  
#		c_value
#
#
#	id_odontologo = getCookie("login").substring(6,7);
#	console.log(id_odontologo)
#
#	setCookie = (c_name,value,exdays) ->
#		exdate =new Date()
#		exdate.setDate(exdate.getDate() + exdays)
#		c_value = if escape(value) + exdays==null then "" else "; expires="+exdate.toUTCString()
#		document.cookie = c_name + "=" + c_value
#
#	class Odontologo_registrado extends Backbone.Collection
#		url : "/odontologos/"+id_odontologo
#
#
#	prueba = new Odontologo_registrado()
#	console.log(prueba);


	