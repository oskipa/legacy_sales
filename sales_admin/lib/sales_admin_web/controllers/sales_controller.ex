defmodule SalesAdminWeb.SalesController do
  use SalesAdminWeb, :controller
  import Ecto.Query

  def index(conn, _params) do
    render(conn, "index.html", total: get_total(), sales: get_legacy_sales())
  end

  defp get_legacy_sales() do
    q = from s in "legacy_view",
        select: [s.customer_name, s.item_description, s.item_price, s.quantity,
                 s.merchant_name, s.merchant_address]

    case SalesAdmin.Repo.all(q) do
      nil -> []
      result -> result
    end
  end

  defp get_total() do
    q = from o in SalesAdmin.OrderItem,
        select: sum(o.price * o.quantity)

    case SalesAdmin.Repo.one(q) do
      nil -> 0.0
      total -> total
    end
  end

  def legacy_import(conn, _params) do
    legacy_import = SalesAdmin.LegacyImport.changeset(%SalesAdmin.LegacyImport{})
    render(conn, "legacy_import.html", changeset: legacy_import)
  end

  def process_legacy_import(conn, params) do
      legacy_import = SalesAdmin.LegacyImport.changeset(%SalesAdmin.LegacyImport{})

    if upload = params["legacy_import"]["file_name"] do
      IO.inspect(upload)
      case SalesAdmin.LegacyImport.import(upload.path) do
        true ->
           redirect(conn, to: "/sales")
        {:error, message} -> 
          render(conn, "legacy_import.html", changeset: legacy_import, message: message)
      end
    else
      render(conn, "legacy_import.html", changeset: legacy_import, message: "You need to select a file.")
    end
  end

end
