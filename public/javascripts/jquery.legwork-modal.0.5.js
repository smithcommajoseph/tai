/*************************************************** 
 * Copyright © 2011 Legwork. All Rights Reserved.  *
 * Updated by: Matt Wiggins, 10-May-2011           *
 *                                                 *
 * Legwork modals have magical powers.             *
 ***************************************************
/                                                 */
/* Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php */

// TODO: wrapper so that something like $('<h1>Yeah girl!</h1><p>Oh, oops.</p>').modal() doesn't break?

// v0.5
;(function($) {
  
  // methods
  var methods = {
    
    init:function(options) {
      return this.each(function() {
      
        // vars
        var $this = $(this),
            settings = $.extend({}, $.fn.modal.defaults, options),
            rip = false,
            bg = $('<div />').css({
              'position':'fixed',
              'top':'0px',
              'left':'0px',
              'width':'100%',
              'height':'100%',
              'background':settings.background[1] === 'none' ? settings.background[0] : 'url(' + settings.background[1] + ') top left repeat',
              'z-index':'49000',
              'opacity':'0'
            });
        
        // clone
        if(settings.clone === true) {
          $this = $this.clone();
        }
        
        // add to DOM if it's an illegitimate child
        if($this.parent().length === 0) {
          $this.appendTo('body');
          rip = true;
        }
        
        // store settings
        $this.data('modal', {
          settings:settings,
          rip:rip,
          bg:bg,
          style:$this.attr('style') || ''
        });
        
        // open
        if(settings.openNow === true) methods['open'].call($this);
      });
    },
    
    open:function(callback) {
      return this.each(function() {
        
        // vars
        var $this = $(this),
            data = $this.data('modal');
        
        // position and hide
        $this.css({
          'display':'none',
          'z-index':'49500'
        });
        
        // append bg and transition modal in
        data.bg.appendTo('body')
        .bind('click', function() {
          if(data.settings.background[3]) methods['close'].call($this);
        })
        .animate({'opacity':data.settings.background[2]}, 500, 'linear', function() {
          
          if(typeof data.settings.placement[0] === 'undefined') {
            
            // default placement
            $this.css({
              'position':'fixed',
              'top':'50%',
              'left':'50%',
              'margin-top':-Math.round($this.outerHeight() / 2) + 'px',
              'margin-left':-Math.round($this.outerWidth() / 2) + 'px'
            });
          } else {
            
            // custom placement
            $this.css({
              'top':data.settings.placement[0],
              'left':data.settings.placement[1],
              'margin-top':data.settings.placement[2],
              'margin-left':data.settings.placement[3],
              'position':data.settings.placement[4]
            });
          }
          
          $this.show();
          
          // callback
          if(typeof callback === 'function') callback.call($this);
          if(typeof data.settings.onOpened === 'function') data.settings.onOpened.call($this);
        });
      });
    },
    
    close:function(callback) {
      return this.each(function() {
        
        // vars
        var $this = $(this),
            data = $this.data('modal');
        
        // remove styles added by modal
        $this.hide();
        $this.attr('style', data.style);
        
        // transition out, clean up
        data.bg.animate({'opacity':'0'}, 500, 'linear', function() {
          data.bg.unbind('click').remove();
          
          if(typeof callback === 'function') callback.call($this);
          if(typeof data.settings.onClosed === 'function') data.settings.onClosed.call($this);
          
          if(data.settings.destroyOnClose === true) methods['destroy'].call($this);
        });
      });
    },
    
    destroy:function() {
      return this.each(function() {
        
        // vars
        var $this = $(this),
            data = $this.data('modal'),
            rip = data.rip;

        if(rip) $this.remove();
      });
    }
  }
  
  // extend
  $.fn.modal = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error( 'Method ' +  method + ' does not exist on jquery.legwork-modal' );
    }
  }
  
  // settings
  $.fn.modal.defaults = {
    background:['#000', 'none', 1, true],
    clone: false,
    placement:[],
    openNow:false,
    destroyOnClose:true,
    onOpened:null,
    onClosed:null
  }
})(jQuery);