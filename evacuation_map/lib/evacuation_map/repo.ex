defmodule EvacuationMap.Repo do
  use Ecto.Repo,
    otp_app: :evacuation_map,
    adapter: Ecto.Adapters.Postgres
end
