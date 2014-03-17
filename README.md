#TweetStalker

- Tracks tweets with the word "home" and maps it to its exact location.

###HEROKU
[MTA SMS SERVICE](http://tweetstalker.herokuapp.com/)

###Description

Final project for General Assembly - Web Development Immersive Course.

Data is retrieved from the twitter stream API. Tweets that contain a geotag are stored in the db. Using d3 I map each tweets exact location. Users can hover each point, read the tweet and clicking it will take them to google maps.


###Requirements & Dependencies

- Ruby >= 2.0.0
- [TweetStream](https://github.com/tweetstream/tweetstream)
  - To access twitter's stream api
- [DataMap](http://datamaps.github.io/)
  - For rendering quickly a map of the US
  

### Future features

Allow users to search for any keyword and map those tweets. Feel free to fork and use this project to further extend its limited features.
