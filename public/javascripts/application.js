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
			$launcher, 
			$networkChoices,
			popup,
			root;
		
		pub.init = function(){
			$wn = $(window);
			$wrap = $('#wrap');
			$doIt = $('#do-it');
			$infos = $('#infos');
			$launcherScrolls = $('a[href=#do-it]');
			$infoScrolls = $('a[href=#infos]');
			$launcher = $('#launcher');
			$networkChoices = $('#network-choices a');
			root = document.location.protocol+"//"+document.location.host;
					
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
			
			$networkChoices.bind('click', function(e){
				var loc,
					target = '_blank',
					attr = 'height=400,width=800,left=250,top=100,resizable=yes';
				
				e.preventDefault();
				
				if($(e.currentTarget).attr('id') === 'fb-link') { loc = root+'/account/new?network=fb'; } 
				else { loc = root+'/account/new?network=twitter'; }
				
				popup = window.open(loc, target, attr, true);
				
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