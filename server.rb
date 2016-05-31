require "sinatra"
require "pry"
require "csv"

get "/articles/new" do
  erb :post_article
end

post "/articles/new_post" do
  @article_title = params['article_title']
  @article_url = params['article_url']
  @article_description = params['article_description']
  @error_msg
  dupe_article = false

  if @article_url[0..3] != "http"
    @article_url = "http://" + @article_url
  end

  CSV.foreach("articles.csv") do |row|
    if @article_url == row[1]
      dupe_article = true
      break
    end
  end
  if @article_title.length == 0 || @article_url.length == 0 || @article_description.length == 0
    @error_msg = "You did not supply all arguments"
    erb :post_article
  elsif @article_description.length < 20
    @error_msg = "Your description is < 20 chars long."
    erb :post_article
  else
    if dupe_article
      @error_msg = "That article has already been submitted"
      erb :post_article
    else
      @error_msg = ""

      File.open('articles.csv', 'a') do |file|
        file.puts(@article_title + "," + @article_url + "," + @article_description)
      end

      redirect '/articles'
    end
  end
end

get "/articles" do
  @titles = []
  @urls = []
  @descriptions = []
  CSV.foreach("articles.csv") do |row|
    @titles << row[0]
    @urls << row[1]
    @descriptions << row[2]
  end
  erb :articles
end
