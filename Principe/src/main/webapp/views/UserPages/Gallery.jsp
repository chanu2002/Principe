<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gallery - Principe Luxury Hotel</title>

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
    background-image:url('https://images.unsplash.com/photo-1551882547-ff40c63fe5fa');
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

/* Gallery Section */
.gallery-section{
    padding:60px 80px;
}

.gallery-section h2{
    text-align:center;
    margin-bottom:40px;
    font-size:32px;
    color:#333;
}

.gallery-container{
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(300px, 1fr));
    gap:20px;
}

.gallery-item{
    overflow:hidden;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

.gallery-item img{
    width:100%;
    height:250px;
    object-fit:cover;
    transition:0.4s;
}

.gallery-item img:hover{
    transform:scale(1.1);
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
    <h1>Hotel Gallery</h1>
</div>

<!-- About Gallery -->
<div class="about-section">
    <h2>Explore Our Luxury Spaces</h2>
    <p>
        Discover the elegance and beauty of Principe Luxury Hotel through our
        gallery. From luxurious rooms and fine dining areas to breathtaking
        event spaces and relaxing wellness facilities, every corner of our
        hotel is designed to provide comfort, sophistication, and unforgettable
        experiences.
    </p>
</div>

<!-- Gallery Grid -->
<div class="gallery-section">
    <h2>Moments & Memories</h2>

    <div class="gallery-container">

        <div class="gallery-item">
            <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945" alt="Luxury Room">
        </div>

        <div class="gallery-item">
            <img src="https://images.unsplash.com/photo-1551632811-561732d1e306" alt="Hotel Lobby">
        </div>

        <div class="gallery-item">
            <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb" alt="Swimming Pool">
        </div>

        <div class="gallery-item">
            <img src="https://images.unsplash.com/photo-1552566626-52f8b828add9" alt="Restaurant">
        </div>

        <div class="gallery-item">
<img src="https://images.unsplash.com/photo-1540555700478-4be289fbecef" alt="Spa">        </div>

        <div class="gallery-item">
            <img src="https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd" alt="Suite Interior">
        </div>

    </div>
</div>

<footer>
    © 2026 Principe Luxury Hotel | All Rights Reserved
</footer>

</body>
</html>