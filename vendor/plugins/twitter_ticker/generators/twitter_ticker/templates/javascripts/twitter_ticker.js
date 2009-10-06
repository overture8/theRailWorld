var twitter_ticker = false;
var keywords = 'save the world';
var from_user = '';
var auto = false;

Window.prototype.is_ie6 = function() {
	return window.external && typeof window.XMLHttpRequest == "undefined";
}

String.prototype.linkuser = function() {
	return this.replace(/[@]+[A-Za-z0-9-_]+/g,
	function(u) {
	    var username = u.replace("@", "");
	    return u.link("http://twitter.com/" + username);
	});
};


(function(){
  var id = 0, head = $$('head')[0], global = this;
  global.getJSON = function(url, callback) {
    var script = document.createElement('script'), token = '__jsonp' + id;
    global[token] = callback;
    script.src = url.replace(/\?(&|$)/, '__jsonp' + id + '$1');
    script.onload = function() {
      script.remove();
      script = null;
      delete global[token];
    };
    head.appendChild(script);  
		id++;
  }
})();


var TwitterTicker = Class.create({

	  initialize: function(){
	    this.data = {};			
			this.setContainer();
			this.auto = auto;
			this.speeds = $H({'crawl': 12000, 'walk' : 10000, 'run' : 6000, 'sprint' : 4000});
			
			try {this.rate = this.speeds.get(speed) || 10000 } catch(e) {this.rate = 10000;}				

				
			if(keywords == '' || !keywords)
					this.query = 'save the world';					
				else
					this.query = keywords;					
					
		   if(!!from_user) {
					this.query = "from:" + from_user;
				}
				
			if(this.auto)	
				this.revealPanel();
					
		},
		
		setContainer: function(){
			var wrapper = new Element('div', {id:'TwitterTickerWrapper'});
			var vanity_badge = new Element('span', {'id':'TT', 'style':'display:none;'}).update("<a href='http://twitter.com'>Powered by <strong>Twitter</strong></a><br /><a href='http://eduvoyage.com'>TwitterTicker by <strong>eduVoyage</strong></a>");			
			var toggle = new Element('a', {id:'TwitterTickerToggle'}).update('open/close');
			var innerWrapper = Element('div', {id:'TwitterTicker'});
			wrapper.appendChild(toggle);
			wrapper.appendChild(innerWrapper);
			wrapper.appendChild(vanity_badge);			
			$$('body')[0].appendChild(wrapper);			
			$('TwitterTickerToggle').observe('click', (
				function(event) { 
					if(this.container.getHeight() > 13) {
				    if(this.showTimer) { clearTimeout(this.showTimer); this.showTimer = null; };
				    if(this.fadeTimer) { clearTimeout(this.fadeTimer); this.fadeTimer = null; };
						if(this.tweet){this.tweet.remove()};
						$('TT').hide();
						$('TwitterTicker').morph('height:13px');
					}
					else {
						this.revealPanel();
					}
				}.bind(this)));
			this.container = $('TwitterTicker');
		},
		
		revealPanel: function() {
			new Effect.Morph($('TwitterTicker'), {
			style: {height : '70px'},
			afterFinish: function(){
				new Effect.Appear('TT');
				this.fetchTweetsFromTwitter();
				}.bind(this)
			});
		},
					
	  fetchTweetsFromTwitter: function(){
			this.tweetNumber = 0;
			
			var url = 'http://search.twitter.com/search.json?q=' + encodeURIComponent(this.query) + '&callback=?';
    	getJSON(url, function(json){
				var data = json.results.reverse().map(function(tweet){ return { tweet: tweet.text.linkuser(), user: tweet.from_user, photo: new Element('img', {'src' : tweet.profile_image_url}) }; });
					if(data.size() == 0)
						this.showNotice();
					else
						this.displayTweet(data);
				}.bind(this));				
			},
			
		displayTweet: function(tweets) {
			this.flashChirp(tweets[this.tweetNumber]);
	    if(++this.tweetNumber<tweets.size())
	      this.showTimer = setTimeout(this.displayTweet.bind(this,tweets), this.rate);
	    else {
				this.fetchTweetsFromTwitter();
				}
		},
			
		flashChirp: function(chirp) {	

 					var tweet = new Element('dl');
					var avatar = new Element('img', {'src':chirp.photo, 'class':'twitterTickerAvatar'});
					var description = "<strong>by <a href='http://twitter.com/" + chirp.user + "'>" + chirp.user + "</a></strong><br />";
					description 	 += chirp.tweet;			
					tweet.appendChild(new Element('dt').update(chirp.photo));
					tweet.appendChild(new Element('dd').update(description));
					this.tweet = tweet;
					this.container.update(tweet.hide());
					Effect.Appear(tweet);
					this.fadeTimer = setTimeout(this.fadeChirp.bind(this, tweet), this.rate - 1000);
		
			},
			
		showNotice: function() {
			var msg = new Element('h3').update('<strong>Whoops! No Tweets were found.</strong>');
			this.container.update(msg.hide());
			Effect.Appear(msg);					
		},			
		
		fadeChirp: function(tweet) {Effect.Fade(tweet);}
	});

document.observe('dom:loaded', function () { 
	if(twitter_ticker) {var tt = new TwitterTicker()}; 	
	});