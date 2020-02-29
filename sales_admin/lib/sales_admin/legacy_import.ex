defmodule SalesAdmin.LegacyImport do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias NimbleCSV.RFC4180, as: CSV

  @headers %{
    "Customer Name"    => 0, 
    "Item Description" => 1, 
    "Item Price"       => 2, 
    "Quantity"         => 3, 
    "Merchant Name"    => 4, 
    "Merchant Address" => 5
  }

  schema("legacy_imports") do
    field :file_name, :string
  end

  def changeset(legacy_import, params \\ %{}) do
    legacy_import
    |> cast(params, [:file_name])
    |> validate_required([:file_name])
  end

  def import(file) do
    case parse_csv(file) do 
      {:ok, content}  -> 
        [header | data] = content
        if validate_header(header) do
          data 
          |> Enum.map(fn row -> process(row) end)
          |> Enum.all?(fn x -> x == true end)
        else
          {:error, "Invalid header. Please include correct headers in the right order"}
        end
      {:error, message}  -> 
        {:error, message}
    end
  end

  defp parse_csv(path) do
    case File.read(path) do
      {:ok, content} ->
        result = content
                 |> CSV.parse_string(skip_headers: false)
        {:ok, result}
      {:error, reason} ->
        {:error, reason}
      _ ->
        raise("LegacyImporter: serious error  while parsing csv data")
    end
  end

  defp validate_header(header) do
    Enum.sort(header) == Enum.sort(Map.keys(@headers))
  end

  defp process(row) do
    try do
    customer  = get_customer(row) 
    merchant  = get_merchant(row) 
    product   = get_product(row) 
    quantity  = Enum.at(row, @headers["Quantity"])

    create_order(customer, merchant, product, quantity, row) 

    rescue 
      e in RuntimeError -> {:error, Exception.message(e) }
    end
  end

  defp get_customer(row) do
    name = get_name(Enum.at(row, @headers["Customer Name"]))

    q = from SalesAdmin.Customer, 
      where: [first: ^name.first], 
      where: [last_name: ^name.last_name],
      select: [:id]
    
    case SalesAdmin.Repo.one(q) do
      nil -> create_customer(name)
      customer -> customer.id
    end
  end

  defp create_customer(name) do 
    changeset = SalesAdmin.Customer.changeset(%SalesAdmin.Customer{}, name) 
    case SalesAdmin.Repo.insert(changeset) do
      {:ok, customer} -> customer.id
      {:error, _message} -> raise "Cannot create Customer"
    end
  end

  defp get_name(full_name) do
    case String.split(full_name, " ") do
      [first, middle, last] -> %{first: first, middle_name: middle, last_name: last}
      [first, last] -> %{first: first, middle_name: "", last_name: last}
    end
  end
 
  defp get_merchant(row) do
    name = Enum.at(row, @headers["Merchant Name"])

    q = from SalesAdmin.Merchant, 
      where: [name: ^name] 
    
    case SalesAdmin.Repo.one(q) do
      nil -> create_merchant(name, row)
      merchant -> merchant.id
    end
  end
  
  defp create_merchant(name, row) do 
    address = Enum.at(row, @headers["Merchant Name"])
    address_id = get_address(address)
  
    changeset = SalesAdmin.Merchant.changeset(%SalesAdmin.Merchant{}, %{name: name, address_id: address_id}) 
    case SalesAdmin.Repo.insert(changeset) do
      {:ok, merchant} -> merchant.id
      {:error, _message} -> raise "Cannot create Merchant"
    end
  end

  defp get_address(address) do
    q = from SalesAdmin.Address, 
      where: [address: ^address] 
    
    case SalesAdmin.Repo.one(q) do
      nil -> create_address(address)
      address -> address.id
    end
  end
  
  defp create_address(address_input) do 
    changeset = SalesAdmin.Address.changeset(%SalesAdmin.Address{}, %{address: address_input}) 
    case SalesAdmin.Repo.insert(changeset) do
      {:ok, address} -> address.id
      {:error, _message} -> raise "Cannot create Address"
    end
  end

  defp get_product(row) do
    name = Enum.at(row, @headers["Item Description"])
    price = Enum.at(row, @headers["Item Price"])

    q = from SalesAdmin.Product, 
      where: [name: ^name], 
      select: [:id]
    
    case SalesAdmin.Repo.one(q) do
      nil -> create_product(name, price)
      product -> product.id
    end
  end
  
  defp create_product(name, price) do 
    changeset = SalesAdmin.Product.changeset(%SalesAdmin.Product{}, %{name: name, unit_price: price}) 
    case SalesAdmin.Repo.insert(changeset) do
      {:ok, product} -> product.id
      {:error, message} -> raise "Cannot create Product: #{message}"
    end
  end

  defp create_order(customer, merchant, product, quantity, _row) do

    SalesAdmin.Repo.transaction(fn -> 
      order_changeset = SalesAdmin.Order.changeset(%SalesAdmin.Order{}, %{customer_id: customer, merchant_id: merchant})

      order = SalesAdmin.Repo.insert!(order_changeset)

      item_changeset = SalesAdmin.OrderItem.changeset(%SalesAdmin.OrderItem{}, %{order_id: order.id, product_id: product, price: get_price(product) , quantity: quantity})
      item = SalesAdmin.Repo.insert!(item_changeset) 
    end)

    true
  end

  defp get_price(product) do
    q = from SalesAdmin.Product,
      where: [id: ^product],
      select: [:unit_price]

    case SalesAdmin.Repo.one(q) do
      product -> product.unit_price
      nil -> raise "Cannot find Product and get its price"
    end
  end
end
