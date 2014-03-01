
//= require_self



 function getCookie(c_name)
    {
      var c_value = document.cookie;
      var c_start = c_value.indexOf(" " + c_name + "=");
      if (c_start == -1)
      {
      c_start = c_value.indexOf(c_name + "=");
      }
      if (c_start == -1)
      {
      c_value = null;
      }
      else
      {
      c_start = c_value.indexOf("=", c_start) + 1;
      var c_end = c_value.indexOf(";", c_start);
      if (c_end == -1)
      {
      c_end = c_value.length;
      }
      c_value = unescape(c_value.substring(c_start,c_end));
      }
      return c_value;
    }

    function setCookie(c_name,value,exdays)
    {
      var exdate=new Date();
      exdate.setDate(exdate.getDate() + exdays);
      var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
      document.cookie=c_name + "=" + c_value;
    }
    if( getCookie("login")){
      var id_odontologo=getCookie("login").substring(6);
    }
     
   // console.log(id_odontologo);


    var Odontologo_registrado =  Backbone.Model.extend({
        url : "/odontologos/"+id_odontologo
      });

     var odonto_registrado = new Odontologo_registrado();

    /*
    odonto_registrado.fetch({
        success:function () {
            //cuando termine
        }
    });
    */

    //consultorios

    var Consultorio =  Backbone.Collection.extend({
        url : "/consultorios"
      });

    
    var consultorio = new Consultorio();
    /*
    consultorio.fetch({
        success:function () {
          //console.log(consultorio.where({id_odontologo:parseInt(id_odontologo)}));
        }
    });
    */

    //especialidades

    var Especialidades =  Backbone.Collection.extend({
        url : "/specialities"
      });

   
    var especialidades = new Especialidades();
     /*
    especialidades.fetch({
        success:function () {
          //console.log(especialidades.where({id_odontologo:parseInt(id_odontologo)}));
        }
    });
    */

    //prepagadas
      var Prepagadas =  Backbone.Collection.extend({
        url : "/prepagadas"
      });

   
    var prepagadas = new Prepagadas();

      //Consultas
      var Consultas =  Backbone.Collection.extend({
        url : "/consulta"
      });

   
    var consultas = new Consultas();

      //MediosPagos
      var MediosPagos =  Backbone.Collection.extend({
        url : "/medio_pagos"
      });

   
    var medioPagos = new MediosPagos();


    //citas ordenadas

     var CitasO = Backbone.Collection.extend({
        url :'/appointments',
        comparator : function(c){
          return parseInt(c.get("hora"));
        }
      });

     var citas_o = new CitasO();

     //Horas Disponibles
      var Horas_DisPonibles =  Backbone.Collection.extend({
        url : "/horas_disponibles",
        comparator : function(c){
          return parseInt(c.get("hora"));
        }
      });

    var horas_disponibles = new Horas_DisPonibles(); 

    //Odontologos

    var Odontologos =  Backbone.Collection.extend({
        url : "/odontologos"
    });

    var odontologos = new Odontologos(); 

    //Odontologos

    var Pacientes =  Backbone.Collection.extend({
        url : "/pacientes"
    });

    var pacientes = new Pacientes(); 