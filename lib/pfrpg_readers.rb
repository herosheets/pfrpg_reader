module PfrpgReaders
end

require 'pfrpg_readers/filters/filter'
require 'pfrpg_readers/attack'
require 'pfrpg_readers/attackable'
require 'pfrpg_readers/attributes_reader'
require 'pfrpg_readers/avatar_url'
require 'pfrpg_readers/combat_reader'
require 'pfrpg_readers/defensible'
require 'pfrpg_readers/demographics_reader'
require 'pfrpg_readers/feature_duplicator'
require 'pfrpg_readers/inventory_reader'
require 'pfrpg_readers/misc_reader'
require 'pfrpg_readers/pfrpg_character'
require 'pfrpg_readers/pfrpg_npc'
require 'pfrpg_readers/saves_reader'
require 'pfrpg_readers/skills_reader'
require 'pfrpg_readers/spells_reader'
require 'pfrpg_readers/validation_reader'
require 'pfrpg_readers/version'

Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), 'pfrpg_readers/')) + "/**/*.rb"].each do |file|
  require file
end