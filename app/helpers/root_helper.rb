#
module RootHelper
  def sequence_field_tag(name, value, template = false)
    html_class = ['mar-l-1em', 'mar-b-small']
    html_class << 'template' if template
    content_tag(:div, class: html_class.join(' ')) do
      concat text_field_tag(name, value,
                            disabled: template,
                            'data-validation' => 'atcg codon',
                            'data-validation-optional' => 'true')
      concat '&nbsp;'.html_safe
      concat \
        content_tag(:a, '&#xf068;'.html_safe,
                    class: 'fa remove_prev',
                    title: 'Remove',
                    alt: 'Remove',
                    href: 'javascript:void(0)')
    end
  end
end
