# this will become unwieldly over time. It is a quick solution to something
# I don't want to spend more time on right now
class PostsController < ApplicationController
  POSTS_DIR="app/blogposts"  
  
  def index
    slurp_up_posts()
  end

  def slurp_up_posts()
    @posts = []
    # for now, assume everything in the dir is a post
    Dir.glob("#{POSTS_DIR}/*").each{|x|
      @posts.push(objectify_post(x))
    }
    @posts.sort!{|a,b| a[:post_date] <=> b[:post_date]}
    post_no = 0

    @posts.collect!{|post|
      post_no += 1
      post[:post_no] = post_no
      post
    }
  end

  def objectify_post(post_filename)
    post = {}
    open(post_filename) {|f|
      post[:title] = f.readline
      post[:title].gsub!(' ', '&nbsp;')
      post[:title] = post[:title].html_safe
      post[:post_date] = f.readline
      post[:content] = f.read.html_safe
    }
    return post
  end

end
