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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- JavaScript Bundle with Popper -->
    <style>
    	.jumbotron {
		    padding: 2rem 1rem;
		    margin-bottom: 2rem;
		    background-color: #e9ecef;
		    border-radius: .3rem;
		}
    </style>
</head>
<body>
 	<div class="container-fluid">
 		<!-- <nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color:#e3f2fd;">
		  <div class="container-fluid">
		    <a class="navbar-brand" href="#">Realtime App</a>
		    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		    </button>
		    <div class="collapse navbar-collapse" id="navbarText">
		      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
		        <li class="nav-item">
		          <a class="nav-link active" aria-current="page" href="#">Home</a>
		        </li>
		      </ul>
		      <span class="navbar-text">
		        REALTIME VIBRATION READINGS
		      </span>
		    </div>
		  </div>
		</nav> -->
 	</div>
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <p class="lead text-center text-primary font-weight-bold">REALTIME DATA</p>
                <input type="hidden" id="context" value="${pageContext.request.contextPath}" />
            </div>
        </div>
        <div class="row">
            <!-- <div class="col-sm-4"></div> -->
            <div class="col-sm-12 ">
                <div class="mt-3">
                	<div id="chart"></div>
                </div>
            </div>
        </div>
    </div>

    <script>

        var trigoStrength = 3;
        var iteration = 11;

        
        var optionsLine = {
            chart: {
                height: 450,
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
                    text: 'Hertz'
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
    </script>
</body>
</html>