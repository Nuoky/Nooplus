/* To avoid CSS expressions while still supporting IE 7 and IE 6, use this script */
/* The script tag referencing this file must be placed before the ending body tag. */

/* Use conditional comments in order to target IE 7 and older:
	<!--[if lt IE 8]><!-->
	<script src="ie7/ie7.js"></script>
	<!--<![endif]-->
*/

(function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'icomoon\'">' + entity + '</span>' + html;
	}
	var icons = {
		'icon-ctrl-right': '&#xea51;',
		'icon-user': '&#xe971;',
		'icon-users': '&#xe972;',
		'icon-quotes-left': '&#xe977;',
		'icon-wrench': '&#xe991;',
		'icon-shield': '&#xe9b4;',
		'icon-power': '&#xe9b5;',
		'icon-menu': '&#xe9bd;',
		'icon-cross': '&#xea0f;',
		'icon-checkmark': '&#xea10;',
		'icon-enter': '&#xea13;',
		'icon-exit': '&#xea14;',
		'icon-ctrl-down': '&#xea50;',
		'icon-steam': '&#xeaad;',
		'0': 0
		},
		els = document.getElementsByTagName('*'),
		i, c, el;
	for (i = 0; ; i += 1) {
		el = els[i];
		if(!el) {
			break;
		}
		c = el.className;
		c = c.match(/icon-[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
}());
