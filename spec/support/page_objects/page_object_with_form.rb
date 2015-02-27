module PageObjects
  class PageObjectWithForm < PageObject
    def fill_in_form(overrides = {})
      attributes = defaults.merge(overrides)
      populate(attributes)
    end

    def field(attribute)
      find_field(id_for(attribute))
    end

    def submit_form
      find("input[type=submit]").click
    end

    private

    # TODO: Remove the case statement in this method in favour of a strategy
    #       based on the control type. Also add support for other control types.
    def populate(attributes)
      attributes.each do |attribute, value|
        id = id_for(attribute)

        case control_type_for(id)
        when :file
          attach_file id, value
        when :select
          find_by_id(id).find("option[value='#{value}']").select_option
        when :checkbox
          find_by_id(id).set(value)
        else
          fill_in id, :with => value
        end
      end
    end

    def control_type_for(id)
      control = find_by_id(id)

      (control["type"] || control.tag_name).to_sym
    end

    def id_for(attribute)
      "#{element_prefix}_#{attribute}"
    end
  end
end
