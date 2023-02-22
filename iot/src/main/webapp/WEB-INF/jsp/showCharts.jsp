<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SensorDashBoard</title>
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- JavaScript Bundle with Popper -->
<style>
.jumbotron {
	padding: 2rem 1rem;
	margin-bottom: 2rem;
	background-color: #e9ecef;
	border-radius: .3rem;
}

.heading {
	letter-spacing: 1rem;
}
@media screen and (min-width: 1024px) {
  .card {
  width:100%;
   
  }
}
 
/* For Tablet View */
@media screen and (min-width: 500px)
and (max-width: 1224px) {
  .card {
    width:100px !important;
    height: 300px !important;
   
  }
}

@media screen and (min-width: 100px)
and (max-width: 569px) {
  .card {
    width:100% !important;
    height: 400px !important;
    margin-top:5px;
   
  }
 

</style>
</head>
<body>

	<div
		class="bg-dark text-white text-center shadow-lg p-3 mb-2  text-uppercase font-weight-bold heading">RealTime
	 Data</div>

	<div class="container">

		<div class="row">
			<div class="col-sm-6">
				<input type="hidden" id="context"
					value="${pageContext.request.contextPath}" />
				<div class="mt-3">
					<div id="chart"></div>
				</div>
			</div>

            
			<div class="col-sm-3  pt-4 text-center align-items-center">
				<input type="hidden" id="context"
					value="${pageContext.request.contextPath}" />
				<div class="mt-5">
					<div id="">
						<div class="card bg-light shadow-lg border-0" style="width: 16rem;">
						<div class="card-header text-center bg-dark text-white">Temperature Monitor</div>
							<img class="card-img-top" src="/resources/img/imgtemp.jpg" alt="Card image cap" width="200px"
							height="250px">
							<div class="card-body">
								<p class="card-text text-center">
								<label class="fs-5"><b><span class="temp"></span><span> &#8451;</span></b></label>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3  text-center pt-4 align-items-center">
				<input type="hidden" id="context"
					value="${pageContext.request.contextPath}" />
				<div class="mt-5">
					<div id="">
						<div class="card bg-light shadow-lg border-0" style="width: 16rem;">
						<div class="card-header text-center bg-dark text-white">Humidity Monitor</div>
						
							<img class="card-img-top" src="/resources/img/humid.jpg" alt="Card image cap" width="200px"
							height="250px">
							<div class="card-body">
								<p class="card-text text-center">
								<label class="fs-5"><b><span class="humid"></span><span>%</span></b></label>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/fusioncharts/3.19.0/fusioncharts.js"
		integrity="sha512-Psnt3WGPeWOcJ05FAg3p8CLz6zF4Ya2otG1o33T0wJLqPNwu1SAUPFQybuKku+VnMJiknKdSohc0To4vwJ9WXA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>

        var trigoStrength = 3;
        var iteration = 11;

        
        var optionsLine = {
            chart: {
                height: 400,
                type: "line",
                stacked: false,
                animations: {
                    enabled: true,
                    easing: "linear",
                    dynamicAnimation: {
                        speed: 1000
                    }
                },
                dropShadow: {
                    enabled: true,
                    opacity: 0.3,
                    blur: 5,
                    left: -7,
                    top: 22
                },
                events: {
                    animationEnd: function (chartCtx) { 
                        const newData1 = chartCtx.w.config.series[0].data.slice();
                        newData1.shift();
                        window.setTimeout(function () {
	                        chartCtx.updateOptions(
	                            {
	                                series: [
	                                    {
	                                    	data: newData1
	                                    }
	                                ],
	                                subtitle: {
	                                    text: "20"//parseInt(getRandom() * Math.random()).toString()
	                                }
	                            },
	                            false,
	                            false
	                        );
                        }, 300);
                    }
                },
                toolbar: {
                    show: false
                },
                zoom: {
                    enabled: false
                }
            },
            dataLabels: {
                enabled: true
            },
            stroke: {
                curve: "straight",
                width: 5
            },
            markers: {
                size: 3,
                hover: {
                	size: 3
                }
            },
            series: [],
            xaxis: {
            	labels: {
            		formatter: function (val) {
                        return moment(new Date(val)).format("h:mm:ss");
                    },
            		show: true,
                    rotate: -45,
                    hideOverlappingLabels: true,
                  }, 
                  title: {
                      text: 'Time'
                  },
                type: "text"
            },
            yaxis: {
            	title: {
                    text: 'Viberation'
                },
                type: "numeric"
            },
            title: {
                    text: "",
                    align: "center",
                    style: {
	                    fontSize: "12px"
	                }
            },
            /* subtitle: {
                    text: "20",
                    floating: true,
                    align: "right",
                    offsetY: 0,
                    style: {
                        fontSize: "22px"
                	}
            }, */
            legend: {
                show: true,
                floating: true,
                horizontalAlign: "left",
                onItemClick: {
                    toggleDataSeries: false
                },
                position: "top",
                offsetY: -33,
                offsetX: 60
            }
        };

        var chartLine = new ApexCharts(document.querySelector("#chart"),optionsLine);
        chartLine.render();
        
		var context = $('#context').val();
		
        window.setInterval(function () {
            iteration++;
          	  var created = [];
          	  var masurements = [];
          	  var d = [];
            $.ajax({
            	  url: context+"/viberationdata",
            	  success: function( data ) { 
		                	  for(i=0;i<data.length;i++) {
		                		  created[i] = data[i].created_date;
		                		  masurements[i] = data[i].measurement;
		                		  d[i] = {
		                				  "x": data[i].created_date,
		                		  		  "y": data[i].measurement
		                		  }
                	  		  }
		                	  console.log(created);
		                	  console.log(masurements);
		                	  console.log(d);
		                	  chartLine.updateSeries([{
		                		    name: 'Vibrations',
		                		    data: d
		                	   }]);
            	  }
            	});            
           
        }, 3*1000);
        
 /////////////////////////////////////////////////////////////////////////////////////////////////
  
function update(){
	var tempVal=0;
 $.ajax({
	 
	  url: context+"/viberationdata",
	  success: function( data ) {
		  console.log("Data....",data);
		  //tempVal= data.length-1;
		   tempVal = data[0].temperature;
		  console.log("....temp",tempVal);

		  $(".temp").text(tempVal);
		  
           	  
	  }
 });
 
 }
    setInterval(function(){
        update()
    }, 1000)
           		  	
 
  
           	
           	
 	 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
function update1(){
	var templ=0;
 $.ajax({
	 
	  url: context+"/viberationdata",
	  success: function( data ) {
		  console.log("Data....",data);
	    // templ= data.length-1;
 	   templ = data[0].humidity;
		  console.log("....humid",templ);

		  $(".humid").text(templ);
		  
           	  
	  }
 });
 
 }
    setInterval(function(){
        update1()
    }, 1000)

    </script>
</body>
</html>