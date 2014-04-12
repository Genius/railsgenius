class FlashMessages < Perspectives::Base
  param :flash

  property(:flash_types) do
    flash.map do |key, value|
      {
        key: key,
        display_key: key.capitalize,
        messages: Array(value).map { |v| {msg: v} }
      }.tap { flash.delete(key) }
    end
  end
end
