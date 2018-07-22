class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end
    
    req.path.match(/cart/)
    if @@cart != []
      @@cart.map do |c|
        resp.write "#{c}\n"
      end
    else
      resp.write "Your cart is empty."
    end
    
    req.path.match(/add/)
 
    add_item = req.params["items"]
 
    if @@items.include?(add_item)
      resp.write "added #{add_item}\n"
    else
      resp.write "We dont have that item"
    end
    
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
