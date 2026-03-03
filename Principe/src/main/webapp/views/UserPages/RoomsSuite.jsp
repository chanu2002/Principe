<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Rooms and Suites</title>

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
    background-image:url('https://images.unsplash.com/photo-1566665797739-1674de7a421a');
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

/* Rooms Section */
.rooms-section{
    padding:60px 80px;
}

.rooms-section h2{
    text-align:center;
    margin-bottom:40px;
    font-size:32px;
    color:#333;
}

.room-container{
    display:flex;
    justify-content:space-between;
    flex-wrap:wrap;
    gap:30px;
}

.room-card{
    background:white;
    width:30%;
    border-radius:10px;
    overflow:hidden;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
    transition:0.3s;
}

.room-card:hover{
    transform:translateY(-10px);
}

.room-card img{
    width:100%;
    height:220px;
    object-fit:cover;
}

.room-content{
    padding:20px;
}

.room-content h3{
    margin-bottom:10px;
    color:#222;
}

.room-content p{
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
    <h1>Rooms & Suites</h1>
</div>

<!-- About Hotel Section -->
<div class="about-section">
    <h2>Welcome to Principe Luxury Hotel</h2>
    <p>
        Principe Luxury Hotel offers an unforgettable hospitality experience designed for comfort,
        elegance, and relaxation. Located in a prime destination, our hotel blends modern
        architecture with timeless luxury. Guests can enjoy world-class amenities including a
        fully equipped fitness center, fine dining restaurant, rooftop swimming pool, conference
        facilities, spa services, and 24/7 concierge support. Whether you are traveling for
        business or leisure, our dedicated team ensures personalized service and exceptional
        comfort throughout your stay.
    </p>
</div>

<!-- Rooms Section -->
<div class="rooms-section">
    <h2>Our Luxury Rooms</h2>

    <div class="room-container">

        <!-- Deluxe Room -->
        <div class="room-card">
            <img src="https://images.unsplash.com/photo-1505693416388-ac5ce068fe85" alt="Deluxe Room">
            <div class="room-content">
                <h3>Deluxe Room</h3>
                <p>
                    The Deluxe Room is thoughtfully designed to provide maximum comfort and style.
                    Featuring a king-size bed with premium bedding, elegant interiors, and large
                    windows offering a beautiful city view, this room is perfect for both business
                    and leisure travelers. Guests enjoy high-speed WiFi, smart TV, air conditioning,
                    a work desk, and complimentary breakfast. The modern bathroom includes luxury
                    toiletries and a refreshing rain shower for a relaxing experience.
                </p>
            </div>
        </div>

        <!-- Executive Suite -->
        <div class="room-card">
            <img src="https://images.unsplash.com/photo-1582719478250-c89cae4dc85b" alt="Executive Suite">
            <div class="room-content">
                <h3>Executive Suite</h3>
                <p>
                    The Executive Suite offers a spacious and sophisticated environment with a
                    separate living area and bedroom. Ideal for business executives and couples,
                    this suite includes a minibar, premium furnishings, smart entertainment system,
                    luxury bathroom amenities, and exclusive access to the executive lounge.
                    Experience privacy, elegance, and superior comfort designed to meet the
                    highest standards of hospitality.
                </p>
            </div>
        </div>

        <!-- Family Suite -->
        <div class="room-card">
            <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427" alt="Family Suite">
            <div class="room-content">
                <h3>Family Suite</h3>
                <p>
                    The Family Suite is perfect for families seeking spacious accommodation and
                    comfort. With multiple beds, a cozy sitting area, and a private balcony view,
                    this suite ensures a relaxing stay for everyone. It includes family-friendly
                    amenities, high-speed internet, large smart TV, and 24-hour room service.
                    Designed with warmth and functionality, it creates the perfect home-away-from-home atmosphere.
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