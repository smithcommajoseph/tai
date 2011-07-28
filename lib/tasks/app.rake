namespace :app do

  desc "Populate some Insult Nouns"
  task :populate_nouns => :environment do
    [
      {:noun => "cunt-bag"},
      {:noun => "ballsac"},
      {:noun => "douche sipper"},
      {:noun => "cock sucker"},
      {:noun => "fucker"},
      {:noun => "dickwad"},
      {:noun => "nit"},
      {:noun => "piece of shit"},
      {:noun => "ponce"},
      {:noun => "scrotum licker"},
    ].each do |attributes|
      InsultNoun.find_or_create_by_noun(attributes)
    end
  end

  desc "Populate some Insult Adjectives"
  task :populate_adjectives => :environment do
    [
      {:adjective => "dirty"},
      {:adjective => "fuckin"},
      {:adjective => "harry palmed"},
    ].each do |attributes|
      InsultAdjective.find_or_create_by_adjective(attributes)
    end
  end
end