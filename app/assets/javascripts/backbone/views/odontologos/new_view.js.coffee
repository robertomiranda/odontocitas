Odontocitas.Views.Odontologos ||= {}

class Odontocitas.Views.Odontologos.NewView extends Backbone.View
  template: JST["backbone/templates/odontologos/new"]

  events:
    "submit #new-odontologo": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (odontologo) =>
        @model = odontologo
        window.location.hash = "/#{@model.id}"

      error: (odontologo, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
