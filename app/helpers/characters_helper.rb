# characters helper model

module CharactersHelper
  def check_format(num)
    ("&#x2713;" * num) + ("&#9723;" * (3 - num))
  end
end
