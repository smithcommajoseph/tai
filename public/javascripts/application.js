var Tai = Tai || {};


(function($){
	var self = this;
	
	self.Actions = (function(){
		var pub = {},
			$wn,
			$wrap,
			$doIt,
			$launcherScrolls,
			$infoScrolls,
			$launcher;
		
		pub.init = function(){
			$wn = $(window);
			$wrap = $('#wrap');
			$doIt = $('#do-it');
			$launcherScrolls = $('a[href=#do-it]');
			$infoScrolls = $('a[href=#infos]');
			$launcher = $('#launcher');
						
			_positionTop();
			
			_binds();
		};
		
		function _binds(){
			$wn.bind('resize.tai', function(e){
				_positionTop();
			});
			
			$launcherScrolls.bind('click.tai', function(e){
				e.preventDefault();
				$.scrollTo(0, 800);
			});
			
			$infoScrolls.bind('click.tai', function(e){
				e.preventDefault();
				$.scrollTo($('#infos').position().top, 800);
			});
			
		}
		
		function _positionTop(){
			var top = ((($wn.height() + $doIt.outerHeight() ) / 4) - 50) + 'px';
			
			$wrap.css({'top': top});
			$doIt.css({'margin-bottom': top});
		}
		
		return pub;
	})();
	
	self.Construct = (function(){
		$(document).ready(function(){ Tai.Actions.init(); });
	})();
	
}).call(Tai, jQuery);