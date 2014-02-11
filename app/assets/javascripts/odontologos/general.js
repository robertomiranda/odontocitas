$(function(){
	//fondo
	$('body').css('background','#E6E6E6');

	//saludo
      var saludo_horas = moment().format('HH');
      
      if(saludo_horas>=0 && saludo_horas<=11){
        $('.saludo').html('Buenos Días');
        $('.saludo_p').html('Buenos Días');
      }

      if(saludo_horas>=12 && saludo_horas<=18){
        $('.saludo').html('Buenas Tardes');
        $('.saludo_p').html('Buenas Tardes');
      }

      if(saludo_horas>=19 && saludo_horas<=23){
        $('.saludo').html('Buenas Noches');
        $('.saludo_p').html('Buenas Noches');
      }


});