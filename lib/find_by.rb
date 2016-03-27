class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attribute|
      # TO REVIEWER: I still struggle to understand
      # instance_eval vs class_eval, even when I read
      # some tutorials about it. Could you try explaining
      # this or provide external resources?
      self.instance_eval(%Q{
        def find_by_#{attribute}(arg)
          all_items = self.all.each.select {|item| item.#{attribute} == arg}
          return all_items.first
        end
      })
    end
  end
end
