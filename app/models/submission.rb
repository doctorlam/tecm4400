class Submission < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
	has_many :portals
	has_many :gradecategorizations 
	
	has_many :assignments, :through => :portals,  dependent: :destroy
	has_many :grades, :through => :gradecategorizations

	has_attached_file :document
  	validates_attachment_file_name :document, :matches => [/pdf\Z/, /pptx\Z/, /docx\Z/, /zip\Z/, /xlsx\Z/]
  			

  	has_attached_file :image
  	validates_attachment_file_name :image, :matches => [/pdf\Z/, /pptx\Z/, /docx\Z/, /zip\Z/, /xlsx\Z/]

  			attr_accessor :delete_image
  			before_validation { image.clear if delete_image == '1' }

		 module DeletableAttachment
		  extend ActiveSupport::Concern

		  included do
		    attachment_definitions.keys.each do |name|

		      attr_accessor :"delete_#{name}"
		      attr_accessible :"delete_#{name}"
		      
		      before_validation { send(name).clear if send("delete_#{name}") == '1' }

		      define_method :"delete_#{name}=" do |value|
		        instance_variable_set :"@delete_#{name}", value
		        send("#{name}_file_name_will_change!")
		      end

		    end
		  end

		end
  	attr_writer :current_step
		def current_step
		  @current_step || steps.first
		end

		def steps
		  %w[assignment content]
		end

		def next_step
		  self.current_step = steps[steps.index(current_step)+1]
		end

		def previous_step
		  self.current_step = steps[steps.index(current_step)-1]
		end

		def first_step?
		  current_step == steps.first
		end

		def last_step?
		  current_step == steps.last
		end

		def all_valid?
		  steps.all? do |step|
		    self.current_step = step
		    valid?
		  end
		end
end