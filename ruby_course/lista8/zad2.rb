require "open-uri"
require "nokogiri"
require "test/unit"

#ponowna implementacja zadania 1. z listy 5. tym razem
#przy pomocy wątków i z testami jednostkowymi

class PageBrowse
  def initialize(start_page, depth, block)
    @start_page = start_page
    @depth = depth
    @block = block
  end
  def get_sp
    return @start_page
  end
  def search_urls(url)
    doc = Nokogiri::HTML(open(url).read)
    urls = doc.search("a").map{|tag|
      if tag.name.downcase == "a"
        tag["href"]
      end
    }
    correct_urls = []
    if urls != nil
      for i in urls
        if i != nil && i[0] == "h"
          correct_urls.push(i)
        end
      end
    end
    return correct_urls
  end
  def apply_block(url)
    @block.call(url)
    urls = search_urls(url)
    @depth -= 1
    if @depth > 0
      urls.map{|url| apply_block(url)}
    end
  end
  def page_weight
    counter = 0
    threads = []
    open(@start_page) do | fh |
      fh.each_line do |line|
          threads << Thread.new{
      	    line.split(' ').each do |slowo|
      	    	if slowo.include? "img" or slowo.include? "applet"
                counter += 1
      				end
      		end
        }
    	end
      threads.each { |thr| thr.join }
    end
    return counter
  end
  def read_title
    title_content = ""
    write = false
    open("http://www.ii.uni.wroc.pl") do | fh |
      fh.each_line do |line|
        if line.include? "/title"
          break
        end
        if write == true
          title_content += line
        end
        if line.include? "title"
          write = true
        end
    	end
    end
    return title_content
  end
  def read_info(key)
    pattern = /"\D*"/
    open("http://www.ii.uni.wroc.pl") do | fh |
      fh.each_line do |line|
        if line.include? key
          if line =~ pattern
            return $&
          end
        end
    	end
    end
  end
  def page_summary
    title = read_title()
    description = read_info("description")
    author = read_info("author")
    keywords = read_info("keywords")
    puts "Title: " + title
    puts description
    puts author
    puts keywords
  end
end


#proc = lambda {|url| puts url}

#b = PageBrowse.new("http://www.ii.uni.wroc.pl", 2, proc)

# start = Time.now
# puts(b.page_weight)
# finish = Time.now
# diff = finish - start
# puts(diff)



class TestPageBrowse < Test::Unit::TestCase
  def test1
    proc = lambda {|url| puts url}
    assert_equal(4, PageBrowse.new("http://www.ii.uni.wroc.pl", 2, proc).page_weight)
  end
  def test2
    proc = lambda {|url| puts url}
    assert_nothing_raised() {PageBrowse.new("http://www.ii.uni.wroc.pl", 2, proc) }
  end
  def test3
    proc = lambda {|url| puts url}
    assert_equal(37, PageBrowse.new("https://skos.ii.uni.wroc.pl/course/index.php?categoryid=7", 2, proc).page_weight)
  end
end


#b.page_summary
#puts(b.search_urls("https://www.google.pl/"))

#puts(b.get_sp)
#puts(b.search_urls(b.get_sp))
#puts("---------------------------")

#b.apply_block(b.get_sp)
