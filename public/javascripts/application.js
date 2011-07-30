var Tai = Tai || {};


(function($){
	var self = this;
	
	self.Actions = (function(){
		var pub = {},
			$wn,
			$wrap,
			$doIt,
			$infos,
			$launcherScrolls,
			$infoScrolls,
			$launcher;
		
		pub.init = function(){
			$wn = $(window);
			$wrap = $('#wrap');
			$doIt = $('#do-it');
			$infos = $('#infos');
			$launcherScrolls = $('a[href=#do-it]');
			$infoScrolls = $('a[href=#infos]');
			$launcher = $('#launcher');
						
			_sizeDoIt();
			_footerLinkInfoOrHome();
			_binds();
		};
		
		function _binds(){
			$wn.bind({
				resize: function(e){
					_sizeDoIt();
				},
				scroll: function(e){
					_footerLinkInfoOrHome();
				}
			});
			
			$launcherScrolls.live('click', function(e){
				e.preventDefault();
				$.scrollTo(0, 800);
			});
			
			$infoScrolls.live('click', function(e){
				e.preventDefault();
				$.scrollTo($('#infos').position().top, 800);
			});
						
		}
		
		function _sizeDoIt(){
			var top = ($wn.height() - ($('footer').height() + $('header').height())) + 'px';
			$doIt.css({height: top});
		}
		
		function _footerLinkInfoOrHome(){
			var homeL = "#do-it",
				infoL = "#infos",
				curScroll = $wn[0].scrollY,
				$target = $('footer a');
			
			if(curScroll >= $doIt.position().top + $doIt.height() ){
				$target.addClass('gohome').attr('href', homeL);
			} else {
				$target.removeClass('gohome').attr('href', infoL);
			}
		}
		
		
		return pub;
	})();
	
	self.Construct = (function(){
		$(document).ready(function(){ Tai.Actions.init(); });
	})();
	
}).call(Tai, jQuery);