QUnit.assert.modalHidden = function($modal) {
    var isHidden = $modal.not(':visible');
    this.ok(isHidden, 'Modal is hidden.');
};

QUnit.assert.modalVisible = function($modal) {
    var isVisible = $modal.is(':visible');
    this.ok(isVisible, 'Modal is visible.');
};

module('modal', {
    beforeEach: function() {
        this.$simpleModal = $('.simple-modal');
        this.$simpleModalButton = $('.simple-modal-button');
        this.$confirmModalButton = $('.confirm-modal-button');
    }
});

test('trigger simple modal', function(assert) {
    assert.expect(2);
    assert.modalHidden(this.$simpleModal);
    this.$simpleModalButton.trigger('click');
    assert.modalVisible(this.$simpleModal);
});

test('trigger confirm modal', function(assert) {
    assert.expect(2);
    assert.ok($('.confirm-modal').length === 0, 'Modal is not created yet');
    Modal.confirm({});
    this.$confirmModalButton.trigger('click');
    assert.modalVisible($('.confirm-modal'));
});
