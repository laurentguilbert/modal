###
# Modal
# https://github.com/laurentguilbert/modal
#
# Copyright (c) 2015 Laurent Guilbert
# Released under the MIT license.
###

((factory) ->
  if typeof define == 'function' and define.amd
    # AMD
    define ['jquery'], factory
  else if typeof exports == 'object'
    # CommonJS
    factory(require 'jquery')
  else
    # Browser Global
    window.Modal = factory jQuery
)(($) ->
  moduleName = 'Modal'
  defaults =
    appendTo: 'body'
    fadeIn: 100
    keyboardClose: true

    overlay: true
    overlayClose: true

    closeButton: true,
    closeButtonTemplate:
      '<div class="modal-close">\
        <span class="modal-close-icon"></span>\
      </div>'

    keyboardYes: true
    yesText: 'Yes'
    noText: 'No'
    confirmModalTemplate:
      '<div class="confirm-modal">\
        <div class="confirm-modal-content"></div>\
        <button class="confirm-modal-no"></button>\
        <button class="confirm-modal-yes"></button>\
      </div>'

  class Modal

    constructor: (options) ->
      @defaults = defaults
      @options = $.extend defaults, options
      @_name = moduleName

      $(document).on 'keydown', (e) =>
        switch e.keyCode
          when 27
            if @options.keyboardClose
              @close()
          when 13
            if @$yesButton? and @$yesButton.is(':visible') and
                @options.keyboardYes
              @$yesButton.trigger 'click'

      if @options.overlay
        @$overlay = $('<div class="modal-overlay">').css
          display: 'none'
          position: 'fixed'
          top: 0
          left: 0
          height: '100%'
          width: '100%'
          zIndex: 1000
          backgroundColor: 'black'
          opacity: 0.7
        if @options.overlayClose
          @$overlay.on 'click', => @close()

      $ =>
        $(@options.appendTo).append(@$overlay)

        $('[data-modal-trigger]').on 'click', (e) =>
          modalId = $(e.target).data('modal-trigger')
          @show modalId
      return

    showModal: ($modal) ->
      if @options.closeButton and not $modal.find('.modal-close').length
        $close = $(@options.closeButtonTemplate).css
          position: 'absolute'
          right: '10px'
          top: '10px'
        $close.on 'click', => @close()
        $modal.append $close

      # Hide the modal off screen while we compute its width.
      $modal.css
        left: '-200%'
        position: 'fixed'
        top: '50%'
        zIndex: 1001
      $modal.show()
      $modal.css
        marginLeft: -$modal.outerWidth() / 2
        marginTop: -$modal.outerHeight() / 2
      $modal.hide()
      $modal.css 'left', '50%'

      if @options.overlay
        @$overlay.fadeIn(@options.fadeIn)
      $modal.fadeIn(@options.fadeIn)
      $modal

    confirm: (options) ->
      if not @$confirmModal?
        @$confirmModal = $(@options.confirmModalTemplate).css
          display: 'none'
          position: 'absolute',
          top: '50%',
          zIndex: 1002
        @$yesButton = @$confirmModal.find('.confirm-modal-yes')
        @$noButton = @$confirmModal.find('.confirm-modal-no')
        $(@options.appendTo).append(@$confirmModal)

      @$yesButton.off 'click'
      @$yesButton.on 'click', =>
        options.yesCallback() if options.yesCallback?
        @close()

      @$noButton.off 'click'
      @$noButton.on 'click', =>
        options.noCallback() if options.noCallback?
        @close()

      @$confirmModal.find('.confirm-modal-content').html(options.content or '')
      @$yesButton.html(options.yesText or @options.yesText)
      @$noButton.html(options.noText or @options.noText)

      @showModal @$confirmModal
      return

    show: (modalId) ->
      $modal = $ '[data-modal="' + modalId + '"]'
      if not $modal.length
        return
      @showModal $modal

    close: ->
      $('[data-modal]:visible').hide()
      if @options.overlay
        @$overlay.hide()
      if @$confirmModal? and @$confirmModal.is ':visible'
        @$confirmModal.hide()
      return
)
