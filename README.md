# Java_Evolutionary_Genetics_Simulation

Genetics Simulation Project

# Project Overview:
## How to use: 
        - Input fields (right half)
                Target Gene: The gene being selective for (genetic end goal of selection)
                        Should consist of A,T,C and G’s (DNA base pairs) 
                Tournament Size: Degree of selective pressure, randomly sampled chromosomes to compete to see which is closest to target gene (the larger the tournament size, the faster genes will likely fix towards the target gene due to less drift)
                        Positive Integer less than 1000
                Population Size: Number of individuals of the given species 
                        Positive decimal between 0 and 1
                        Warning if population > 1000000, error if population > 100000000
                Crossover Ratio: Degree at which genetic information is mixed up between two parents when passed off to the child.  
                        Positive decimal between 0 and 1  
                Elitism Ratio: Degree at which the genetic information is unchanged  
                        Positive decimal between 0 and 1  
                Mutation Ratio: Degree at which genetic information is changed within the lifetime of an individual in the species 
                        Positive decimal between 0 and 1  
                        
## Results:
        - Generation #: Number of generations it takes before a sequence within the genome reaches the target gene
        - Gene Code: Gene code of closest chunk per generation
        - Fitness: Measure of how close the gene code displayed is to the target gene


## How to make it run on your computer: 
1.    Generation of the .war file (This step already done for you, GeneticsSimulation.war should already be in the zip folder). But in case you’re curious how to use eclipse to generate the .war file, refer to a-g below. 
    a.    Make sure that your project is imported successfully in Eclipse
    b.    Right click on the Dynamic Web Project
    c.    Click Export
    d.    Select “WAR File”
    e.    Click Next
    f.    Browse wanted Destination
    g.    Click Finish
2.    Setup Apache Tomcat 9 on your computer – there are great instructional videos online :)
    a.    Make sure tomcat server is stopped.
3.    Copy the war file to the <TOMCAT_HOME>/webapps folder
4.    Enter the <TOMCAT_HOME>/bin folder and Execute “./catalina.sh start” to run the server
5.    Test the application http://localhost:8080/GeneticsSimulation/
    a.    FYI port 8080 is the default port of Tomcat servers
6.    To stop the server again, execute “./catalina.sh stop” in the <TOMCAT_HOME>/bin folder

## Code Explanation: 
    Technology used:
        Java (most came from GAHelloWorld)
        JSP – Java Servlet Pages. This is for the main program. It is the one who invokes the methods from the GAHelloWorld. 
            JSP files are basically a combination of HTML File and a Java File. All HTML accepted languages are also useable in JSP Files. Namely, Javascript, CSS etc.
        Javascript/JQuery – used in front end (codes embedded on the screen/user interface) for form validations, animations, things that involves more on your forms (User interface side.)
        CSS – used in styling the web application
        Tomcat Server – used to run the web application
        Eclipse – used IDE to develop the web application

## Project Roadmap – we used the standard web based project structure. Containing the build folder for the built java sources, src for the folder of java files and WebContent folder for the HTML, img, css files to be deployed in the web server.FYI class files are the file extension of a built java object.

All of the folders above are automatically generated if you try to create a new Dynamic Web Application in Eclipse.
The following folders are that I created because they weren’t automatically generated. 
    Backup folder in WebContent. I created this folder for the historical files.
    css folder – to organize css files
    img folder – to hold images
    js files – to hold Javascript files
    For the web.xml in WEB-INF, I have automatically generated it for the ease of use of our link. Without it, we will still be using this link: localhost:8080/GeneticsSimulation/index.jsp instead of localhost:8080/GeneticsSimulation/. You can consider web.xml file as a general configuration file for Java web applications. In order to automatically generate it, you can follow these steps:
    Right click your Dynamic web project in eclipse ->
    Java EE Tools ->
    Generate Deployment Descriptor Stub
    Then it will be placed automatically in WEB-INF folder
The Chromosome and Population java files are within a lot of folders, because this is the way the programmer of “GAHelloWorld” wanted them to be. If you look at their source, on the top most part you will see where it should be located. This is a concept in Java called packages:
 

*So Chromosome java file should be within the auxesia folder, within net folder.




## Code Written/Changed
Index.jsp – this is the main file. Since this should be a small and simple program, I have used this jsp to serve as the View (User Interface) and Controller (The one that does the logic, processes etc.). They are usually separated but this makes things quicker. It consisted of regular HTML codes for the Front end (User interface, etc) and Java codes which reside within <% %> snippets to do processes computations and also to use the said Chromosome and Population Java files from GAHelloWorld. All the contents in this file is original.
Chromosome.java – this file came from GAHelloWorld but I have made some changes to cater to the needs of our application. Here are the following changes:
    Line 49: TARGET_GENE – it was initially Hello World but changed it to ATCGATGGCAAAGTACGATG. Also the object is final initially. I removed it so that we could also make it as an additional variable for our application
    Line 53: FIXED_LETTERS – I created a static Character array so that our application would only use the letters A, T, C & G for Gene codes.
    Line 115: mutate method – I changed it to only use the said FIXED_LETTERS array
    Line 166 generateRandome method – just like the mutate method, I just adjusted this method to cater the FIXED_LETTERS array
Population.java – this file came also from GAHelloWorld but I have made some changes too. Here are the changes
    Line 46: TOURNAMENT_SIZE – it was fixed so I decided to remove this and add tournamentSize attribute for the object Population. You will see that I also have added a parameter in the constructor (Line 70) to cater the new adjustable attribute.
    Bootstrap.css – bootstrap is one the most well-known, free frameworks to cater your styling needs. I got this file from http://getbootstrap.com/. This is basically an established style sheet blueprint that we can use.
    Style.css – I was the one who wrote this file. This files serves as a blueprint of the styles used in the application.
    Jquery-3.2.1.min.js – Jquery is a popular javascript tool to be used for your front-end problems. It is basically based off of Javascript which somehow rewrote the javascript methods for your convenience. It is usually used in form validations, animations and a lot more. It is basically an upgraded version of the Javascript. I got this from https://jquery.com/. It is also free.
    MANIFEST.MF – automatically generated – basically this holds few details of your project (versions etc.)
    Web.xml – I believe I have stated everything above for this file.
    .classpath – this is a file that lists all the internal/external references of a project. – automatically generated
    .project – this file serves as your id whenever you’ll try to import/export your project to different machines. With this file, you will able to let other eclipse software use/develop your project with ease.  

## Credits:
It is a Java Web Based project that used the Open Source Code – Genetic Algorithm Hello World (https://github.com/jsvazic/GAHelloWorld) 
For more GAHelloWorld details, open: https://github.com/jsvazic/GAHelloWorld/blob/master/README.md


















