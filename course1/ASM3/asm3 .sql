use sale_management;

create table employees(
    employee_id INT primary key,
    first_name varchar(50),
    last_name varchar(50),
    address text,
    phone_number varchar(12)
);

create table customers(
    customer_id INT primary key,
    first_name varchar(50),
    last_name varchar(50),
    phone_number varchar(12)
);

create table suppliers(
    supplier_id INT primary key,
    name varchar(50),
    phone_number varchar(12),
    address text
);


create table products(
    product_id INT primary key,
    name varchar(50),
    supplier_id INT,
    constraint product_supplier_fk foreign key (supplier_id) references suppliers(supplier_id)
);

create table price_list(
    product_id INT,
    unit varchar(50),
    selling_price DECIMAL(13, 4),
    perchase_price DECIMAL(13, 4),
    constraint price_list_pk primary key (product_id,unit),
    constraint price_list_product_id_fk foreign key (product_id) references products(product_id)
);

create table orders(
    order_id INT primary key,
    time datetime,
    total_cost DECIMAL(13, 4),
    customer_id INT,
    employee_id INT,
    constraint order_customer_fk foreign key (customer_id) references customers(customer_id),
    constraint order_employee_fk foreign key (employee_id) references employees(employee_id)
);

create table orderlines(
    orderline_id INT primary key,
    order_id int,
    product_id int,
    quantity_id int,
    unit varchar(50),
    constraint orderline_order_fk foreign key (order_id) references orders(order_id),
    constraint orderline_orderline_fk foreign key (product_id,unit) references price_list(product_id,unit)
);

create table order_supplier(
    order_supplier_id int primary key,
    time datetime,
    total_cost decimal(13,4),
    supplier_id int,
    employee_id int,
    constraint order_supplier_supplier_id_fk foreign key (supplier_id) references suppliers(supplier_id),
    constraint order_supplier_employee_fk foreign key (employee_id) references employees(employee_id)
);


create table orderline_supplier(
    oredrline_supplier_id int primary key,
    order_supplier_id int,
    product_id int,
    unit varchar(50),
    quantity varchar(50),
    constraint orderline_supplier_order_supplier_fk foreign key (order_supplier_id) references order_supplier(order_supplier_id),
    constraint orderline_supplier_price_list_fk foreign key (product_id,unit) references price_list(product_id,unit)
);

create table user_login(
    employee_id int primary key,
    encrypt_username varchar(100),
    encrypt_password varchar(100),
    constraint user_login_employee_fk foreign key (employee_id) references employees(employee_id)
);

