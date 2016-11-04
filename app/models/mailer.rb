class Mailer

  def create_url(url)
    url = request.url
    url.gsub!('/users', '/spaces')
  end

  def send_welcome(email, url)
    Pony.mail(to: email,
              subject: 'Welcome to Team3 AirBNB',
              body: "Hello there. Take a look at our beautiful spaces here: #{url}")
  end

  def space_created(email, url)
    Pony.mail(to: email,
              subject: 'Your space has been generated!!!!!',
              html_body: "Hello there. Take a look at your beautiful space here: <a href=#{url}>View your space</a>")
              # %a{href: "#{locals[:url]}", alt: "Verify", title: "Click to verify account" + url + "cansdo"
   #{locals[:url]}
  end

end
