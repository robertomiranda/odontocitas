Odontocitas.Views.Odontologos ||= {}

class Odontocitas.Views.Odontologos.ShowView extends Backbone.View
  template: JST["backbone/templates/odontologos/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
