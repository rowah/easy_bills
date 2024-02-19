defmodule EasyBills.Emails do
  @moduledoc """
  Generate MJML templates
  """

  use Swoosh.Mailer, otp_app: :easy_bills

  import Swoosh.Email
  alias EasyBills.Emails.ConfirmationInstructions

  def confirmation_instructions(user, url) do
    rendered_email =
      ConfirmationInstructions.render(
        name: user.name,
        username: user.username,
        confirmation_url: url,
        tier: "Platinum"
      )

    new()
    |> to(user.email)
    |> from({"Onboarding Team", "welcome@easy-bills.com"})
    |> subject("Welcome to EasyBills!")
    |> html_body(rendered_email)
    |> text_body("""
    Hi #{user.name} #{user.username},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.
    """)
    |> deliver()
  end

  def generate_template(file_path) do
    {:ok, template} =
      file_path
      |> File.read!()
      |> Mjml.to_html()

    ~r/{{\s*([^}^\s]+)\s*}}/
    |> Regex.replace(template, fn _, variable_name ->
      "<%= @#{variable_name} %>"
    end)
  end
end
