-- query to fetch all the orders
select
	customer_order.order_id,
	customer_order.created_at as ordered_at,
	customer.customer_id,
	customer."name",
	customer.email,
	customer.phone_number,
	json_build_object(
		'address_id',
		address.address_id,
		'line1',
		address.line1,
		'line2',
		address.line2,
		'pincode',
		address.pincode,
		'city',
		address.city,
		'state',
		address.state
	) as address,
	json_agg(
		json_build_object(
			'product_id',
			product.product_id,
			'name',
			product."name",
			'description',
			product.description,
			'quantity',
			order_item.quantity
		)
	) as products
from
	customer_order
	inner join customer on customer_order.customer_id = customer.customer_id
	inner join address on customer_order.shipping_address_id = address.address_id
	inner join order_item on customer_order.order_id = order_item.order_id
	inner join product on order_item.product_id = product.product_id
group by
	customer_order.order_id,
	customer.customer_id,
	address.address_id;

-- queries to fetch the records from multiple tables and put it in order details view
with order_details_out as (
	select
		customer_order.order_id,
		customer_order.created_at as ordered_at,
		customer.customer_id,
		customer."name",
		customer.email,
		customer.phone_number,
		json_build_object(
			'address_id',
			address.address_id,
			'line1',
			address.line1,
			'line2',
			address.line2,
			'pincode',
			address.pincode,
			'city',
			address.city,
			'state',
			address.state
		) as address,
		json_agg(
			json_build_object(
				'product_id',
				product.product_id,
				'name',
				product."name",
				'description',
				product.description,
				'quantity',
				order_item.quantity
			)
		) as products
	from
		customer_order
		inner join customer on customer_order.customer_id = customer.customer_id
		inner join address on customer_order.shipping_address_id = address.address_id
		inner join order_item on customer_order.order_id = order_item.order_id
		inner join product on order_item.product_id = product.product_id
	group by
		customer_order.order_id,
		customer.customer_id,
		address.address_id
)
insert into
	order_details_view (
		order_id,
		ordered_at,
		customer_id,
		customer_name,
		email,
		phone_number,
		address,
		products
	)
select
	order_id,
	ordered_at,
	customer_id,
	name,
	email,
	phone_number,
	address,
	products
from
	order_details_out;