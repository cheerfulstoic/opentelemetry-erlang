defmodule OpenTelemetryAPIExperimental.Counter do
  @moduledoc """

  """

  defmacro create(name, opts) do
    quote bind_quoted: [name: name, opts: opts] do
      :otel_meter.create_counter(
        :opentelemetry_experimental.get_meter(:opentelemetry.get_application_scope(__MODULE__)),
        name,
        opts
      )
    end
  end

  defmacro add(name, number, attributes) do
    quote bind_quoted: [name: name, number: number, attributes: attributes] do
      {_meter_module, meter} = :opentelemetry_experimental.get_meter(:opentelemetry.get_application_scope(__MODULE__))

      :otel_counter.add(
        OpenTelemetry.Ctx.get_current(),
        meter,
        name,
        number,
        attributes
      )
    end
  end
end
