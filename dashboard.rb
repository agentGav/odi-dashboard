#!/usr/bin/env ruby 
require 'trello'
    require "dotenv"
    require_relative "leftronic"

    Dotenv.load


    # Connect
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_DEV_KEY']
      config.member_token = ENV['TRELLO_MEMBER_KEY']
    end
 
   # Trello todo/doing queues
    progress=[]
    board = Trello::Board.find(ENV['TRELLO_BOARD'])
    list = board.lists.first(2).each do |list|
	puts "#{list.name}: #{list.cards.count}"
	list.cards.each do |card|
		puts card.name
		checklists = card.checklists.each do |checklist|
			total = checklist.check_items.count
		complete = checklist.check_items.select{|item| item["state"]=="complete"}.count
			task_progress =  complete.to_f/total.to_f
			progress << task_progress
		end	

	end
end

    org_progress = progress.inject{ |sum,element| sum += element } / progress.size 
	puts org_progress
	
	id=ENV['LEFTRONIC_DIAL1_ID']

    # Publish
    LeftronicPublisher.perform :number,id,org_progress
