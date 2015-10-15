module ApplicationHelper
  class HTMLblocks < Redcarpet::Render::HTML

    include Sprockets::Rails::Helper
    include ActionView::Helpers::UrlHelper

    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end

    def parse_media_link(link)
      matches = link.match(/^([\w\d\.]+)(?:\|(\w+))?(?:\|([\w\s\d]+))?$/)
      { :id => matches[1], :size => (matches[2] || 'original').to_sym, :class => matches[3] } if matches
    end

    def image(link, title, alt_text)
      size = nil
      css_class = nil

      unless (parse = parse_media_link(link)) == nil
        media = Image.find_by_id(parse[:id]) || Image.find_by_name(parse[:id])
        if media
          size = media.file.image_size(parse[:size])
          link = media.file.url(parse[:size])
          css_class = parse[:class]
        end
      end

      image_tag(link, size: size, title: title, alt: alt_text, class: css_class)
    end
  end

  def markdown(content)
    renderer = HTMLblocks.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      escape_html: true
    }
    Redcarpet::Markdown.new(renderer, options).render(content).html_safe
  end

  def year_or_default(date, default="nyní")
    return date.strftime("%Y") if date
    return default
  end
end
