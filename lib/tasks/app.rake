namespace :app do

  desc "Populate some Insult Nouns"
  task :populate_nouns => :environment do
    [
      {:noun => "cunt-bag"},
      {:noun => "ballsac"},
      {:noun => "douche sipper"},
      {:noun => "cock sucker"},
      {:noun => "dickwad"},
      {:noun => "nit"},
      {:noun => "piece of shit"},
      {:noun => "ponce"},
      {:noun => "scrotum licker"},
      {:noun => "cunt"},
      {:noun => "bed wetter"},
      {:noun => "mouth breather"},
      {:noun => "fan of two girls one cup"},
      {:noun => "stuffed animal fucker"},
    ].each do |attributes|
      InsultNoun.find_or_create_by_noun(attributes)
    end
  end

  desc "Populate some Insult Adjectives"
  task :populate_adjectives => :environment do
    [
      {:adjective => "dirty"},
      {:adjective => "monkey fucking"},
      {:adjective => "harry palmed"},
      {:adjective => "toad licking"},
      {:adjective => "tree hugging"},
      {:adjective => "no good"},
      {:adjective => "slimey"},
      {:adjective => "fuckin"},
      {:adjective => "empty headed"},
      {:adjective => "nazi loving"},
      {:adjective => "pixie stick snorting"},
      {:adjective => "dim witted"},
      {:adjective => "fuckin"},
      {:adjective => "self righteous"},      
    ].each do |attributes|
      InsultAdjective.find_or_create_by_adjective(attributes)
    end
  end
end