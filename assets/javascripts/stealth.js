jQuery(function($) {

  window.RedmineStealth = {
    activate: function(label) {
      $('#stealth_toggle').text(label).data({params: {toggle: 'false'}});
      $('body').removeClass('stealth_off').addClass('stealth_on');
    },

    deactivate: function(label) {
      $('#stealth_toggle').text(label).data({ params : { toggle : 'true' } });
      $('body').removeClass('stealth_on').addClass('stealth_off');
    },

    notifyFailure: function() {
      alert(RedmineStealth.failureMessage);
    },

    failureMessage: "Failed to toggle stealth mode."
  };

  $('#stealth_toggle').bind('ajax:error', RedmineStealth.notifyFailure);
});
