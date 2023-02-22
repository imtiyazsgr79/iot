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
</style>
</head>
<body>

	<div
		class="bg-dark text-white text-center shadow-lg p-3 mb-2 text-uppercase font-weight-bold heading">RealTime
		Viberation Data</div>

	<div class="container">

		<div class="row">
			<div class="col-sm-6">
				<input type="hidden" id="context"
					value="${pageContext.request.contextPath}" />
				<div class="mt-3">
					<div id="chart"></div>
				</div>
			</div>


			<div class="col-sm-3 pt-5 align-items-center">
				<input type="hidden" id="context"
					value="${pageContext.request.contextPath}" />
				<div class="mt-5">
					<div id="chart1"></div>
				</div>
			</div>
			<div class="col-sm-3 pt-5 align-items-center">
				<input type="hidden" id="context"
					value="${pageContext.request.contextPath}" />
				<div class="mt-5">
					<div id="chart2"></div>
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
       		FusionCharts.ready(function(){
			var chartObj = new FusionCharts({
    type: 'thermometer',
    renderAt: 'chart1',
    width: '240',
    height: '310',
    dataFormat: 'json',
    dataSource: {
        "chart": {
            "caption": "Temperature Monitor",
            "subcaption": " ",
            "lowerLimit": "-10",
            "upperLimit": "0",

            "decimals": "1",
            "numberSuffix": "°C",
            "showhovereffect": "1",
            "thmFillColor": "#008ee4",
            "showGaugeBorder": "1",
            "gaugeBorderColor": "#008ee4",
            "gaugeBorderThickness": "2",
            "gaugeBorderAlpha": "30",
            "thmOriginX": "100",
            "chartBottomMargin": "20",
            "valueFontColor": "#000000",
            "theme": "fusion"
        },
        "value": "-1",
        //All annotations are grouped under this element
        "annotations": {
            "showbelow": "0",
            "groups": [{
                //Each group needs a unique ID
                "id": "indicator",
                "items": [
                    //Showing Annotation
                    {
                        "id": "background",
                        //Rectangle item
                        "type": "rectangle",
                        "alpha": "50",
                        "fillColor": "#AABBCC",
                        "x": "$gaugeEndX-40",
                        "tox": "$gaugeEndX",
                        "y": "$gaugeEndY+54",
                        "toy": "$gaugeEndY+72"
                    }
                ]
            }]

        },
    },
    "events": {
        "rendered": function(evt, arg) {
            evt.sender.dataUpdate = setInterval(function() {
            	/* 
                var value,
                    prevTemp = evt.sender.getData(),
                    mainTemp = (Math.random() * 10) * (-1),
                    diff = Math.abs(prevTemp - mainTemp);

                diff = diff > 1 ? (Math.random() * 1) : diff;
                if (mainTemp > prevTemp) {
                    value = prevTemp + diff;
                } else {
                    value = prevTemp - diff;
                }
                
 */
 var value=0;
 $.ajax({
	  url: context+"/viberationdata",
	  success: function( data ) {
		  console.log("DAtatat",data);
		  value = data[0].temperature;
		  
           	 /*  for(i=0;i<data.length;i++) {
           		  
           	  value = data[i].temperature;
           	  console.log("the....",value)
           		   */
           		  	 setTimeout(() => {
  console.log("Delayed for 1 second.");
  evt.sender.feedData("&value=" +value);
}, "1000")
           	
           		//  }
           	  /* console.log(created);
           	  console.log(masurements);
           	  console.log(d); */
           	
           	 
	  } 
	});
                
 
            }, 8000);
            evt.sender.updateAnnotation = function(evtObj, argObj) {
                var code,
                    chartObj = evtObj.sender,
                    val = chartObj.getData(),
                    annotations = chartObj.annotations;

                if (val >= -4.5) {
                    code = "#00FF00";
                } else if (val < -4.5 && val > -6) {
                    code = "#ff9900";
                } else {
                    code = "#ff0000";
                }
                annotations.update("background", {
                    "fillColor": code
                });
            };
        },
        'renderComplete': function(evt, arg) {
            evt.sender.updateAnnotation(evt, arg);
        },
        'realtimeUpdateComplete': function(evt, arg) {
            evt.sender.updateAnnotation(evt, arg);
        },
        'disposed': function(evt, arg) {
            clearInterval(evt.sender.dataUpdate);
        }
    }
}
);
			chartObj.render();
		});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
FusionCharts.ready(function(){
			var chartObj2 = new FusionCharts({
    type: 'thermometer',
    renderAt: 'chart2',
    width: '240',
    height: '310',
    dataFormat: 'json',
    dataSource: {
        "chart": {
        	
            "caption": "Humidity Monitor",
            "subcaption": " ",
            "lowerLimit": "-10",
            "upperLimit": "100",

            "decimals": "1",
            "numberSuffix": "%",
            "showhovereffect": "1",
            "thmFillColor": "#FD5733",
            "showGaugeBorder": "1",
            "gaugeBorderColor": "#008ee4",
            "gaugeBorderThickness": "2",
            "gaugeBorderAlpha": "30",
            "thmOriginX": "100",
            "chartBottomMargin": "20",
            "valueFontColor": "#000000",
            "theme": "fusion"
        },
        "value": "3",
        //All annotations are grouped under this element
        "annotations": {
            "showbelow": "0",
            "groups": [{
                //Each group needs a unique ID
                "id": "indicator",
                "items": [
                    //Showing Annotation
                    {
                        "id": "background",
                        //Rectangle item
                        "type": "rectangle",
                        "alpha": "50",
                        "fillColor": "#AABBCC",
                        "x": "$gaugeEndX-40",
                        "tox": "$gaugeEndX",
                        "y": "$gaugeEndY+54",
                        "toy": "$gaugeEndY+72"
                    }
                ]
            }]

        },
    },
    "events": {
        "rendered": function(evt, arg) {
            evt.sender.dataUpdate = setInterval(function() {
               
                  /*   prevTemp = evt.sender.getData(),
                    mainTemp = (Math.random() * 10) * (-1),
                    diff = Math.abs(prevTemp - mainTemp);

                diff = diff > 1 ? (Math.random() * 1) : diff;
                if (mainTemp > prevTemp) {
                    value = prevTemp + diff;
                } else {
                    value = prevTemp - diff;
                }
                 */
                 var valu=0;
                 $.ajax({
                	  url: context+"/viberationdata",
                	  success: function( data ) {
                		  console.log("DAtatat",data);
                		  valu = data[0].humidity;
                           	 /*  for(i=0;i<data.length;i++) {
                           		  
                           	  valu = data[i].humidity; */
                           	  console.log("the....",valu)
                           		  
                     setTimeout(() => {
                  console.log("Delayed for 1 second.");
                  evt.sender.feedData("&value=" +valu);
                }, "8000")
                           	
                           		//  }
                           	  /* console.log(created);
                           	  console.log(masurements);
                           	  console.log(d); */
                           	
                           	 
                	  } 
                	});

            }, 12000);
            evt.sender.updateAnnotation = function(evtObj, argObj) {
                var code,
                    chartObj = evtObj.sender,
                    val = chartObj.getData(),
                    annotations = chartObj.annotations;

                if (val >= -4.5) {
                    code = "#00FF00";
                } else if (val < -4.5 && val > -6) {
                    code = "#ff9900";
                } else {
                    code = "#ff0000";
                }
                annotations.update("background", {
                    "fillColor": code
                });
            };
        },
        'renderComplete': function(evt, arg) {
            evt.sender.updateAnnotation(evt, arg);
        },
        'realtimeUpdateComplete': function(evt, arg) {
            evt.sender.updateAnnotation(evt, arg);
        },
        'disposed': function(evt, arg) {
            clearInterval(evt.sender.dataUpdate);
        }
    }
}
);
			chartObj2.render();
		});

    </script>
</body>
</html>