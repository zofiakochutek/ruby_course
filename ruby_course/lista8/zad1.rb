require 'open-uri'
require 'digest'
require 'yaml/store'
require 'openssl'
require 'test/unit'

#(zad4. z listy5. zaimplementowane przy pomocy wątków)

class Monitor
  def initialize(urls_tab, status_tab)
    @webs = urls_tab
    @status_tab = status_tab
  end
  def get_urls
    return @webs
  end
  def get_status_tab
    return @status_tab
  end
  def to_md5(urls_tab)
    url_dic = {}
    threads = []
    for url in urls_tab
      threads << Thread.new {
      fh = open(url)
      html = fh.read
      md5 = OpenSSL::Digest::MD5.hexdigest html
      html_md5_tab = [html, md5]
      url_dic[url] = html_md5_tab
    }
    end
    threads.each { |thr| thr.join }
    @status_tab.push(url_dic)
  end
  def reread(urls_tab)
    to_md5(urls_tab)
    l = @status_tab.length
    latest_status = @status_tab[l-1]
    previous_status = @status_tab[l-2]
    threads = []
    latest_status.each_key {|url|
      if latest_status[url][1] != previous_status[url][1]
        puts("Change in " + url)
      end
    }
  end
  def save_session(file_name)
    session_file = YAML::Store.new file_name
    session_file.transaction do
      for i in 0...@status_tab.length
          session = "session" + i.to_s
          session_file[session] = @status_tab[i]
      end
    end
  end
  def load_session(file_name)
    file = YAML::load(File.open(file_name))
    return file
  end
end


# web_tab = ["http://www.ii.uni.wroc.pl/~gst/MD/", "http://www.ii.uni.wroc.pl", "https://www.google.pl"]
# m1 = Monitor.new(web_tab, [])
# m1.to_md5(m1.get_urls)
#
# start = Time.now
# m1.reread(["http://www.ii.uni.wroc.pl/~gst/MD/", "https://www.google.pl"])
# finish = Time.now
# diff = finish - start
# puts(diff)

class TestMonitor < Test::Unit::TestCase
  def test1
    web_tab = ["http://www.ii.uni.wroc.pl/~gst/MD/", "http://www.ii.uni.wroc.pl", "https://www.google.pl"]
    assert_nothing_raised() { Monitor.new(web_tab, []) }
  end
  def test2
    web_tab = ["http://www.ii.uni.wroc.pl/~gst/MD/", "http://www.ii.uni.wroc.pl", "https://www.google.pl"]
    assert_equal([], Monitor.new(web_tab, []).get_status_tab )
  end
  def test3
      web_tab = ["http://www.ii.uni.wroc.pl/~gst/MD/", "http://www.ii.uni.wroc.pl", "https://www.google.pl"]
      assert_equal(web_tab, Monitor.new(web_tab, []).get_urls )
  end
end


#m1.save_session("newSession.store")
#puts(m1.load_session("newSession.store"))
