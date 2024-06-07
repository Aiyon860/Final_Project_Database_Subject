BEGIN
FOR c IN (SELECT table_name FROM user_tables) LOOP
EXECUTE IMMEDIATE ('DROP TABLE "' || c.table_name || '" CASCADE CONSTRAINTS');
END LOOP;
END;

CREATE TABLE categories (
    category_id NUMBER PRIMARY KEY,
    category_name VARCHAR2(256) NOT NULL
);

CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(256) NOT NULL,
    phone_number VARCHAR2(32) NOT NULL,
    address VARCHAR2(512) NOT NULL
);

CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(256) NOT NULL,
    price NUMBER NOT NULL,
    amounts NUMBER NOT NULL,
    expired_date DATE
);

CREATE TABLE suppliers (
    supplier_id NUMBER PRIMARY KEY,
    name VARCHAR2(256) NOT NULL,
    address VARCHAR2(256) NOT NULL,
    phone_number VARCHAR2(32) NOT NULL
);

CREATE TABLE stores (
    store_id NUMBER PRIMARY KEY,
    address VARCHAR2(1024) NOT NULL
);

CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    name VARCHAR2(256) NOT NULL,
    age NUMBER NOT NULL,
    phone_number VARCHAR2(32),
    salary NUMBER NOT NULL,
    store_id NUMBER NOT NULL,
    CONSTRAINT fk_store_id FOREIGN KEY (store_id) REFERENCES stores (store_id) ON DELETE CASCADE
);

CREATE TABLE purchases (
    purchase_id NUMBER PRIMARY KEY,
    purchase_date DATE NOT NULL,
    supplier_id NUMBER NOT NULL,
    employee_id NUMBER NOT NULL,
    CONSTRAINT fk_supplier_id FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id) ON DELETE CASCADE,
    CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE
);

CREATE TABLE detail_purchases (
    detail_purchase_id NUMBER PRIMARY KEY,
    purchase_id NUMBER NOT NULL,
    product_id NUMBER NOT NULL,
    amounts NUMBER NOT NULL,
    detail_price NUMBER NOT NULL,
    CONSTRAINT fk_purchase_id FOREIGN KEY (purchase_id) REFERENCES purchases (purchase_id) ON DELETE CASCADE,
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
);

CREATE TABLE sells (
    sell_id NUMBER PRIMARY KEY,
    sell_date DATE NOT NULL,
    employee_id NUMBER NOT NULL,
    customer_id NUMBER NOT NULL,
    CONSTRAINT fk_employee_id2 FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE
);

CREATE TABLE detail_sells (
    detail_sell_id NUMBER PRIMARY KEY,
    sell_id NUMBER NOT NULL,
    product_id NUMBER NOT NULL,
    amounts NUMBER NOT NULL,
    detail_price NUMBER NOT NULL,
    CONSTRAINT fk_sell_id FOREIGN KEY (sell_id) REFERENCES sells (sell_id) ON DELETE CASCADE,
    CONSTRAINT fk_product_id2 FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
);

CREATE TABLE product_categories (
    product_category_id NUMBER PRIMARY KEY,
    product_id NUMBER NOT NULL,
    category_id NUMBER NOT NULL,
    CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE CASCADE,
    CONSTRAINT fk_product_id3 FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
);

CREATE TABLE store_products (
    store_product_id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    product_id NUMBER NOT NULL,
    CONSTRAINT fk_store_id2 FOREIGN KEY (store_id) REFERENCES stores (store_id) ON DELETE CASCADE,
    CONSTRAINT fk_product_id4 FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
);

INSERT INTO categories (category_id, category_name)
SELECT 1, 'Makanan' FROM DUAL
UNION ALL
SELECT 2, 'Minuman' FROM DUAL
UNION ALL
SELECT 3, 'Kebersihan' FROM DUAL
UNION ALL
SELECT 4, 'Sembako' FROM DUAL
UNION ALL
SELECT 5, 'Elektronik' FROM DUAL;

INSERT INTO customers (customer_id, name, phone_number, address)
SELECT 1, 'Fajar Hidayat', '086789012345', 'Jl. Sisingamangaraja No. 5, Semarang' FROM DUAL
UNION ALL
SELECT 2, 'Gita Permata', '087890123456', 'Jl. MT Haryono No. 8, Semarang' FROM DUAL
UNION ALL
SELECT 3, 'Hadi Pranowo', '088901234567', 'Jl. Jendral Sudirman No. 3, Semarang' FROM DUAL
UNION ALL
SELECT 4, 'Indah Sari', '089012345678', 'Jl. Pemuda No. 11, Semarang' FROM DUAL
UNION ALL
SELECT 5, 'Joko Widodo', '081012345679', 'Jl. Taman Siswa No. 2, Semarang' FROM DUAL;

INSERT INTO products (product_id, product_name, price, amounts, expired_date)
SELECT 1, 'Indomie Goreng', 3000, 50, TO_DATE('2024-12-31', 'YYYY-MM-DD') FROM DUAL
UNION ALL
SELECT 2, 'Teh Botol Sosro', 5000, 100, TO_DATE('2024-06-30', 'YYYY-MM-DD') FROM DUAL
UNION ALL
SELECT 3, 'Sabun Lifebuoy', 7000, 75, NULL FROM DUAL
UNION ALL
SELECT 4, 'Beras Cap Kepala', 12000, 200, NULL FROM DUAL
UNION ALL
SELECT 5, 'Minyak Goreng Bimoli', 14000, 150, NULL FROM DUAL;

INSERT INTO suppliers (supplier_id, name, address, phone_number)
SELECT 1, 'PT Sumber Rejeki', 'Jl. Ahmad Yani No. 20, Semarang', '024-1234567' FROM DUAL
UNION ALL
SELECT 2, 'CV Makmur Sejahtera', 'Jl. Pemuda No. 15, Semarang', '024-2345678' FROM DUAL
UNION ALL
SELECT 3, 'UD Tani Subur', 'Jl. Diponegoro No. 25, Semarang', '024-3456789' FROM DUAL
UNION ALL
SELECT 4, 'PT Agro Sentosa', 'Jl. Gajah Mada No. 30, Semarang', '024-4567890' FROM DUAL
UNION ALL
SELECT 5, 'CV Indo Pangan', 'Jl. Sisingamangaraja No. 10, Semarang', '024-5678901' FROM DUAL;

INSERT INTO stores (store_id, address)
SELECT 1, 'Jl. Pandanaran No. 50, Semarang' FROM DUAL
UNION ALL
SELECT 2, 'Jl. Simpang Lima No. 20, Semarang' FROM DUAL
UNION ALL
SELECT 3, 'Jl. Gajah Mada No. 15, Semarang' FROM DUAL
UNION ALL
SELECT 4, 'Jl. Ahmad Yani No. 10, Semarang' FROM DUAL
UNION ALL
SELECT 5, 'Jl. Diponegoro No. 7, Semarang' FROM DUAL;

INSERT INTO employees (employee_id, name, age, phone_number, salary, store_id)
SELECT 1, 'Andi Prasetyo', 25, '081234567890', 3000000, 1 FROM DUAL
UNION ALL
SELECT 2, 'Budi Santoso', 30, '082345678901', 3500000, 2 FROM DUAL
UNION ALL
SELECT 3, 'Citra Dewi', 28, '083456789012', 3200000, 3 FROM DUAL
UNION ALL
SELECT 4, 'Dewi Lestari', 35, '084567890123', 4000000, 4 FROM DUAL
UNION ALL
SELECT 5, 'Eko Susanto', 40, '085678901234', 4500000, 5 FROM DUAL;

INSERT INTO employees (employee_id, name, age, phone_number, salary, store_id)
SELECT 1, 'Andi Prasetyo', 25, '081234567890', 3000000, 1 FROM DUAL
UNION ALL
SELECT 2, 'Budi Santoso', 30, '082345678901', 3500000, 2 FROM DUAL
UNION ALL
SELECT 3, 'Citra Dewi', 28, '083456789012', 3200000, 3 FROM DUAL
UNION ALL
SELECT 4, 'Dewi Lestari', 35, '084567890123', 4000000, 4 FROM DUAL
UNION ALL
SELECT 5, 'Eko Susanto', 40, '085678901234', 4500000, 5 FROM DUAL;

INSERT INTO purchases (purchase_id, purchase_date, supplier_id, employee_id)
SELECT 1, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 1, 1 FROM DUAL
UNION ALL
SELECT 2, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 2, 2 FROM DUAL
UNION ALL
SELECT 3, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 3, 3 FROM DUAL
UNION ALL
SELECT 4, TO_DATE('2024-04-25', 'YYYY-MM-DD'), 4, 4 FROM DUAL
UNION ALL
SELECT 5, TO_DATE('2024-05-30', 'YYYY-MM-DD'), 5, 5 FROM DUAL;

INSERT INTO detail_purchases (detail_purchase_id, purchase_id, product_id, amounts, detail_price)
SELECT 1, 1, 1, 100, 300000 FROM DUAL
UNION ALL
SELECT 2, 2, 2, 200, 500000 FROM DUAL
UNION ALL
SELECT 3, 3, 3, 150, 700000 FROM DUAL
UNION ALL
SELECT 4, 4, 4, 250, 1200000 FROM DUAL
UNION ALL
SELECT 5, 5, 5, 300, 1400000 FROM DUAL;

INSERT INTO sells (sell_id, sell_date, employee_id, customer_id)
SELECT 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 1, 1 FROM DUAL
UNION ALL
SELECT 2, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 2, 2 FROM DUAL
UNION ALL
SELECT 3, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 3, 3 FROM DUAL
UNION ALL
SELECT 4, TO_DATE('2024-04-05', 'YYYY-MM-DD'), 4, 4 FROM DUAL
UNION ALL
SELECT 5, TO_DATE('2024-05-22', 'YYYY-MM-DD'), 5, 5 FROM DUAL;

INSERT INTO detail_sells (detail_sell_id, sell_id, product_id, amounts, detail_price)
SELECT 1, 1, 1, 5, 15000 FROM DUAL
UNION ALL
SELECT 2, 2, 2, 4, 20000 FROM DUAL
UNION ALL
SELECT 3, 3, 3, 3, 12000 FROM DUAL
UNION ALL
SELECT 4, 4, 4, 2, 18000 FROM DUAL
UNION ALL
SELECT 5, 5, 5, 1, 22000 FROM DUAL;

INSERT INTO product_categories (product_category_id, product_id, category_id)
SELECT 1, 1, 1 FROM DUAL
UNION ALL
SELECT 2, 2, 2 FROM DUAL
UNION ALL
SELECT 3, 3, 3 FROM DUAL
UNION ALL
SELECT 4, 4, 4 FROM DUAL
UNION ALL
SELECT 5, 5, 5 FROM DUAL;

INSERT INTO store_products (store_product_id, store_id, product_id)
SELECT 1, 1, 1 FROM DUAL
UNION ALL
SELECT 2, 2, 2 FROM DUAL
UNION ALL
SELECT 3, 3, 3 FROM DUAL
UNION ALL
SELECT 4, 4, 4 FROM DUAL
UNION ALL
SELECT 5, 5, 5 FROM DUAL;