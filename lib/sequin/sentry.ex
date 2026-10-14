defmodule Sequin.Sentry do
  @moduledoc false
  def init do
    cond do
      System.get_env("CRASH_REPORTING_DISABLED") in ~w(true 1) ->
        Sentry.put_config(:dsn, nil)

      # Crash reporting is opt-in: only enabled when SENTRY_DSN is set at build time
      is_nil(Application.get_env(:sentry, :dsn)) ->
        :ok

      true ->
        :logger.add_handler(:sentry_handler, Sentry.LoggerHandler, %{})
    end
  end
end
