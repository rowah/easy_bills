defmodule EasyBills.Emails do
  @moduledoc """
  Generate MJML templates
  """

  use Swoosh.Mailer, otp_app: :easy_bills

  import Swoosh.Email
  alias EasyBills.Emails.ConfirmationInstructions
  alias EasyBills.Emails.ResetPasswordInstructions
  alias EasyBills.Emails.UpdateEmailInstructions

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

  def reset_password_instructions(user, url) do
    rendered_email =
      ResetPasswordInstructions.render(
        name: user.name,
        username: user.username,
        confirmation_url: url
      )

    new()
    |> to(user.email)
    |> from({"Accounts Management Team", "admin@easy-bills.com"})
    |> subject("Reset password instructions")
    |> html_body(rendered_email)
    |> text_body("""
    Hi #{user.name} #{user.username},

    You can reset your password by visiting the URL below:

    #{url}

    # If you didn't request this change, please ignore this.
    """)
    |> deliver()
  end

  def update_email_instructions(user, url) do
    rendered_email =
      UpdateEmailInstructions.render(
        name: user.name,
        username: user.username,
        confirmation_url: url
      )

    new()
    |> to(user.email)
    |> from({"Accounts Management Team", "admin@easy-bills.com"})
    |> subject("Update email instructions")
    |> html_body(rendered_email)
    |> text_body("""
    Hi #{user.name} #{user.username},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.
    """)
    |> deliver()
  end

  @spec generate_template(
          binary()
          | maybe_improper_list(
              binary() | maybe_improper_list(any(), binary() | []) | char(),
              binary() | []
            )
        ) :: binary()
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
