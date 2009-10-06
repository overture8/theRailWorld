var formWorker = Class.create({
  initialize: function(form, items) {
    this.form = $(form);
    this.form.observe('submit', this.submitForm.bindAsEventListener(this));

    this.items = $(items);
  },

  submitForm: function(event) {
    event.stop();

    this.form.request({
      onSuccess: this.commentCreated.bindAsEventListener(this)
    });
  },

  commentCreated: function(transport) {
    this.items.insert({ top: transport.responseText });

    new_comment = this.messages.down('div.comment');
    new Effect.Highlight(new_comment);
  }
});

Event.observe(window, 'load', function () {
  new formWorker('new_comment', 'comments');
}); 
