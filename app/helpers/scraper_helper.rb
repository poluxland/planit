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

  def self.get_average_cost(destination)
    browser = ScraperHelper.build
    url = "https://nomadlist.com/cost-of-living/in/#{destination.downcase}"
    browser.visit(url)
    nomad_cost_data = browser.all(".tab-cost-of-living table tr:nth-child(1)").first.text.gsub(",","").match(/\d+/)[0].to_i
    expat_cost_data = browser.all(".tab-cost-of-living table tr:nth-child(2)").first.text.gsub(",","").match(/\d+/)[0].to_i
    return (nomad_cost_data + expat_cost_data).fdiv(60)
  end
# def self.top_five_acctivity(city,country)
#     browser = ScraperHelper.build
#     url = "https://www.lonelyplanet.com/switzerland/geneva"

# end
end

