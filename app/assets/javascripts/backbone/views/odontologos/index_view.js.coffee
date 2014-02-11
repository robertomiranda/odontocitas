Odontocitas.Views.Odontologos ||= {}

class Odontocitas.Views.Odontologos.IndexView extends Backbone.View
  template: JST["backbone/templates/odontologos/index"]

  initialize: () ->
    @options.odontologos.bind('reset', @addAll)

  addAll: () =>
    @options.odontologos.each(@addOne)

  addOne: (odontologo) =>
    view = new Odontocitas.Views.Odontologos.OdontologoView({model : odontologo})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(odontologos: @options.odontologos.toJSON() ))
    @addAll()

    return this
