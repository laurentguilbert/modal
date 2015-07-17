QUnit.assert.modalHidden = function($modal) {
    this.ok($modal.not(':visible'), 'Modal is hidden.');
};

QUnit.assert.modalVisible = function($modal) {
    this.ok($modal.is(':visible'), 'Modal is visible.');
};

module('modal', { beforeEach: function() {} });

test('trigger simple modal', function(assert) {
    var $simpleModal = $('.simple-modal');
    var $simpleModalButton = $('.simple-modal-button');
    assert.expect(2);
    assert.modalHidden($simpleModal);
    $simpleModalButton.trigger('click');
    assert.modalVisible($simpleModal);
});

test('trigger confirm modal', function(assert) {
    assert.expect(3);
    assert.ok(
        $('.modal[data-role="confirmation"]').length === 0,
        'Modal is not created yet'
    );
    Modal.confirm({});
    var $confirmModal = $('.modal[data-role="confirmation"]');
    assert.modalVisible($confirmModal);
    $confirmModal.find('.modal-yes').trigger('click');
    assert.modalHidden($confirmModal);
});
