defmodule SalesAdmin.Repo.Migrations.AddLegacyView do
  use Ecto.Migration

  def change do
    execute """
    CREATE VIEW legacy_view AS
    select  
    c.first || ' ' || c.last_name as customer_name, 
    p.name as item_description, 
    oi.price as item_price, 
    oi.quantity as quantity, 
    m.name as merchant_name, 
    a.address as merchant_address
    from orders as o
    join order_items as oi on o.id = oi.order_id
    join customers as c on o.customer_id = c.id
    join products as p on oi.product_id = p.id
    join merchants as m on m.id = o.merchant_id
    join addresses as a on a.id = m.address_id;
    """
  end
end
