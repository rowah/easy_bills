defmodule EasyBills.Emails.ResetPasswordInstructions do
  @moduledoc false

  @template_path Path.join([__DIR__, "reset_password_instructions.mjml"])
  @external_resource @template_path

  require EEx

  alias EasyBills.Emails

  rendered_mjml = Emails.generate_template(@template_path)
  EEx.function_from_string(:def, :render, rendered_mjml, [:assigns])
end
