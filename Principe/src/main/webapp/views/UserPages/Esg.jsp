<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ESG - Principe Luxury Hotel</title>

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
    background-image:url('https://images.unsplash.com/photo-1506744038136-46273834b3fb');
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

/* About ESG Section */
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

/* ESG Section */
.esg-section{
    padding:60px 80px;
}

.esg-section h2{
    text-align:center;
    margin-bottom:40px;
    font-size:32px;
    color:#333;
}

.esg-container{
    display:flex;
    justify-content:space-between;
    flex-wrap:wrap;
    gap:30px;
}

.esg-card{
    background:white;
    width:30%;
    border-radius:10px;
    overflow:hidden;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
    transition:0.3s;
}

.esg-card:hover{
    transform:translateY(-10px);
}

.esg-card img{
    width:100%;
    height:220px;
    object-fit:cover;
}

.esg-content{
    padding:20px;
}

.esg-content h3{
    margin-bottom:10px;
    color:#222;
}

.esg-content p{
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
    <h1>Our Commitment to ESG</h1>
</div>

<!-- About ESG -->
<div class="about-section">
    <h2>Environmental, Social & Governance Responsibility</h2>
    <p>
        Principe Luxury Hotel is committed to sustainable practices, social responsibility,
        and strong governance principles. Our ESG initiatives are designed to reduce
        environmental impact, promote community engagement, and uphold ethical business
        practices across all operations. We strive to create a positive influence for
        our guests, employees, and the communities we serve.
    </p>
</div>

<!-- ESG Pillars -->
<div class="esg-section">
    <h2>Our ESG Pillars</h2>

    <div class="esg-container">

        <!-- Environmental -->
        <div class="esg-card">
            <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb" alt="Environmental">
            <div class="esg-content">
                <h3>Environmental Sustainability</h3>
                <p>
                    We implement eco-friendly initiatives such as energy-efficient lighting,
                    water conservation programs, waste reduction strategies, and sustainable sourcing.
                    Our goal is to minimize the environmental footprint of our hotel operations.
                </p>
            </div>
        </div>

        <!-- Social -->
        <div class="esg-card">
            <img src="https://images.unsplash.com/photo-1504384308090-c894fdcc538d" alt="Social">
            <div class="esg-content">
                <h3>Social Responsibility</h3>
                <p>
                    Our hotel prioritizes community engagement and employee wellbeing.
                    We support local suppliers, host charity events, provide fair labor practices,
                    and encourage staff development and diversity. Social responsibility is at the
                    heart of everything we do.
                </p>
            </div>
        </div>

        <!-- Governance -->
        <div class="esg-card">
<img src="https://images.unsplash.com/photo-1497366216548-37526070297c" alt="Governance">      <div class="esg-content">
                <h3>Governance & Ethics</h3>
                <p>
                    Our governance framework ensures transparency, accountability, and ethical
                    decision-making. We follow strict compliance standards, maintain data privacy,
                    and uphold integrity in all business operations to build trust with our
                    stakeholders and guests.
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