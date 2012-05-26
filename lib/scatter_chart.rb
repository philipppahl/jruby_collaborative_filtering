class ScatterChart
    
  attr_accessor :data
  
  def initialize data
    @data = data
  end
  
  def html
    raise 'No data given to draw' unless @data
    <<-HTML
    <html>
      <head>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
          google.load("visualization", "1", {packages:["corechart"]});
          google.setOnLoadCallback(drawChart);
          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Feature 1', 'Feature 2'],
              #{@data.map{|k| "[#{k[0]}, #{k[1]}]"}.join(',')}
            ]);
    
            var options = {
              title: 'User Features',
              hAxis: {title: 'Feature 1', minValue: -2.9, maxValue: 2.9},
              vAxis: {title: 'Feature 2', minValue: -2.9, maxValue: 2.9},
              legend: 'none'
            };
    
            var chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));
            chart.draw(data, options);
          }
        </script>
      </head>
      <body>
        <div id="chart_div" style="width: 900px; height: 500px;"></div>
      </body>
    </html>
    HTML
  end
  
  def save filename
    puts "Save scatter chart to: #{filename}"
    File.open(filename, 'w'){|file|
      file.puts html
    }
  end
end
