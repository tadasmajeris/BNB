class Mailer

  def create_url(url)
    "http://localhost:9292" + url
  end

  def send_welcome(email, url)
    full_url = create_url(url)
    Pony.mail(to: email,
              subject: 'Welcome to Team3 AirBNB',
              body: "Hello there. Take a look at our beautiful spaces here: #{full_url}")
  end

  def space_created(email, url)
    full_url = create_url(url)
    Pony.mail(to: email,
              subject: 'Your space has been generated!!!!!',
              html_body: "Hello there. Take a look at your beautiful space here: <a href=#{full_url}>View your space</a>")
  end

  def space_updated(email, url)
    full_url = create_url(url)
    Pony.mail(to: email,
              subject: 'Your space has been updated!!!!!',
              html_body: "Hello there. Take a look at your beautiful space here: <a href=#{full_url}>View your space</a>")
  end

  def space_requested(email, url, date)
    full_url = create_url(url)
    Pony.mail(to: email,
              subject: 'Your space request!',
              html_body: "Hello there. Thank you for requesting <a href=#{full_url}>this space</a> for this date #{date}")
  end

end
