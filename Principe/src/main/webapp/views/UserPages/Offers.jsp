<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Special Offers - Principe Luxury Hotel</title>

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
    background-image:url('https://images.unsplash.com/photo-1445019980597-93fa8acb246c');
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

/* About Section */
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

/* Offers Section */
.offers-section{
    padding:60px 80px;
}

.offers-section h2{
    text-align:center;
    margin-bottom:40px;
    font-size:32px;
    color:#333;
}

.offers-container{
    display:flex;
    justify-content:space-between;
    flex-wrap:wrap;
    gap:30px;
}

.offer-card{
    background:white;
    width:30%;
    border-radius:10px;
    overflow:hidden;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
    transition:0.3s;
}

.offer-card:hover{
    transform:translateY(-10px);
}

.offer-card img{
    width:100%;
    height:220px;
    object-fit:cover;
}

.offer-content{
    padding:20px;
}

.offer-content h3{
    margin-bottom:10px;
    color:#222;
}

.offer-content p{
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
    <h1>Exclusive Offers</h1>
</div>

<!-- About Offers -->
<div class="about-section">
    <h2>Enjoy Special Privileges</h2>
    <p>
        Discover exclusive packages and seasonal promotions designed to make your stay
        even more rewarding. Whether you're planning a romantic escape, a family vacation,
        or a business trip, our special offers provide exceptional value while maintaining
        the highest standards of luxury and comfort.
    </p>
</div>

<!-- Offers Section -->
<div class="offers-section">
    <h2>Our Current Promotions</h2>

    <div class="offers-container">

        <!-- Romantic Getaway -->
        <div class="offer-card">
            <img src="https://images.unsplash.com/photo-1520250497591-112f2f40a3f4" alt="Romantic Getaway">
            <div class="offer-content">
                <h3>Romantic Getaway Package</h3>
                <p>
                    Escape into a world of romance with our exclusive couple’s package.
                    Enjoy a beautifully decorated room, candlelight dinner for two,
                    complimentary sparkling wine, late check-out, and special spa discounts.
                    Perfect for anniversaries, honeymoons, and special celebrations.
                </p>
            </div>
        </div>

        <!-- Family Vacation -->
        <div class="offer-card">
<img src="https://images.unsplash.com/photo-1560448204-e02f11c3d0e2" alt="Family Vacation">            <div class="offer-content">
                <h3>Family Vacation Deal</h3>
                <p>
                    Create unforgettable family memories with our special family package.
                    Includes spacious accommodation, complimentary breakfast for all,
                    kids’ activity access, and exclusive discounts on dining and local tours.
                    Designed to provide comfort and enjoyment for every family member.
                </p>
            </div>
        </div>

        <!-- Business Package -->
        <div class="offer-card">
            <img src="https://images.unsplash.com/photo-1497366216548-37526070297c" alt="Business Package">
            <div class="offer-content">
                <h3>Business Travel Package</h3>
                <p>
                    Tailored for professionals, this package offers executive rooms,
                    high-speed internet, access to meeting rooms, complimentary airport
                    transfer, and daily breakfast. Enjoy productivity and comfort combined
                    in an environment designed for success.
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