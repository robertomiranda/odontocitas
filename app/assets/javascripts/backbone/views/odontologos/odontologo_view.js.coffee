Odontocitas.Views.Odontologos ||= {}

class Odontocitas.Views.Odontologos.OdontologoView extends Backbone.View
  template: JST["backbone/templates/odontologos/odontologo"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()
    alert @model.get('nombre')
    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
