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
    content_hash = {}

    browser = ScraperHelper.build
    cost_of_leaving_url = "https://nomadlist.com/cost-of-living/in/#{arrival.downcase}"
    browser.visit(cost_of_leaving_url)
    cost_of_leaving = browser.all(".tab-cost-of-living table tr:nth-child(1)").first


    if cost_of_leaving.nil?
      content_hash[:cost_of_leaving] = false
    else
      nomad_cost_data = browser.all(".tab-cost-of-living table tr:nth-child(1)").first.text.gsub(",","").match(/\d+/)[0].to_i
      expat_cost_data = browser.all(".tab-cost-of-living table tr:nth-child(2)").first.text.gsub(",","").match(/\d+/)[0].to_i
      content_hash[:cost_of_leaving] = (nomad_cost_data + expat_cost_data).fdiv(60)
    end

    return content_hash
  end

  def self.get_suggested_atm(arrival)
    content_hash = {}
    browser = ScraperHelper.build

    nomad_guide_url = "https://nomadlist.com/nomad-guide/#{arrival.downcase}"
    browser.visit(nomad_guide_url)
    suggested_atm = browser.find_all("tr", text:/Suggested ATM?/i).first

    if suggested_atm.nil?
      content_hash[:suggested_atm] = false
    else
      suggested_atm_data = browser.find_all("tr", text:/Suggested ATM?/i).first.find(".value").text.gsub(/\D/, "").to_i
      content_hash[:suggested_atm] = suggested_atm_data
    end

    return content_hash
  end

end

