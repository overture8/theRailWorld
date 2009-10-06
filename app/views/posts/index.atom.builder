atom_feed do |feed|
    feed.title("theRailWorld.com blog")
    feed.updated(@posts.first.created_at)
    
    @all_posts.each do |post|
        feed.entry(post) do |entry|
            entry.title(post.title)
            entry.content(BlueCloth.new(post.body).to_html, :type => "html")
            entry.author(post.author)
        end
    end
end
