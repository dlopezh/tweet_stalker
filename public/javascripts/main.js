var map = new Datamap({
        element: document.getElementById('map'),
        scope: 'usa',
        geographyConfig: {
            highlightOnHover: false,
            popupOnHover: false,
            borderWidth: 0.8,
            borderColor: '#565656',
        },

        fills: {
            	defaultFill: '#151515'
            }
    });

    var json_data = d3.json("/tweets", function(error, json) {
                if (error) return console.warn(error);
                json_data = json
     });

     function drawTweets(){
    d3.json("/tweets", function(error, json) {
        if (error) return console.warn(error);
                data = json

                console.log(data.length)

                map.svg.selectAll("circle")
                .data(data)
                .enter()
                .append("circle")
                .attr("r",5)
                .attr("fill", "#30FF30")
                .on("mouseover",function(d){
                    d3.select(this).attr("r", 3);
                    $('#tweet-text').text(d.content);
                })
                .on("click",function(d){
                    d3.select(this)
                    window.open('http://maps.google.com/maps?q='+ d.longitude + ',' + d.latitude, '_blank');    
                })
                .on("mouseout", function(d){
                    d3.select(this).attr("fill", "yellow");
                })
                .transition()
                .duration(1000)
                .attr("r",1.5)
                .attr("fill", "steelblue")
                .attr("cx", function(d) {
                    return map.projection([d.latitude, d.longitude])[0];
                })
                .attr("cy", function(d) {
                    return map.projection([d.latitude, d.longitude])[1];
                })
    });

};


$(function() {
    setTimeout(function fetch(){
        drawTweets();
        setTimeout(fetch,5000);
    },0)
});