<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dining - Principe Luxury Hotel</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family: Arial, Helvetica, sans-serif;
}

body{
    background-color:#f5f5f5;
    line-height:1.6;
}

/* Hero Section */
.hero{
    height:60vh;
    background-image:url('https://images.unsplash.com/photo-1414235077428-338989a2e8c0');
    background-size:cover;
    background-position:center;
    display:flex;
    justify-content:center;
    align-items:center;
    color:white;
    text-align:center;
}

.hero h1{
    font-size:50px;
    background:rgba(0,0,0,0.5);
    padding:20px 40px;
    border-radius:10px;
}

/* About Dining Section */
.about-section{
    padding:60px 100px;
    background:white;
    text-align:center;
}

.about-section h2{
    margin-bottom:20px;
    font-size:32px;
    color:#333;
}

.about-section p{
    color:#555;
    max-width:900px;
    margin:auto;
}

/* Dining Section */
.dining-section{
    padding:60px 80px;
}

.dining-section h2{
    text-align:center;
    margin-bottom:40px;
    font-size:32px;
    color:#333;
}

.dining-container{
    display:flex;
    justify-content:space-between;
    flex-wrap:wrap;
    gap:30px;
}

.dining-card{
    background:white;
    width:30%;
    border-radius:10px;
    overflow:hidden;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
    transition:0.3s;
}

.dining-card:hover{
    transform:translateY(-10px);
}

.dining-card img{
    width:100%;
    height:220px;
    object-fit:cover;
}

.dining-content{
    padding:20px;
}

.dining-content h3{
    margin-bottom:10px;
    color:#222;
}

.dining-content p{
    font-size:14px;
    color:#555;
    margin-bottom:10px;
}

/* Footer */
footer{
    text-align:center;
    padding:20px;
    background:#222;
    color:white;
    margin-top:50px;
}
</style>

</head>
<body>
<jsp:include page="/views/designs/header.jsp" />
<!-- Hero Section -->
<div class="hero">
    <h1>Fine Dining Experience</h1>
</div>

<!-- About Dining -->
<div class="about-section">
    <h2>Exceptional Culinary Experiences</h2>
    <p>
        At Principe Luxury Hotel, dining is more than just a meal — it is an experience.
        Our talented chefs craft exquisite dishes using the finest ingredients,
        combining international flavors with local culinary traditions. Whether you
        prefer elegant fine dining, casual meals, or refreshing beverages, our
        restaurants and lounges offer unforgettable moments in a sophisticated atmosphere.
    </p>
</div>

<!-- Dining Options -->
<div class="dining-section">
    <h2>Our Restaurants & Lounges</h2>

    <div class="dining-container">

        <!-- Fine Dining Restaurant -->
        <div class="dining-card">
            <img src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5" alt="Fine Dining Restaurant">
            <div class="dining-content">
                <h3>Royal Fine Dining</h3>
                <p>
                    Experience elegant dining in a luxurious setting. Our signature restaurant
                    offers gourmet international cuisine prepared by award-winning chefs.
                    Guests can enjoy carefully curated tasting menus, premium wines,
                    and impeccable service in a refined atmosphere perfect for romantic
                    dinners and special celebrations.
                </p>
            </div>
        </div>

        <!-- Buffet Restaurant -->
        <div class="dining-card">
            <img src="https://images.unsplash.com/photo-1544145945-f90425340c7e" alt="Buffet Restaurant">
            <div class="dining-content">
                <h3>Grand Buffet Hall</h3>
                <p>
                    The Grand Buffet Hall presents a wide variety of local and international
                    dishes served fresh daily. From breakfast spreads to themed dinner nights,
                    guests can explore diverse flavors including Asian, European, and
                    Mediterranean cuisine. Ideal for families and large groups.
                </p>
            </div>
        </div>

        <!-- Sky Lounge -->
        <div class="dining-card">
            <img src="https://images.unsplash.com/photo-1470337458703-46ad1756a187" alt="Sky Lounge">
            <div class="dining-content">
                <h3>Sky Lounge & Bar</h3>
                <p>
                    Located on the rooftop, the Sky Lounge offers breathtaking views of the city.
                    Enjoy handcrafted cocktails, premium spirits, fine wines, and light gourmet
                    bites in a relaxed yet stylish setting. Perfect for evening relaxation,
                    business meetings, or social gatherings.
                </p>
            </div>
        </div>

    </div>
</div>

<footer>
    © 2026 Principe Luxury Hotel | All Rights Reserved
</footer>

</body>
</html>