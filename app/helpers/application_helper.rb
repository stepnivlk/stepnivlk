module ApplicationHelper
  # Extend Redcarpet renderer and override default methods.
  class HTMLblocks < Redcarpet::Render::HTML

    include Sprockets::Rails::Helper
    include ActionView::Helpers::UrlHelper
    include ActionDispatch::Routing

    # Returns highlighted code with Pygments.
    #
    # code     - Code which will be highlighted.
    # language - Specify language of given code.
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end

    # Returns hash of information parsed from link.
    #
    # link - Link which will be parsed.
    # e.g. ![alt text](1|thumb|center)
    def parse_media_link(link)
      # Match "ID|size|classes"
      # size and classes are optional.
      matches = link.match(/^([\w\d\.]+)(?:\|(\w+))?(?:\|([\w\s\d]+))?$/)
      { id: matches[1], size: (matches[2] || 'original').to_sym, class: matches[3] } if matches
    end

    # Returns hash of information parsed from link.
    #
    # link - Link which will be parsed.
    # e.g. [link text](model|id)
    def parse_model_link(link)
      # Match "Model|ID"
      matches = link.match(/^([\w\.]+)(?:\:(\d+))?$/)
      { model: matches[1], id: matches[2] } if matches
    end

    # Returns image_tag based on given link
    #
    # link     - Redirects to parse_media_link.
    # title    - Title of given image.
    # alt_text - Alternative text for given image.
    def image(link, title, alt_text)
      css_class = nil

      if parse = parse_media_link(link)
        media = Image.find_by_id(parse[:id]) || Image.find_by_name(parse[:id])
        if media
          size = media.file.image_size(parse[:size])
          link = media.file.url(parse[:size])
          css_class = parse[:class]
        end
      end
      image_tag(link, size: size, title: title, alt: alt_text, class: css_class)

    end

    # Refactor! returns link_to given link
    #
    # link    - Redirects to parse_model_link.
    # title   - Title of given link.
    # content - Description of given link.
    def link(link, title, content)
      if parse = parse_model_link(link)
        case parse[:model].singularize.downcase
        when "post"
          link_to(content, Rails.application.routes.url_helpers.post_path(parse[:id].to_i))
        when "gallery"
          link_to(content, Rails.application.routes.url_helpers.gallery_path(parse[:id].to_i))
        when "user"
          link_to(content, Rails.application.routes.url_helpers.user_path(parse[:id].to_i))
        end
      end
    end
  end

  # Instantiate Redcarpet::Markdown with HTMLblocks extension and given options.
  #
  # content - Markdown document to parse.
  def markdown(content)
    renderer = HTMLblocks.new(hard_wrap: true, filter_html: false)
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

  # Returns formated date, or default value.
  #
  # date - some date, which will be formated
  # default - returned value, if date doesn't exist.
  def year_or_default(date, default="nyní")
    return date.strftime("%Y") if date
    return default
  end

  # Returns "active" if request include given path, works for nesteds paths.
  #
  # path - path which will be tested.
  def active_page(path)
    "active" if request.url.include?(path)
  end
end
