#!/usr/bin/env ruby 
require 'trello'
    require "dotenv"
    Dotenv.load


    # Connect
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_DEV_KEY']
      config.member_token = ENV['TRELLO_MEMBER_KEY']
    end
 
   # Trello todo/doing queues
    board = Trello::Board.find(ENV['TRELLO_BOARD'])
    list = board.lists.each do |list|
	puts "#{list.name}: #{list.cards.count}"
	progress = list.cards.each do |card|
		puts card.name
		checklists = card.checklists.each do |checklist|
			total = checklist.check_items.count
		complete = checklist.check_items.select{|item| item["state"]=="complete"}.count
			puts complete.to_f/total.to_f
		end	

	end
end
    # Publish
