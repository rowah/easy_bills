defmodule EasyBills.Emails.UpdateEmailInstructions do
  @moduledoc false

  @template_path Path.join([__DIR__, "update_email_instructions.mjml"])
  @external_resource @template_path

  require EEx

  alias EasyBills.Emails

  rendered_mjml = Emails.generate_template(@template_path)
  EEx.function_from_string(:def, :render, rendered_mjml, [:assigns])
end
