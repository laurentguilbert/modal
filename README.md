# Modal

This is a very simple and lightweight script to create modals.

It allows you to create **lightboxes**, **confirmation dialogs** and **self-destruct notifications**.

Look at the included demo for examples of what you can do.

## Installation

Modal uses jQuery and therefore you need to include it before the script itself.

```html
<script src="/path/to/jquery.js"></script>
<script src="/path/to/modal.js"></script>
```

## Usage

Once the script is included you'll have access to the global module `Modal`.

### Lightbox

Lightboxes are automatically detected and binded using a specific markup.

Set `data-modal` on the element you wish to display inside a lightbox and `data-modal-trigger` on the element to serve as the trigger.

Those attributes must have matching values representing your modal id.

Alternatively, you can open the lightbox manually using:

```javascript
Modal.show(modalId);
```

### Confirmation

```javascript
Modal.confirm({options});
```

#### Available options

`content`

Content of the modal (HTML is allowed).

`yesCallback`

Function to be called if the user approves.

`noCallback`

Function to be called if the user disapproves.

`yesText`

Override default yesText.

`noText`

Override default NoText.

### Notification

```javascript
Modal.notify({options});
```

#### Available options

`level`

Level of importance of the notification.
The attribute `data-level` will be set accordingly on the modal.

`content`

Content of the modal (HTML is allowed).

### Close

```javascript
Modal.close();
```

Manually close the modal.

## Configuration

The script will automatically look for an object called `modalOptions` and will override its default options accordingly.

### appendTo

    appendTo: 'body'


Selector describing where to append the dynamically created modals.

### fadeIn

    fadeIn: 100

Duration of the fadeIn effect.


### keyboardClose

    keyboardClose: true

Use the escape key to close the modal.


### overlay

    overlay: true

Use a dark transparent overlay for the modals to sit onto (not used with notifications).

### overlayClose

    overlayClose: true

Clicking on the overlay will close the modal.

### closeButton

    closeButton: true

Add a close button inside the modal.

### keyboardYes

    keyboardYes: true

Use the enter key to validate a confimation modal.

### yesText

    yesText: 'Yes'

Text used for approval inside confirmation modals.

### noText

    noText: 'No'

Text used for disaproval inside confirmation modals.

### notificationDuration

    notificationDuration: 5000

How much time should the notification be visible.

### notificationFadeout

    notificationFadeout: 100

Duration of the fadeOut effect for notifications.

### closeButtonTemplate

```html
<div class="modal-close">
  <span class="modal-close-icon"></span>
</div>
```

### modalConfirmationTemplate

```html
<div class="modal" data-role="confirmation">
  <div class="modal-content"></div>
  <button class="modal-no"></button>
  <button class="modal-yes"></button>
</div>
```

### modalNotificationTemplate

```html
<div class="modal" data-role="notification">
  <div class="modal-content"></div>
</div>
```

## Author

[Laurent Guilbert](https://github.com/laurentguilbert)
