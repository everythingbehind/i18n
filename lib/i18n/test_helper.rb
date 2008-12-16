module I18n
  module TestHelper
    def assert_all_locales_have_translations_available_to_the_default_locale(message = "All translations should be available in all locales")
      default_locale = I18n.default_locale.to_sym
      locales_to_check = I18n.locales - [default_locale]

      required_translations = I18n.available_translations(default_locale)

      locales_to_check.each do |target_locale|
        defined_translations = I18n.available_translations(target_locale.to_sym)
        missing_translations = required_translations - defined_translations
                
        if missing_translations.any?
          missing_translations_for_output = [*missing_translations.map{|a| " * #{a.join('.')}" }].join("\n")
          raise Test::Unit::AssertionFailedError.new("#{message} - Missing translations for #{target_locale.inspect}:\n#{missing_translations_for_output}")
        end
      end
    end
  end
end
