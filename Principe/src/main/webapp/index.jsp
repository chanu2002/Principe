<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Principe Grand Colombo</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap');
        *{margin:0; padding:0; box-sizing:border-box;}
        body{font-family:'Poppins',sans-serif;background:#f8f8f8; color:#333;}

        /* HEADER STAYS SAME */
        .top-header{
            position:relative;
            background: url('https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1600&q=80') center/cover no-repeat;
            height:230px;color:white;animation:fadeIn 1.2s ease-in-out;
        }
        .overlay{background:linear-gradient(to bottom, rgba(0,0,0,0.75), rgba(0,0,0,0.55));height:100%;padding:25px 80px;display:flex;flex-direction:column;justify-content:space-between;}
        .header-top-row{display:flex;justify-content:space-between;align-items:center;font-size:14px;animation:slideDown 1s ease;}
        .header-top-row strong{font-size:18px;letter-spacing:2px;}
        .header-top-row div:last-child{backdrop-filter:blur(8px);background:rgba(255,255,255,0.06);padding:8px 18px;border-radius:30px;}
        .header-top-row a{color:white;text-decoration:none;margin-left:20px;font-weight:500;position:relative;transition:0.3s;}
        .header-top-row a::after{content:"";position:absolute;width:0%;height:2px;bottom:-4px;left:0;background:#ffd700;transition:0.4s;}
        .header-top-row a:hover::after{width:100%;}
        .header-top-row a:hover{color:#ffd700;}
        .book-btn{background:linear-gradient(45deg,#ffd700,#e6c200);color:black !important;padding:8px 18px;border-radius:30px;font-weight:600;transition:0.3s ease;}
        .book-btn:hover{transform:translateY(-3px);box-shadow:0 8px 20px rgba(255,215,0,0.4);}
        .brand-center{text-align:center;animation:fadeUp 1.5s ease;}
        .brand-center h1{font-family:'Playfair Display', serif;font-size:42px;letter-spacing:4px;background:linear-gradient(to right,#ffd700,#fff,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
        .brand-center span{font-size:18px;letter-spacing:3px;color:#f5e6c8;}
        .nav-menu{display:flex;justify-content:center;gap:35px;font-size:14px;animation:fadeUp 1.8s ease;}
        .nav-menu a{color:white;text-decoration:none;font-weight:500;position:relative;padding-bottom:5px;transition:0.3s;}
        .nav-menu a::after{content:"";position:absolute;width:0%;height:2px;bottom:0;left:0;background:#ffd700;transition:0.4s ease;}
        .nav-menu a:hover::after{width:100%;}
        .nav-menu a:hover{color:#ffd700;}

        /* ANIMATIONS */
        @keyframes fadeIn{from{opacity:0;}to{opacity:1;}}
        @keyframes slideDown{from{transform:translateY(-30px); opacity:0;}to{transform:translateY(0); opacity:1;}}
        @keyframes fadeUp{from{transform:translateY(30px); opacity:0;}to{transform:translateY(0); opacity:1;}}

        /* SECTIONS */
        h2{text-align:center;font-size:32px;margin-top:50px;margin-bottom:20px;color:#222;}
        p{text-align:center;max-width:900px;margin:auto;color:#555;line-height:1.6;}
        .section{padding:60px 20px;}
        .image-row{display:flex;justify-content:center;gap:30px;flex-wrap:wrap;margin-top:40px;}
        .image-card{width:300px;background:white;border-radius:10px;overflow:hidden;box-shadow:0 5px 20px rgba(0,0,0,0.1);transition:0.4s;}
        .image-card:hover{transform:translateY(-10px);}
        .image-card img{width:100%;height:200px;object-fit:cover;}
        .image-card h3{text-align:center;padding:15px;margin:0;}
        .cta-section{background:url('https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=1600&q=80') center/cover no-repeat;color:white;text-align:center;padding:100px 20px;}
        .cta-section h2{color:white;font-size:36px;}
        .cta-btn{display:inline-block;margin-top:20px;padding:12px 30px;background:gold;color:black;font-weight:bold;text-decoration:none;border-radius:30px;transition:0.3s;}
        .cta-btn:hover{background:#e6c200;}

        /* ADDITIONAL SECTIONS */
        .amenities-row{display:flex;justify-content:center;gap:30px;flex-wrap:wrap;margin-top:40px;}
        .amenity-card{width:250px;text-align:center;background:white;border-radius:10px;padding:25px;box-shadow:0 5px 15px rgba(0,0,0,0.1);transition:0.3s;}
        .amenity-card:hover{transform:translateY(-8px);}
        .amenity-card i{font-size:36px;color:#ffd700;margin-bottom:15px;display:block;}
        .testimonial-card{width:300px;background:white;border-radius:10px;padding:25px;margin:15px;box-shadow:0 5px 15px rgba(0,0,0,0.1);transition:0.3s;}
        .testimonial-card p{font-style:italic;color:#555;}
        .testimonial-card h4{margin-top:15px;color:#222;}
        footer{background:#222;color:#fff;padding:60px 20px;text-align:center;}
        footer a{color:#ffd700;text-decoration:none;margin:0 10px;}
        footer a:hover{color:white;}
        @media (max-width:768px){.image-row,.amenities-row{flex-direction:column;align-items:center;}}
    </style>
</head>
<body>

<!-- HEADER (KEEP AS IS) -->
<div class="top-header">
    <div class="overlay">
        <div class="header-top-row">
            <div><strong>PRINCIPE</strong></div>
            <div>
                <a href="views/adminLogin.jsp">Admin Login</a>
                <a href="views/register.jsp">Register</a>
                <a href="views/login.jsp" class="book-btn">BOOK NOW</a>
            </div>
        </div>
        <div class="brand-center">
            <h1>Principe</h1>
            <span>GRAND COLOMBO</span>
        </div>
        <div class="nav-menu">
            <a href="views/UserPages/RoomsSuite.jsp">ROOMS & SUITES</a>
            <a href="views/UserPages/Dining.jsp">DINING</a>
            <a href="views/UserPages/Experience.jsp">EXPERIENCES</a>
            <a href="views/UserPages/Offers.jsp">OFFERS</a>
            <a href="views/UserPages/Gallery.jsp">GALLERY</a>
            <a href="views/UserPages/Esg.jsp">ESG</a>
        </div>
    </div>
</div>

<!-- Welcome Section -->
<div class="section">
    <h2>Welcome to Principe Grand Colombo</h2>
    <p>Experience luxury, comfort, and world-class hospitality in the heart of Colombo.
       Principe Grand Colombo offers premium rooms, fine dining, relaxing spa treatments,
       and breathtaking city views designed to create unforgettable memories.</p>
</div>

<!-- Rooms & Suites -->
<div class="section">
    <h2>Our Luxury Rooms & Suites</h2>
    <div class="image-row">
        <div class="image-card">
           <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=800&q=80" alt="Deluxe Room">
            <h3>Deluxe Room</h3>
        </div>
        <div class="image-card">
            <img src="https://images.unsplash.com/photo-1578898887932-dce23a595ad4?auto=format&fit=crop&w=800&q=80" alt="Executive Suite">
            <h3>Executive Suite</h3>
        </div>
        <div class="image-card">
            <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=800&q=80" alt="Presidential Suite">
            <h3>Presidential Suite</h3>
        </div>
    </div>
</div>

<!-- Dining -->
<div class="section" style="background:#ffffff;">
    <h2>Fine Dining Experience</h2>
    <p>Enjoy international cuisine prepared by award-winning chefs.
       From romantic dinners to family gatherings, our restaurants provide
       an unforgettable culinary journey.</p>
    <div class="image-row">
        <div class="image-card">
            <img src="https://images.unsplash.com/photo-1559339352-11d035aa65de?auto=format&fit=crop&w=800&q=80" alt="Luxury Restaurant">
            <h3>Luxury Restaurant</h3>
        </div>
        <div class="image-card">
            <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=800&q=80" alt="International Buffet">
            <h3>International Buffet</h3>
        </div>
    </div>
</div>

<!-- About Us -->
<div class="section" style="background:#f5f5f5;">
    <h2>About Principe Grand Colombo</h2>
    <p>Principe Grand Colombo has been the benchmark for luxury hospitality in Sri Lanka, blending modern elegance with rich cultural heritage.
       Our mission is to provide personalized experiences for every guest, from business travelers to families seeking leisure.</p>
</div>

<!-- Amenities -->
<div class="section">
    <h2>Exclusive Amenities</h2>
    <div class="amenities-row">
        <div class="amenity-card">
            <i class="fas fa-spa"></i>
            <h3>Spa & Wellness</h3>
            <p>Relax and rejuvenate with our premium spa treatments and wellness programs.</p>
        </div>
        <div class="amenity-card">
            <i class="fas fa-swimming-pool"></i>
            <h3>Infinity Pool</h3>
            <p>Enjoy breathtaking city views from our rooftop infinity pool.</p>
        </div>
        <div class="amenity-card">
            <i class="fas fa-dumbbell"></i>
            <h3>Fitness Center</h3>
            <p>State-of-the-art gym and personal trainers for your health and wellness.</p>
        </div>
        <div class="amenity-card">
            <i class="fas fa-concierge-bell"></i>
            <h3>Concierge Services</h3>
            <p>24/7 assistance for bookings, travel plans, and special arrangements.</p>
        </div>
    </div>
</div>

<!-- Spa & Wellness -->
<div class="section" style="background:#f5f5f5;">
    <h2>Spa & Wellness</h2>
    <p>Indulge in a holistic experience with our spa therapies designed to relax body and mind.
       Signature massages, aromatherapy, and rejuvenating treatments await.</p>
    <div class="image-row">
        <div class="image-card">
            <img src="https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=800&q=80" alt="Spa Treatment">
            <h3>Spa Treatment</h3>
        </div>
        <div class="image-card">
            <img src="https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=800&q=80" alt="Yoga Room">
            <h3>Yoga & Meditation</h3>
        </div>
    </div>
</div>

<!-- Events & Meetings -->
<div class="section">
    <h2>Events & Meetings</h2>
    <p>Host corporate events, weddings, and private gatherings in our elegant ballrooms and meeting spaces
       equipped with the latest technology and personalized services.</p>
    <div class="image-row">
        <div class="image-card">
            <img src="https://images.unsplash.com/photo-1552566626-52f8b828add9?auto=format&fit=crop&w=800&q=80" alt="Conference Room">
            <h3>Conference Halls</h3>
        </div>
        <div class="image-card">
            <img src="https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80" alt="Wedding Hall">
            <h3>Wedding Venues</h3>
        </div>
    </div>
</div>

<!-- Testimonials -->
<div class="section" style="background:#f5f5f5;">
    <h2>Guest Testimonials</h2>
    <div class="image-row">
        <div class="testimonial-card">
            <p>"An unforgettable stay! The staff was exceptional and the rooms were luxurious and spotless."</p>
            <h4>- John Doe</h4>
        </div>
        <div class="testimonial-card">
            <p>"Amazing dining experience with top-notch services. Highly recommend Principe Grand Colombo."</p>
            <h4>- Sarah Smith</h4>
        </div>
        <div class="testimonial-card">
            <p>"The spa and wellness center made our vacation extremely relaxing. Perfect city view!"</p>
            <h4>- Michael Lee</h4>
        </div>
    </div>
</div>

<!-- CTA -->
<div class="cta-section">
    <h2>Book Your Stay Today</h2>
    <p>Enjoy exclusive offers and premium services at Principe Grand Colombo.</p>
    <a href="views/login.jsp" class="cta-btn">BOOK NOW</a>
</div>

<!-- Footer -->
<footer>
    <p>&copy; 2026 Principe Grand Colombo. All Rights Reserved.</p>
    <p>
        <a href="#">Privacy Policy</a> | 
        <a href="#">Terms of Service</a> | 
        <a href="#">Contact Us</a>
    </p>
    <p>Follow Us:
        <a href="#"><i class="fab fa-facebook-f"></i></a>
        <a href="#"><i class="fab fa-instagram"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
    </p>
</footer>

<!-- FontAwesome -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>