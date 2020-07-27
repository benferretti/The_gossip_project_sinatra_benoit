require 'csv'
require 'pry'
class Gossip

	attr_accessor :author, :content
	@@hash_comment = Hash.new
	def initialize(author, content)
	    @author = author
	    @content = content
	    
	end


	def save
	    CSV.open("db/gossip.csv", "ab") do |csv|
	      csv << ["#{@author}" , "#{@content}"]
	    end
	end


	def self.all
	    all_gossips = Array.new
	    CSV.read("db/gossip.csv").each do |csv_line|
	      all_gossips << Gossip.new(csv_line[0], csv_line[1])
	    end
	    return all_gossips
	end

	def self.find(id)
		id = id.to_i
		all_gossips = self.all
		return all_gossips[id]
	end

	def self.update(id, author, content)
		all_gossips = self.all
		all_gossips[id.to_i].author = author
	    all_gossips[id.to_i].content = content
	    File.open('db/gossip.csv', 'w') {|file| file.truncate(0) }
	    CSV.open("db/gossip.csv", "ab") do |csv|
	    	all_gossips.each do |i|
	      		csv << ["#{i.author}" , "#{i.content}"]
	      	end
	    end
	end

	def self.comment_gossip(id, comment)
		@@hash_comment.compare_by_identity
		@@hash_comment[id] = comment
		CSV.open("db/comments.csv", "ab") do |csv|
	     		 csv << ["#{id}" , "#{comment}"]
		end
		return @@hash_comment
	end

	def self.all_comments
		all_comments = Hash.new
		all_comments.compare_by_identity
	    CSV.read("db/comments.csv").each do |csv_line|
	      all_comments[csv_line[0]] = csv_line[1]
	    end
	    return all_comments
	end

end