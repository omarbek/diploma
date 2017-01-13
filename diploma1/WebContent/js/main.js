$(document).ready(function(){
    $(".train1").click(function(){
        
    	$("input[name='variant']").val($(this).html());
        var correct = $(this).attr("correct");
        if(correct == 1){
        	$(this).attr("class", "btn btn-success btn-block train1");
        	$("#trainingOneForm").submit();	
        }
        else{
        	$(this).attr("class", "btn btn-danger btn-block train1");
        	$("#trainingOneForm").submit();	
        }
        
    });
    $("#logout").click(function(){
    	$("#logoutForm").submit();	
    });
});