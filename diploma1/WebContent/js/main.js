$(document).ready(function(){
    $(".train1").click(function(){
        
    	$("input[name='variant']").val($(this).html());
        var correct = $(this).attr("correct");
        if(correct == 1){
        	$(this).attr("class", "btn btn-correct");
        	$("#trainingOneForm").submit();	
        }
        else{
        	$(this).attr("class", "btn btn-incorrect");
        	$("#trainingOneForm").submit();	
        }
        
    });
    $("#logout").click(function(){
    	$("#logoutForm").submit();	
    });
});