module TwitterTicker
  def display_twitter_ticker(options={})    
    "
    <script type='text/javascript'><!--
    twitter_ticker = true;
    from_user = '#{options[:from_user]}';
    keywords = '#{options[:query]}';
    speed = '#{options[:speed] || 'walk'}';
    auto = #{options[:auto] ? 'true' : 'false'};
    //--></script>
    "
  end 
end
