//= require action_cable
(function() {
  this.AppCable || (this.AppCable = {});

  AppCable.cable = ActionCable.createConsumer();

}).call(this);
