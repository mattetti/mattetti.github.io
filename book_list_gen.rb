

class Book
  attr_accessor :img, :title, :url, :author, :author_url, :type, :reco_name, :reco_twitter, :reco_img

  def initialize(opts={})
    opts.each do |k,v|
      setter = "#{k}="
      if self.respond_to?(setter)
        self.send(setter, v)
      end
    end
    self
  end

  def to_html
    twitter_img_url = reco_img ? "<img src='#{reco_img}' ><br />" : nil
    <<-EOS
  <tr>
    <td><a href="#{url}"><img src="#{img}" alt="#{title}" border="0" style="padding-top:10px"></a></td>
    <td><a href="#{url}" target="_blank">#{title}</a></td>
    <td>#{type}</td>
    <td><a title="@#{reco_twitter}" href="https://twitter.com/#{reco_twitter}" target="_blank"> #{twitter_img_url} #{reco_name}<br />@#{reco_twitter}</a></a></td>
  </tr>
EOS
  end
end

header = <<-HEAD
<table>
  <thead>
  <tr>
    <th style="width:20%; text-align:center"> Cover  </th>
    <th style="width:30%; text-align:center"> Title </th>
    <th style="width:20%; text-align:center"> Type </th>
    <th style="width:30%; text-align:center"> Recommended by</th>
  </tr>
  </thead>
  <tbody>
HEAD

footer = <<-FOOTER
  </tbody>
</table>
FOOTER


body = [

  Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/51rwkxlzOQL._SL160_.jpg",
            title: "The Interestings",
            url: "http://www.amazon.com/gp/product/B008U4HH54/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B008U4HH54&linkCode=as2&tag=merbist-20",
            author: "Meg Wolitzer",
            author_url: "http://www.megwolitzer.com/",
            type: "Novel",
            reco_name: "Andrew Weissman",
            reco_twitter: "aweissman",
            reco_img: "https://pbs.twimg.com/profile_images/344513261581924513/b3735cda4529be5530c9d29b6f8e148e_bigger.jpeg"),

  Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/51mquDqvXDL._SL160_.jpg",
            title: "Lexicon",
            url: "http://www.amazon.com/gp/product/B00AEBETMK/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B00AEBETMK&linkCode=as2&tag=merbist-20",
            author: "Max Barry",
            author_url: "http://en.wikipedia.org/wiki/Max_Barry",
            type: "Novel",
            reco_name: "Amos King",
            reco_twitter: "Adkron",
            reco_img: "https://pbs.twimg.com/profile_images/3485440049/a0f1a8fd26883c905443be6b17091a43_bigger.jpeg"),

   Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/416VaBI-AnL._SL160_.jpg",
            title: "The Orphan Master's Son (Pulitzer Prize for Fiction)",
            url: "https://www.amazon.com/dp/B004X6PRO6?tag=merbist-20&camp=0&creative=0&linkCode=as4&creativeASIN=B004X6PRO6&adid=040WG8W6HCZ9D7GW6FCZ&",
            author: "Adam Johnson",
            author_url: "http://en.wikipedia.org/wiki/Adam_Johnson_(writer)",
            type: "Novel",
            reco_name: "Bryan Woods",
            reco_twitter: "bryanwoods",
            reco_img: "https://pbs.twimg.com/profile_images/378800000586125380/e28de02be744272035a9b5509d5ab576_bigger.jpeg"),

    Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/510e7pW7-YL._SL160_.jpg",
            title: "The Flamethrowers",
            url: "http://www.amazon.com/gp/product/B008J4NBHI/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B008J4NBHI&linkCode=as2&tag=merbist-20",
            author: "Rachel Kushner",
            author_url: "http://en.wikipedia.org/wiki/Rachel_Kushner",
            type: "Novel",
            reco_name: "Andrew Weissman",
            reco_twitter: "aweissman",
            reco_img: "https://pbs.twimg.com/profile_images/344513261581924513/b3735cda4529be5530c9d29b6f8e148e_bigger.jpeg"),

  Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/51uYnHtUXLL._SL160_.jpg",
            title: "Mr. Penumbra's 24-Hour Bookstore",
            url: "http://www.amazon.com/gp/product/B008FPOIT6/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B008FPOIT6&linkCode=as2&tag=merbist-20",
            author: "Robin Sloan",
            author_url: "http://www.robinsloan.com/about/",
            type: "Novel",
            reco_name: "Chris Conrey",
            reco_twitter: "conrey",
            reco_img: "https://pbs.twimg.com/profile_images/378800000197700668/7625b773ea917bcd87aa8c2a0be8588f_bigger.jpeg" ),

  Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/41HZER4774L._SL160_.jpg",
            title: "Lying Awake",
            url: "http://www.amazon.com/gp/product/B000FBJF8C/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B000FBJF8C&linkCode=as2&tag=merbist-20",
            author: "Mark Salzman",
            author_url: "http://en.wikipedia.org/wiki/Mark_Salzman",
            type: "Novel",
            reco_name: "Andrew Weissman",
            reco_twitter: "aweissman",
            reco_img: "https://pbs.twimg.com/profile_images/344513261581924513/b3735cda4529be5530c9d29b6f8e148e_bigger.jpeg"),

  Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/31kDOO-T2lL._SL160_.jpg",
            title: "Perdido Street Station",
            url: "http://www.amazon.com/gp/product/B000FBFO8C/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B000FBFO8C&linkCode=as2&tag=merbist-20",
            author: "China Mieville",
            author_url: "http://en.wikipedia.org/wiki/China_Mi%C3%A9ville",
            type: "Novel",
            reco_name: "Olivier Gutknecht",
            reco_twitter: "olg",
            reco_img: "https://pbs.twimg.com/profile_images/204337634/935afae3375820ecc0bfbe5288d9b411-2_bigger.jpeg"),

    Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/51MCnQRKCyL._SL160_.jpg",
            title: "The Sisters Brothers",
            url: "http://www.amazon.com/gp/product/B004CFA91Y/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B004CFA91Y&linkCode=as2&tag=merbist-20",
            author: "Patrick deWitt",
            author_url: "http://en.wikipedia.org/wiki/Patrick_deWitt",
            type: "Novel",
            reco_name: "Andrew Weissman",
            reco_twitter: "aweissman",
            reco_img: "https://pbs.twimg.com/profile_images/344513261581924513/b3735cda4529be5530c9d29b6f8e148e_bigger.jpeg"),

    Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/51zzGBqKVPL._SL160_.jpg",
            title: "Killing Floor (Jack Reacher, No. 1)",
            url: "http://www.amazon.com/gp/product/B000OZ0NXA/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B000OZ0NXA&linkCode=as2&tag=merbist-20",
            author: "Lee Child",
            author_url: "http://en.wikipedia.org/wiki/Lee_Child",
            type: "Novel",
            reco_name: "Dr Nic",
            reco_twitter: "drnic",
            reco_img: "https://pbs.twimg.com/profile_images/2243751587/drnic_by_jeff_casimir_at_railsconf2010_-_thumbnail_bigger.png"),

    Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/51KOAfltTRL._SL160_.jpg",
            title: "Jonathan Strange and Mr Norrell",
            url: "http://www.amazon.com/gp/product/B003RRXXMA/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B003RRXXMA&linkCode=as2&tag=merbist-20",
            author: "Susanna Clarke",
            author_url: "http://en.wikipedia.org/wiki/Susanna_Clarke",
            type: "Novel",
            reco_name: "Olivier Gutknecht",
            reco_twitter: "olg",
            reco_img: "https://pbs.twimg.com/profile_images/204337634/935afae3375820ecc0bfbe5288d9b411-2_bigger.jpeg"),

    Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/41shZGS-G%2BL._SL160_.jpg",
            title: "Thinking, Fast and Slow",
            url: "https://www.amazon.com/dp/B00555X8OA?tag=merbist-20&camp=0&creative=0&linkCode=as4&creativeASIN=B00555X8OA&adid=0PMMZTW1D2GZ2JYSBZ7S&",
            author: "Daniel Kahneman",
            author_url: "http://en.wikipedia.org/wiki/Daniel_Kahneman",
            type: "Psychology / Business Decision-Making",
            reco_name: "Greg Borenstein",
            reco_twitter: "atduskgreg",
            reco_img: "https://pbs.twimg.com/profile_images/413083183471538176/pxJfy0v1_bigger.png"),

  Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/51ag2JxaFxL._SL160_.jpg",
            title: "The Signal and the Noise: Why So Many Predictions Fail-but Some Don't",
            url: "http://www.amazon.com/gp/product/B007V65R54/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B007V65R54&linkCode=as2&tag=merbist-20",
            author: "Nate Silver",
            author_url: "http://en.wikipedia.org/wiki/Nate_Silver",
            type: "Business Planning & Forecasting",
            reco_name: "Mathias Meyer",
            reco_twitter: "roidrage",
            reco_img: "https://pbs.twimg.com/profile_images/2938540224/9ffc554b0eabb077a915cfe0d56f3c1f_bigger.jpeg"),

  Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/41ukeeK16zL._SL160_.jpg",
            title: "The Life You Can Save: Acting Now to End World Poverty",
            url: "http://www.amazon.com/gp/product/B001S59CP0/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B001S59CP0&linkCode=as2&tag=merbist-20",
            author: "Peter Singer",
            author_url: "http://en.wikipedia.org/wiki/Peter_Singer",
            type: "Philanthropy & Charity",
            reco_name: "Theresa Preston-Werner",
            reco_twitter: "tpdubs2",
            reco_img: "https://pbs.twimg.com/profile_images/1875371426/IMG_1963_bigger.jpg"),

    Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/51LhBKtrCZL._SL160_.jpg",
            title: "Thinking in Systems: A Primer",
            url: "http://www.amazon.com/gp/product/B005VSRFEA/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B005VSRFEA&linkCode=as2&tag=merbist-20",
            author: "Donella H. Meadows",
            author_url: "http://en.wikipedia.org/wiki/Donella_Meadows",
            type: "Problem Solving",
            reco_name: "Mathias Meyer",
            reco_twitter: "roidrage",
            reco_img: "https://pbs.twimg.com/profile_images/2938540224/9ffc554b0eabb077a915cfe0d56f3c1f_bigger.jpeg"),

  Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/51S0zRDsbtL._SL160_.jpg",
            title: "High Performance Browser Networking",
            url: "https://www.amazon.com/dp/B00FM0OC4S?tag=merbist-20&amp;camp=0&amp;creative=0&amp;linkCode=as4&amp;creativeASIN=B00FM0OC4S&amp;adid=01GQ5KB9AGZ9M02BFA7B&amp;",
            author: "Ilya Grigorik",
            author_url: "http://www.igvita.com/",
            type: "Technical",
            reco_name: "Kevin Stewart",
            reco_twitter: "kstewart",
            reco_img: "https://pbs.twimg.com/profile_images/411994393231372288/fiPif7_Q_bigger.jpeg"),

  Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/51KxC4wQCsL._SL160_.jpg",
            title: "NOS4A2",
            url: "http://www.amazon.com/gp/product/B009NF6Z2K/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B009NF6Z2K&linkCode=as2&tag=merbist-20",
            author: "Joe Hill",
            author_url: "http://www.amazon.com/Joe-Hill/e/B001IGSNRW/ref=ntt_athr_dp_pel_pop_1",
            type: "Novel (horror)",
            reco_name: "Jason Rush",
            reco_twitter: "diminish7",
            reco_img: "https://pbs.twimg.com/profile_images/1434299830/jason_on_grays_and_torreys_climb_bigger.jpg"),

  Book.new( img: "https://images-na.ssl-images-amazon.com/images/I/31c63zBdD6L._SL160_.jpg",
            title: "Basic Economics: A Common Sense Guide to the Economy, 4th Edition",
            url: "http://www.amazon.com/gp/product/B0047T86CO/ref=as_li_ss_il?ie=UTF8&camp=1789&creative=390957&creativeASIN=B0047T86CO&linkCode=as2&tag=merbist-20",
            author: "Thomas Sowell",
            author_url: "http://en.wikipedia.org/wiki/Thomas_Sowell",
            type: "Economics",
            reco_name: "Ben Hughes",
            reco_twitter: "rubiety",
            reco_img: "https://pbs.twimg.com/profile_images/2909781099/17f882cfce30ac2a938d072c85251d55_bigger.png"),

].map{|b| b.to_html }.join("\n")

puts [header, body, footer].join("\n")
