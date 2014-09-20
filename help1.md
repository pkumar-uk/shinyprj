**"Life Expectancy across Globe - Visual Representation"** is an application that makes it easy to understand Life expectancy data using visualization.

The application uses R packages to achieve this. The list of Packages is given below:-    

* Shiny - for publishing the application    
* GoogleVis - for creating the interactive plots   
* plyr - for data subsetting  

The data used by application comes from WHO for Life Expectancy across the world; which is measured under three categories:-   

* Life expectancy at birth   
* Healthy life expectancy at birth   
* Life expectancy at age 60   

The application allows to filter data for visualization on the following categories using the navigation panel on the left:-    

- *Type of life expectancy* - one can select a type that is measured by WHO    
- *Life Expectancy greater than* - gives a slider to filter data on life expectancy years. Life expectancy greater than the selection is only shown in charts. Default is '0'      
- *Select Years for which the data should be shown* : WHO has data for 3 years - 1990, 2000, 2012 (Note Trend Tab ignores this data)     
- *Select population type* - WHO categorizes this into Male, Female and for both. selection can be done to select one      
- *Select type of countries to be shown* - WHO categorizes countries into 4 income group - High Income Group, Upper Middle Income Group, Lower Middle Income Group, Lower Income Group      

The application allows two types of visualization that is shown on tabs-

- **Geo**
- **Trend**

**Geo** shows Life Expectancy on GeoMap using GoogleVis kit. In addition to the GeoMap the data that is used to show the map is shown as tables below. Also, a table is shown that summarises data on Regions. The following type of analysis can be done:-

- Map colour of countries are based on Life expectancy. Moving the Mouse over the country will give name of the country along with life expectancy in year.     
- Tables columns can be clicked to sort on a column    
- Navigation Panel can be used to filter data    

**Trend** shows the data as a trend across 1990,2000, 2012. It ignores the selection of Years in navigation panel, but filters are valid. The chart provides additional selection of filters to lock countries for analysis and trending. 

**FAQ:**     

*No Chart shown?*          
It is possible that some combination of filters produces no data and may result in no chart being shown. Change filters to view the chart.
  
*Data used*           
The application uses WHO data on Life Expectancy. The data set used for display can be obtained from http://apps.who.int/gho/data/node.main.688?lang=en

