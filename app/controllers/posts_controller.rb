# this will become unwieldly over time. It is a quick solution to something
# I don't want to spend more time on right now

class Post
  attr_accessor :title, :post_date, :content, :id

  # this is a hack to get around a link_to bug in rails that was throwing an
  # undefined method exception. I am sure there is a less evil way and I am
  # well aware of the evilness of putting markup in a controller
  def generate_link
    return %Q{<a href="/posts/#{@id}">#{@title}</a>}.html_safe
  end
end

class PostsController < ApplicationController
  POSTS_DIR="app/blogposts"  
  
  def index
    slurp_up_posts()
  end

  def show
    slurp_up_posts()
    @current_post_no = params[:id]
    @current_post = @posts.find{|x| x.id == @current_post_no}
    render "index"
  end

  def slurp_up_posts()
    @posts = []
    # for now, assume everything in the dir is a post
    Dir.glob("#{POSTS_DIR}/*").each{|x|
      @posts.push(objectify_post(x))
    }
    @posts.sort!{|a,b| a.post_date <=> b.post_date}
    post_no = 0

    @posts.collect!{|post|
      post_no += 1
      post.id = post_no.to_s.html_safe
      post
    }
  end

  def objectify_post(post_filename)
    post = Post.new()
    open(post_filename) {|f|
      post.title = f.readline
      post.title.gsub!(' ', '&nbsp;')
      post.title = post.title.html_safe
      post.post_date = f.readline.html_safe
      post.content = f.read.html_safe
    }
    return post
  end

end
