<%@page import="java.util.ArrayList"%>
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
<%
	// JAVA CODE STARTS HERE
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
	
	//Array of best Chromosomes among all generations
	ArrayList <Chromosome> bestChroms = new ArrayList<Chromosome>();
	
	while ((i++ <= maxGenerations) && (best.getFitness() != 0)) {
		System.out.println("Generation " + i + ": " + best.getGene());
		bestChroms.add(best);
		pop.evolve();
		best = pop.getPopulation()[0];
	}
	
	// Get the end time for the simulation.
	long endTime = System.currentTimeMillis();
	
	// Print out some information to the console.
	System.out.println("Generation " + i + ": " + best.getGene());
	bestChroms.add(best);
	System.out.println("Total execution time: " + (endTime - startTime) + "ms");
	
	//JAVACODE ENDS HERE
	%>
<script> 

function isNumeric(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}
function validateForm() {
	var containsValidChar = $("#targetGene").val().match(/^[+\A,T,C,G(). ]+$/g) !== null ? true : false;
	if(!containsValidChar){
		alert('Target should only contain the following Characters: A, T, C and G!');
		return false
	}
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
					<%
					//JAVA CODE HERE FOR LOOPING GENERATIONS
					for(int x = 0; x<bestChroms.size(); x++){
					%>
					
						<tr>
							<td class="rowgennumber
							
							<%if(x==(bestChroms.size()-1)){ %> //Added code to style the last row
							 bestrow
							<%}%>
							">

							<%=(x+1)%>
							</td>
							<td class="rowgene
							
							<%if(x==(bestChroms.size()-1)){ %> //Added code to style the last row
							 bestrow
							<%}%>
							">
							
							<%=bestChroms.get(x).getGene()%></td>
							<td class="rowfitness
							
							<%if(x==(bestChroms.size()-1)){ %> //Added code to style the last row
							 bestrow
							<%}%>
							">
							
							<%=bestChroms.get(x).getFitness()%></td>
						</tr>
						
					<%
					}
					%>
					</tbody>
				</table>
<!-- 				<ul id="generationlist"> -->
<!-- 				</ul> -->
			</div>
		</div>
		<div id="inputDiv">
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