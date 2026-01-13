# Vehicle Rental System Assignment

## Project Overview
এই প্রজেক্টটি একটি সরল Vehicle Rental System ডাটাবেস। এতে তিনটি প্রধান টেবিল রয়েছে:
- Users
- Vehicles
- Bookings

Users টেবিলে ব্যবহারকারীদের তথ্য রাখা হয় (customer অথবা admin)।  
Vehicles টেবিলে ভাড়া দেওয়ার জন্য গাড়ি বা বাইকের তথ্য সংরক্ষণ করা হয়।  
Bookings টেবিল ব্যবহার করে কোন user কোন vehicle কতদিনের জন্য ভাড়া নিয়েছে তা ট্র্যাক করা হয়।

নিরাপত্তার জন্য Users table-এ password সংরক্ষণ করা হলেও SELECT query output-এ password দেখানো হয় না।

---

## ERD Diagram
ERD Diagram Public Link:  
https://drive.google.com/file/d/1PtyThvVizuHrSZLo7gbSRrH0zkduy9UB/view

### ERD Relationships
- Users ↔ Bookings : One-to-Many  
- Vehicles ↔ Bookings : One-to-Many  
- Bookings table-এ `user_id` এবং `vehicle_id` Foreign Key হিসেবে ব্যবহৃত হয়েছে

---

## SQL Queries
সব SQL query `queries.sql` ফাইলে সংযুক্ত করা হয়েছে।

নিচের query গুলোর output এর screenshot আলাদা image file হিসেবে সংযুক্ত করা হয়েছে:

### Included Queries
- JOIN Query (Booking তথ্য সহ User এবং Vehicle)
- NOT EXISTS Query (যেসব vehicle কখনো booking হয়নি)
- WHERE Condition Query (available car গুলো)
- GROUP BY + HAVING Query (একাধিক booking হয়েছে এমন vehicle)
- Users Table Output (password hidden)

---

## Screenshots
- join_query.png  
- not_exists_query.png  
- where_query.png  
- group_by_query.png  
- users_table.png  


Part-3: Theory Questions এর রেকর্ড লিঙ্ক Record ফোল্ডারে সংযুক্ত করা হয়েছে।