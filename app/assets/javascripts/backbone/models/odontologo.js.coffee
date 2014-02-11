class Odontocitas.Models.Odontologo extends Backbone.Model
  paramRoot: 'odontologo'

  defaults:
    nombre: null
    apellido: null
    correo: null
    especialidad: null
    clave: null
    celular: null
    telefono: null
    direccion: null
    usuario: null

class Odontocitas.Collections.OdontologosCollection extends Backbone.Collection
  model: Odontocitas.Models.Odontologo
  url: '/odontologos'
