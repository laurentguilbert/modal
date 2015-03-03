###
# Modal
# https://github.com/laurentguilbert/modal
#
# Copyright (c) 2015 Laurent Guilbert
# Released under the MIT license.
###

$ ->
  "use strict";

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
    modalConfirmationTemplate:
      '<div class="modal" data-role="confirmation">\
        <div class="modal-content"></div>\
        <button class="modal-no"></button>\
        <button class="modal-yes"></button>\
      </div>'

    notificationDuration: 5000
    modalNotificationTemplate:
      '<div class="modal" data-role="notification">\
        <div class="modal-content"></div>\
      </div>'

  class Modal

    constructor: (options) ->
      @defaults = defaults
      @options = $.extend defaults, options

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

        $(@options.appendTo).append(@$overlay)

        $('[data-modal-trigger]').on 'click', (e) =>
          modalId = $(e.target).data('modal-trigger')
          @show modalId
      return

    _open: ($modal) ->
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

      $modal.fadeIn(@options.fadeIn)

    confirm: (options) ->
      if not @$modalConfirmation?
        @$modalConfirmation = $(@options.modalConfirmationTemplate).hide()
        @$yesButton = @$modalConfirmation.find('.modal-yes')
        @$noButton = @$modalConfirmation.find('.modal-no')
        $(@options.appendTo).append(@$modalConfirmation)

      @$yesButton.off 'click'
      @$yesButton.on 'click', =>
        options.yesCallback() if options.yesCallback?
        @close()

      @$noButton.off 'click'
      @$noButton.on 'click', =>
        options.noCallback() if options.noCallback?
        @close()

      @$modalConfirmation.find('.modal-content').html(options.content or '')
      @$yesButton.html(options.yesText or @options.yesText)
      @$noButton.html(options.noText or @options.noText)

      if @options.overlay
        @$overlay.fadeIn(@options.fadeIn)
      @_open @$modalConfirmation
      return

    notify: (options) ->
      if not @$modalNotification?
        @$modalNotification = $(@options.modalNotificationTemplate).css
          display: 'none'
          position: 'absolute',
          top: '50%',
          zIndex: 1002
        $(@options.appendTo).append(@$modalNotification)

      @$modalNotification.attr('data-level', options.level or 'info');
      @$modalNotification.find('.modal-content').html(options.content or '')

      @_open @$modalNotification
      fadeNotification = =>
        @$modalNotification.fadeOut(@options.notificationFadeout)
      setTimeout(fadeNotification, @options.notificationDuration)

    show: (modalId) ->
      $modal = $ '[data-modal="' + modalId + '"]'
      if not $modal.length
        return
      if @options.overlay
        @$overlay.fadeIn(@options.fadeIn)
      @_open $modal

    close: ->
      $('.modal,[data-modal]').hide()
      if @options.overlay
        @$overlay.hide()
      return

  # Modal is a singleton and therefore should only be instantiated once.
  window.Modal or= new Modal(modalOptions ? {});

  return
