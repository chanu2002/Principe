<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Experiences - Principe Luxury Hotel</title>

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
    background-image:url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e');
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

/* Experience Section */
.experience-section{
    padding:60px 80px;
}

.experience-section h2{
    text-align:center;
    margin-bottom:40px;
    font-size:32px;
    color:#333;
}

.experience-container{
    display:flex;
    justify-content:space-between;
    flex-wrap:wrap;
    gap:30px;
}

.experience-card{
    background:white;
    width:30%;
    border-radius:10px;
    overflow:hidden;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
    transition:0.3s;
}

.experience-card:hover{
    transform:translateY(-10px);
}

.experience-card img{
    width:100%;
    height:220px;
    object-fit:cover;
}

.experience-content{
    padding:20px;
}

.experience-content h3{
    margin-bottom:10px;
    color:#222;
}

.experience-content p{
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
    <h1>Unforgettable Experiences</h1>
</div>

<!-- About Experiences -->
<div class="about-section">
    <h2>Create Memorable Moments</h2>
    <p>
        At Principe Luxury Hotel, we offer more than just accommodation —
        we create unforgettable experiences. Whether you seek relaxation,
        adventure, wellness, or cultural discovery, our curated experiences
        are designed to enrich your stay and create lasting memories.
    </p>
</div>

<!-- Experiences Section -->
<div class="experience-section">
    <h2>Our Signature Experiences</h2>

    <div class="experience-container">

        <!-- Spa & Wellness -->
        <div class="experience-card">
            <img src="https://images.unsplash.com/photo-1544161515-4ab6ce6db874" alt="Spa & Wellness">
            <div class="experience-content">
                <h3>Spa & Wellness Retreat</h3>
                <p>
                    Rejuvenate your body and mind at our luxury spa. Enjoy
                    therapeutic massages, aromatherapy sessions, skincare
                    treatments, and holistic wellness programs conducted by
                    certified professionals. Our serene environment provides
                    the perfect escape from everyday stress.
                </p>
            </div>
        </div>

        <!-- Adventure Activities -->
        <div class="experience-card">
            <img src="https://images.unsplash.com/photo-1500530855697-b586d89ba3ee" alt="Adventure Activities">
            <div class="experience-content">
                <h3>Adventure & Outdoor Activities</h3>
                <p>
                    Explore thrilling outdoor experiences including guided
                    city tours, hiking excursions, water sports, and cultural
                    exploration trips. Our concierge team organizes personalized
                    adventures tailored to your interests and preferences.
                </p>
            </div>
        </div>

        <!-- Events & Celebrations -->
        <div class="experience-card">
<img src="https://images.unsplash.com/photo-1505236858219-8359eb29e329" alt="Events & Celebrations">           
				 <div class="experience-content">
                <h3>Events & Private Celebrations</h3>
                <p>
                    Celebrate life’s special moments in elegance. From weddings
                    and anniversaries to corporate events and private parties,
                    our luxurious venues and professional event planners ensure
                    flawless execution and unforgettable experiences.
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