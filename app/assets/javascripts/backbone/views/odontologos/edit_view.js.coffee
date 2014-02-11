Odontocitas.Views.Odontologos ||= {}

class Odontocitas.Views.Odontologos.EditView extends Backbone.View
  template : JST["backbone/templates/odontologos/edit"]

  events :
    "submit #edit-odontologo" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (odontologo) =>
        @model = odontologo
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
