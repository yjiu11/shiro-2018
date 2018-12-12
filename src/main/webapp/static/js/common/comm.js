(function(){
	$.extend({
		getAppPath:function(){
			//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp  
		    var curWwwPath=window.document.location.href;  
		    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp  
		    var pathName=window.document.location.pathname;  
		    var pos=curWwwPath.indexOf(pathName);  
		    //获取主机地址，如： http://localhost:8083  
		    var localhostPaht=curWwwPath.substring(0,pos);  
		    //获取带"/"的项目名，如：/uimcardprj  
		    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);  
		    return(localhostPaht+projectName);  
		}
	})
	$.moban = function(str,options) {
		var setting = $.extend({
			
		},options||{})
	};
	/**清空表单样式及内容*/
	$.reset_form = function(ele) {
		$(ele)[0].reset();
		//清空表单样式
		$(ele).find("*").removeClass("has-error has-success");
		$(ele).find(".help-block").text("");
	};
	
})(jQuery);
