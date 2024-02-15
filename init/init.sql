insert into location_locationdestination (display_txt, addr_txt)
	values ('San Francisco', '1234 Market St'),
	('San Jose', '5678 Market St'),
	('Daly City', '9101 Market St');

insert into location_locationstop (location_id, stop_dt, hours_txt)
	values (1, '2021-01-01', '11:00 AM - 9:00 PM');

insert into menu_menusection (display_txt, desc_txt, raw_disclaimer)
	values ('Sushi Rolls', 'Served with sides of Wasabi, ginger and soy sauce.', 1),
	('Combo Meal', 'All combo is served with fried rice/steamed rice, pancit (rice noodles), and 2 pcs of lumpia (eggrolls)', 0),
	('Meal', '', 0),
	('Sides', '', 0),
	('Additional', '', 0);

insert into menu_menuitem (section_id, display_txt, price, desc_txt, raw_disclaimer)
	values (1, 'California Roll', 7.25, 'Crab, avocado, cucumber, cream cheese', 0),
	(1, 'Spicy Tuna Roll', 11.75, 'Fresh tuna, cucumber, spicy mayo', 0),
	(1, 'Pinoy 2020 Roll', 13.95, 'Crab, avocado, cream cheese, tempura shrimp, fresh tuna on top drizzled with spicy mayo', 0),
	(1, 'Firecracker Roll', 8.50, 'Crabstick, cream cheese, avocado, spicy mayo, deep fried and drizzled with unagi sauce on top', 0),
	(1, 'Coconut Roll', 11.75, 'Smoked salmon, avocado, deep fried then drizzled with unagi sauce', 0),
	(1, 'Salmon Roll', 11.75, 'Cream cheese, avocado, fresh salmon, then fresh salmon on top', 0),
	(1, 'Tuna Salmon Roll', 11.75, 'Cream cheese, avocado, fresh tuna, salmon, cucumber', 0),
	(1, 'Sushi Combo', 15.95, 'Half spicy tuna, 2 slices of tuna, 2 slices of salmon', 0),
	(1, 'Rainbow Roll', 14.44, 'Crab, cucumber, cream cheese, avocado, top with slices avocado, salmon and tuna', 0),
	(2, 'Pork Adobo Combo', 12.99, 'Pork cooked with soy sauce and vinegar', 0),
	(2, 'Chicken Teriyaki Combo', 12.99, 'Grilled chicken with teriyaki sauce', 0),
	(2, 'Pork BBQ Skewers Combo', 12.99, '2 pcs of pork BBQ skewers', 0),
	(2, 'Shrimp Tempura Combo', 12.99, '4 pcs of shrimp tempura fried. Side of spicy mayo', 0),
	(2, 'Cod Tempura Combo', 12.99, '3 pcs cod tempura fried. Side of spicy mayo', 0),
	(3, 'Sushi Burrito', 14.44, 'Salmon, tuna, crab, pickled red cabbage, carrots, cucumber, avocado, spicy mayo, and special secret sauce', 1),
	(3, 'Crispy Fried Pork', 12.99, 'Panko fried pork serves with salad, and fried or steamed rice', 0),
	(4, 'Barbecue', 5.75, '2 pcs', 0),
	(4, 'Pancit', 3.99, 'Chicken, cabbage, carrots, and rice noodles', 0),
	(4, 'Lumpia', 3.99, '2 pcs (eggrolls) (pork and veggies)', 0),
	(4, 'Rice', 1.75, 'Steamed rice', 0),
	(4, 'Fried Rice', 2.50, 'Chicken with veggies', 0),
	(4, 'Adobo', 5.75, 'Chicken cooked in soy sauce, vinegar', 0),
	(5, 'Soy Paper', 0.25, '', 0),
	(5, 'Spicy Mayo', 0.25, '', 0);
