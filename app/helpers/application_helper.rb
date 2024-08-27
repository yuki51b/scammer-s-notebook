# frozen_string_literal: true

module ApplicationHelper
  include MarkdownHelper

  def flash_background_color(type)
    case type.to_sym
    when :notice then 'bg-green-500'
    when :alert  then 'bg-red-500'
    when :error  then 'bg-yellow-500'
    else 'bg-gray-500'
    end
  end

  def page_title(title = '', admin: false)
    base_title = admin ? '詐欺師の手帳(管理者)' : '詐欺師の手帳'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def default_meta_tags
    {
      site: '詐欺師の手帳',
      title: '詐欺師の手帳',
      reverse: true,
      charset: 'utf-8',
      description: '詐欺被害の未然防止を目的としたアプリです',
      canonical: request.original_url,
      og: {
        site_name: '詐欺師の手帳',
        title: '詐欺師の手帳',
        description: '詐欺被害の未然防止を目的としたアプリです',
        type: 'website',
        url: request.original_url,
        image: image_url('default_share.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@https://x.com/yukimura877',
        image: image_url('default_share.png')
      }
    }
  end
end
