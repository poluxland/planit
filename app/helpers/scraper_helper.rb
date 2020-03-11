module ScraperHelper
  def self.build
    require 'capybara/poltergeist'
    Phantomjs.path # Force install on require
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path)
    end
    Capybara.default_driver = :poltergeist
    @browser = Capybara.current_session
  end

  def self.get_average_cost(arrival)
    browser = ScraperHelper.build
    p arrival
    cost_of_leaving_url = "https://nomadlist.com/cost-of-living/in/#{arrival.downcase}"
    browser.visit(cost_of_leaving_url)
    cost_of_leaving = browser.all(".tab-cost-of-living table tr:nth-child(1)").first

    # nomad_guide_url = "https://nomadlist.com/nomad-guide/#{arrival.downcase}"
    # browser.visit(nomad_guide_url)

    p cost_of_leaving

    if cost_of_leaving.nil?
      return false
    else
      nomad_cost_data = browser.all(".tab-cost-of-living table tr:nth-child(1)").first.text.gsub(",","").match(/\d+/)[0].to_i
      expat_cost_data = browser.all(".tab-cost-of-living table tr:nth-child(2)").first.text.gsub(",","").match(/\d+/)[0].to_i
      return (nomad_cost_data + expat_cost_data).fdiv(60)
    end
  end

end

