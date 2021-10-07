<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="net.auxesia.Chromosome" %>
<%@ page import="net.auxesia.Population" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GeneticsSimulation</title>
<!-- IMPORTS -->
<script src="js/jquery-3.2.1.min.js"></script>
<script> 
$(document).ready(function(){
var genes = [];
var fitness = [];
<%
	// Gene Target Gene
	String targetGene = request.getParameter("targetGene");
	if(targetGene == null || targetGene.equals("")){
		targetGene = "ATCGATGGCAAAGTACGATG";
		Chromosome.setTARGET_GENE(targetGene);
	}else{
		Chromosome.setTARGET_GENE(targetGene);
	}

	// The size of the tournament size
	int tournamentSize;
	String tournamentSizeStr = request.getParameter("tournamentSize");
	if(tournamentSizeStr == null || tournamentSizeStr.equals("")){
		tournamentSize = 3;
	}else{
		tournamentSize = Integer.parseInt(tournamentSizeStr);
	}
	
	// The size of the simulation population
	int populationSize;
	String populationSizeStr = request.getParameter("populationSize");
	if(populationSizeStr == null || populationSizeStr.equals("")){
		populationSize = 2048;
	}else{
		populationSize = Integer.parseInt(populationSizeStr);
	}
	
	// The maximum number of generations for the simulation.
	int maxGenerations;
	String maxGenerationsStr = request.getParameter("maxGenerations");
	if(maxGenerationsStr == null || maxGenerationsStr.equals("")){
		maxGenerations = 16384;
	}else{
		maxGenerations = Integer.parseInt(maxGenerationsStr);
	}
	
	// The probability of crossover for any member of the population,
	// where 0.0 <= crossoverRatio <= 1.0
	float crossoverRatio;
	String crossoverRatioStr = request.getParameter("crossoverRatio");
	if(crossoverRatioStr == null || crossoverRatioStr.equals("")){
		crossoverRatio = 0.8f;
	}else{
		crossoverRatio = Float.parseFloat(crossoverRatioStr);
	}
	
	// The portion of the population that will be retained without change
	// between evolutions, where 0.0 <= elitismRatio < 1.0
	float elitismRatio;
	String elitismRatioStr = request.getParameter("elitismRatio");
	if(elitismRatioStr == null || elitismRatioStr.equals("")){
		elitismRatio = 0.1f;
	}else{
		elitismRatio = Float.parseFloat(elitismRatioStr);
	}
	
	// The probability of mutation for any member of the population,
	// where 0.0 <= mutationRatio <= 1.0
	final float mutationRatio;
	String mutationRatioStr = request.getParameter("mutationRatio");
	if(mutationRatioStr == null || mutationRatioStr.equals("")){
		mutationRatio = 0.03f;
	}else{
		mutationRatio = Float.parseFloat(mutationRatioStr);
	}
	
	// Get the current run time.  Not very accurate, but useful for 
	// some simple reporting.
	long startTime = System.currentTimeMillis();
	
	// Create the initial population
	Population pop = new Population(populationSize, crossoverRatio, 
			elitismRatio, mutationRatio, tournamentSize);
			
			
	//Start evolving the population, stopping when the maximum number of
	// generations is reached, or when we find a solution.
	int i = 0;
	Chromosome best = pop.getPopulation()[0];
	
	while ((i++ <= maxGenerations) && (best.getFitness() != 0)) {
		%>genes.push('<%=best.getGene()%>');<%
		System.out.println("Generation " + i + ": " + best.getGene());
		%>fitness.push('<%=best.getFitness()%>');<%
		pop.evolve();
		best = pop.getPopulation()[0];
	}
	
	// Get the end time for the simulation.
	long endTime = System.currentTimeMillis();
	
	// Print out some information to the console.
	%>genes.push('<%=best.getGene()%>');<%
	System.out.println("Generation " + i + ": " + best.getGene());
	%>fitness.push('<%=best.getFitness()%>');<%
	System.out.println("Total execution time: " + (endTime - startTime) + "ms");
	%>

	var index = 0;
	var indexP1 = 0;
   	var geneIndex = 0;
	var thread = null;
   	var newGene = true;
   	var evolutionLevel = 0;
   	var endLength = genes[genes.length-1].length;
   	var bestGene = genes[genes.length-1];
   	var geneScore = 0;
   	var speed = 250;
   	var isPaused = false;
	var animationDivWidth  = $("#animationDiv").width()-100;
	var widthPerMove = animationDivWidth/endLength;
	var simulationNotOver = true;
	var changedSpeed = 0;
   	speedText(speed);
    $("#startbtn").click(function(){
    	$( "#startbtn" ).prop( "disabled", true );
    	$( "#pausebtn" ).prop( "disabled", false );
    	$( "#stopbtn" ).prop( "disabled", false );
    	isPaused = false;
    	resetAll();
    	startSimulation();
    });
    function startSimulation(){
    		if(isPaused == false){
		    	if(newGene){
		    		reset();
		    		$("#person").show();
					indexP1++;
	// 		        $("#generationlist").prepend('<li><span class="generation">Generation '+indexP1+': '+genes[index]+'</span></li>');
			        $("#generationlist tbody").prepend('<tr><td class="rowgennumber">'+indexP1+'</td><td class="rowgene"><span class="generation">'+genes[index]+'</span></td><td class="rowfitness">'+fitness[index]+'</td></tr>');
					newGene = false;
					geneScore = getScore(genes[index]);
					var geneScoreRatio = geneScore/bestGene.length;
			        $("#person").removeClass("rotated");
			        
			        if(geneScoreRatio>.83){
		                $("#person").attr('src','img/6.png');
			        }else if(geneScoreRatio>.66){
		                $("#person").attr('src','img/5.png');
			        }else if(geneScoreRatio>.5){
		                $("#person").attr('src','img/4.png');
			        }else if(geneScoreRatio>.33){
		                $("#person").attr('src','img/3.png');
			        }else if(geneScoreRatio>.16){
		                $("#person").attr('src','img/2.png');
			        }
		    	}
	//     		if(ifStillGoodGene(geneIndex, genes[index].charAt(geneIndex))){
	    		if(geneScore>geneIndex){
					//Still surviving
			        geneIndex++;
					var width = geneIndex*widthPerMove;
			        $("#person").animate({left: width},changedSpeed);
			        if(geneIndex == endLength){
			        	//Champion Gene
				        clearInterval(thread);
				        $("#wasted").attr('src','img/champion.png').fadeIn(1000);
				        $("#generationlist tbody tr:first").addClass('bestrow');
				        simulationNotOver = false;
			        }
	    		}else{
	    			//Dead
			        index++;
	    			newGene = true;
			    	geneIndex = 0;
			    	$("#wasted").show().delay(changedSpeed).fadeOut();
			    	$( "#person" ).clearQueue();
			    	$( "#person" ).stop();
			    	$("#person").addClass("rotated");
	    		}
			}
	    	if(simulationNotOver){
	    		changedSpeed = speed;
	    		setTimeout(startSimulation, changedSpeed);
	    	}
  		}
    $("#pausebtn").click(function(){
    	
		var pauseStatuts = $("#pausebtn").text();
		if(pauseStatuts == "PAUSE"){
	    	isPaused = true;
	    	$( "#startbtn" ).prop( "disabled", true );
	    	$( "#stopbtn" ).prop( "disabled", true );
	    	$("#pausebtn").text('CONTINUE');
    	$( "#person" ).clearQueue();
    	$( "#person" ).stop();
		}else{
	    	isPaused = false;
	    	$( "#startbtn" ).prop( "disabled", true);
	    	$( "#stopbtn" ).prop( "disabled", false);
	    	$("#pausebtn").text('PAUSE');
		}
		
    	
    });
    $("#stopbtn").click(function(){
//     	clearInterval(thread);
	    	isPaused = true;
    	speed = 250;
    	speedText(speed);
    	$( "#person" ).clearQueue();
    	$( "#person" ).stop();
    	$( "#startbtn" ).prop( "disabled", false );
    	$( "#pausebtn" ).prop( "disabled", true );
    	$( "#stopbtn" ).prop( "disabled", true );
    	$("#generationlist tbody").empty();	
    });
    $("#fasterbtn").click(function(){
		
    	var tempspeed = speed/2;
    	if(tempspeed>15){
	    	speed=tempspeed;
    	}
    	speedText(speed);
    });
    $("#slowerbtn").click(function(){
    	
    	var tempspeed =speed*2;
    	if(tempspeed<=4000){
	    	speed=tempspeed;
    	}
    	speedText(speed);
    });

    function reset(){
    	$("#person").css({top: 0, left: 0, position:'relative'});
    }
    function resetAll(){
    	reset();
        index = 0;
    	indexP1 = 0;
		newGene = true;
    	geneIndex = 0;
    	$("#person").attr('src','img/1.png');
    	$("#wasted").attr('src','img/wasted.png');
    	simulationNotOver = true;
    }
    function ifStillGoodGene(index, gene){
    	if(index%2==0){
    		//Should be letter A
    		if(gene == 'A'){
    			return true;
    		}else{
    			return false;
    		}
    	}else{
    		//Should be letter B
    		if(gene == 'B'){
    			return true;
    		}else{
    			return false;
    		}
    	}
    }
    function getScore(gene){
		var score = 0;    	
    	for(x = 0; x < bestGene.length; x++){
    		if(bestGene.charAt(x)==gene.charAt(x)){
    			score++;
    		}
    	}
    	return score;
    }
    function speedText(speed){
    	if(speed == "4000"){
	    	$("#speed").text('SPEED: .0625x');
    	}else if(speed == "2000"){
	    	$("#speed").text('SPEED: .125x');
    	}else if(speed == "1000"){
	    	$("#speed").text('SPEED: .25x');
    	}else if(speed == "500"){
	    	$("#speed").text('SPEED: .5x');
    	}else if(speed == "250"){
	    	$("#speed").text('SPEED: 1x');
    	}else if(speed == "125"){
	    	$("#speed").text('SPEED: 2x');
    	}else if(speed == "62.5"){
	    	$("#speed").text('SPEED: 4x');
    	}else if(speed == "31.25"){
	    	$("#speed").text('SPEED: 8x');
    	}else if(speed == "15.625"){
	    	$("#speed").text('SPEED: 16x');
    	}
    }
});
function isNumeric(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}
function validateForm() {
	if(!isNumeric($("#tournamentSize").val())){
		alert('Tournament Size should be numeric!');
		return false
	}
	if(!isNumeric($("#populationSize").val())){
		alert('Population Size should be numeric!');
		return false
	}
	if(!isNumeric($("#crossoverRatio").val())){
		alert('Crossover Ratio should be numeric!');
		return false
	}
	if(!isNumeric($("#elitismRatio").val())){
		alert('Elitism Ratio should be numeric!');
		return false
	}
	if(!isNumeric($("#mutationRatio").val())){
		alert('Mutation Ratio should be numeric!');
		return false
	}
	if($("#tournamentSize").val()<0){
		alert('Tournament Size should not be negative!');
		return false
	}
	if($("#populationSize").val()<0){
		alert('Population Size should not be negative!');
		return false
	}
	if($("#crossoverRatio").val()<0){
		alert('Crossover Ratio should not be negative!');
		return false
	}
	if($("#elitismRatio").val()<0){
		alert('Elitism Ratio should not be negative!');
		return false
	}
	if($("#mutationRatio").val()<0){
		alert('Mutation Ratio should not be negative!');
		return false
	}
	if($("#populationSize").val()>100000000){
		alert('Please provide a lower value for Population Size.');
		return false;
	}
	if($("#populationSize").val()>1000000){
		alert('It is not advised to put a more than 1 million value for Population Size.');
	}
	if($("#tournamentSize").val()>1000){
		alert('Tournament Size should not be greater than 1000.');
		return false;
	}
	if($("#crossoverRatio").val()>1){
		alert('Crossover Ratio should be within the range of 0.0 to 1.0 only.');
		return false;
	}
	if($("#elitismRatio").val()>1){
		alert('Elitism Ratio should be within the range of 0.0 to 1.0 only.');
		return false;
	}
	if($("#mutationRatio").val()>1){
		alert('Mutation Ratio should be within the range of 0.0 to 1.0 only.');
		return false;
	}


}

</script> 
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">

</head>
<body>
<div id="mainDiv">
	<div id="animationDiv">
		<img id="person" src="img/1.png"></img>
		<img id="wasted" src="img/wasted.png"></img>
	</div>
	<div id="controlDiv">
		<div id="titleDiv">
			<a href="/GeneticsSimulation">
				<img  id="title" src="img/title.png"></img>
			</a>
		</div>
		<div id="listDiv">
			<div>
				<table id="generationlist" class="table table-hover">
					<thead>
						<tr>
							<th class="rowgennumber">GENERATION #</th>
							<th class="rowgene">GENE CODE</th>
							<th class="rowfitness">FITNESS</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
<!-- 				<ul id="generationlist"> -->
<!-- 				</ul> -->
			</div>
		</div>
		<div id="inputDiv">
			<button id="startbtn" class="btn btn-default">START</button>
			<button id="pausebtn" class="btn btn-default" disabled>PAUSE</button>
			<button id="stopbtn" class="btn btn-default" disabled>STOP</button>
			<button id="slowerbtn" class="btn btn-default">SLOWER</button>
			<p id="speed"></p>
			<button id="fasterbtn" class="btn btn-default">FASTER</button>
			
			<form action="/GeneticsSimulation/" method="get" onsubmit="return validateForm()">
				<div class="form-group">
					<label>Target Gene</label>
			    	<input type="text" class="form-control" placeholder="Target Gene" id="targetGene" name="targetGene" value="<%=targetGene%>">
			  	</div>
				<div class="form-group">
					<label>Tournament Size</label>
			    	<input type="text" class="form-control" placeholder="Tournament Size" id="tournamentSize" name="tournamentSize" value="<%=tournamentSize%>">
			  	</div>
				<div class="form-group">
					<label>Population Size</label>
			    	<input type="text" class="form-control" placeholder="Population Size" id="populationSize" name="populationSize"  value="<%=populationSize%>">
			  	</div>
				<div class="form-group">
					<label>Crossover Ratio</label>
			    	<input type="text" class="form-control" placeholder="Crossover Ratio" id="crossoverRatio" name="crossoverRatio" value="<%=crossoverRatio%>">
			  	</div>
				<div class="form-group">
					<label>Elitism Ratio</label>
			    	<input type="text" class="form-control" placeholder="Elitism Ratio" id="elitismRatio" name="elitismRatio" value="<%=elitismRatio%>">
			  	</div>
				<div class="form-group">
					<label>Mutation Ratio</label>
			    	<input type="text" class="form-control" placeholder="Mutation Ratio" id="mutationRatio" name="mutationRatio" value="<%=mutationRatio%>">
			  	</div>
			  <button type="submit" class="btn btn-default">Submit</button>
			</form>
			
		</div>
		
	</div>
</div>
</body>
</html>