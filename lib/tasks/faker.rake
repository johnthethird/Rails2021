
def beach_name
 a = %w{Blacks Red Bloody NoToes Crimson Towering Barrel Octopus Wet Sharky Smelly Shark Park Summer Autumn Paradise Eagle Pine Royal University Willow}
 b = %w{Bros Groms Dudes Village Creek Tide Place Pointe SeaCliff Cliff Square Oaks Crossing Heights River Lake}
 c = ["Beach", "Break", "Tidewater", "Rivermouth", "Sewer", "Street", "Closeout", nil]
 [a.sample, b.sample, c.sample].compact.join(" ") 
end

def subtitle
  [
    Faker::TvShows::MichaelScott.quote,
    Faker::Quotes::Shakespeare.king_richard_iii_quote, 
    Faker::Quote.most_interesting_man_in_the_world, 
    Faker::Quote.robin
  ].sample
end

Fabricator(:card) do
  title { beach_name }
  subtitle { subtitle }
  image_url { Faker::LoremFlickr.image(size: '400x200', search_terms: %w{surf ocean}) + "?lock=#{rand(10000)}" }
  content {Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4) }
end


namespace :faker do
  desc "Load Faker Cards"
  task :load_fake_cards, [:count] => [:environment] do |t, args|
    progressbar = ProgressBar.create(total: args[:count].to_i)
    (1..args[:count].to_i).each_with_index do |i|
      card = Fabricate(:card, title: beach_name) rescue nil
      progressbar.increment

    end
  end
end