# Modal

This is a very simple and lightweight script to create modals.

## Installation

This script is dependent on jQuery so be sure to include it first.
It is also fully compatible with AMD and CommonJS.

```html
<script src="/path/to/jquery.js"></script>
<script src="/path/to/modal.js"></script>
```

## Usage

```javascript
var modal = new Modal(options);
```

## Configuration

### yesText

    yesText: 'Yes'

### noText

    noText: 'No'

### appendTo

Selector describing where to append the newly created elements.

    appendTo: 'body'

### fadeIn

    fadeIn: 100

### modalTemplate

    modalTemplate:
        '<div class="confirm-modal">
            <div class="confirm-modal-content"></div>
            <button class="confirm-modal-no"></button>
            <button class="confirm-modal-yes"></button>
        </div>'

## Author

[Laurent Guilbert](https://github.com/laurentguilbert)
