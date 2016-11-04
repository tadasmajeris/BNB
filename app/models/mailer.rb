class Mailer

  def self.create_url(url)
    "http://localhost:9292/" + url
  end

  def self.send_welcome(email, url)
    full_url = create_url(url)
    Pony.mail(to: email,
              subject: 'Welcome to Team3 AirBNB',
              body: "Hello there. Take a look at our beautiful spaces here: #{full_url}")
  end

  def self.space_created(email, url)
    full_url = create_url(url)
    Pony.mail(to: email,
              subject: 'Your space has been generated!!!!!',
              html_body: "Hello there. Take a look at your beautiful space here: <a href=#{full_url}>View your space</a>")
  end

  def self.space_updated(email, url)
    full_url = create_url(url)
    Pony.mail(to: email,
              subject: 'Your space has been updated!!!!!',
              html_body: "Hello there. Take a look at your beautiful space here: <a href=#{full_url}>View your space</a>")
  end

  def self.space_requested(email, url, date)
    full_url = create_url(url)
    Pony.mail(to: email,
              subject: 'Your space request!',
              html_body: "Hello there. Thank you for requesting <a href=#{full_url}>this space</a> for this date #{date}")
  end

  def self.space_confirmed(email, space, date)
    Pony.mail(to: email,
              subject: 'Your request has been confirmed!',
              html_body: "Hello there. Your request to stay at #{space} on #{date} has been confirmed. Have a nice stay!")
  end

  def self.space_denied(email, space, date)
    Pony.mail(to: email,
              subject: 'Sorry but your request has been declined :(',
              html_body: "Hello there. Your request to stay at #{space} on #{date} has been declined. Very sorry!!!")
  end
end
