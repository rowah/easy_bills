defmodule EasyBillsWeb.PageHTML do
  use EasyBillsWeb, :html

  alias EasyBillsWeb.CoreComponents
  alias EasyBillsWeb.OnboardingLive.Shared.RegularTemplate

  embed_templates "page_html/*"
end
