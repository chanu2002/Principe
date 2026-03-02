<!-- header.jsp -->
<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
    }

    .top-header {
        position: relative;
         background: url('${pageContext.request.contextPath}/views/images/header.jpg') center/cover no-repeat;
        height: 180px;
        color: white;
    }

    .overlay {
        background: rgba(0, 0, 0, 0.5);
        height: 100%;
        padding: 20px 60px;
    }

    .header-top-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 14px;
    }

    .header-top-row a {
        color: white;
        text-decoration: none;
        margin-left: 20px;
    }

    .brand-center {
        text-align: center;
        margin-top: 10px;
    }

    .brand-center h1 {
        margin: 5px 0;
        font-size: 34px;
        font-weight: 500;
    }

    .brand-center span {
        font-size: 18px;
        letter-spacing: 2px;
    }

    .nav-menu {
        display: flex;
        justify-content: center;
        margin-top: 15px;
        gap: 30px;
        font-size: 14px;
    }

    .nav-menu a {
        color: white;
        text-decoration: none;
        font-weight: 500;
    }

    .book-btn {
        background: white;
        color: black;
        padding: 8px 15px;
        border-radius: 4px;
        text-decoration: none;
        font-weight: bold;
    }
</style>

<div class="top-header">
    <div class="overlay">

        <div class="header-top-row">
            <div>
                <strong>Principe</strong>
            </div>

            <div>
                <a href="#">ENGLISH</a>
                <a href="#">MANAGE BOOKINGS</a>
                <a href="#" class="book-btn">BOOK NOW</a>
            </div>
        </div>

        <div class="brand-center">
            <h1>Principe</h1>
            <span>GRAND COLOMBO</span>
        </div>

        <div class="nav-menu">
            <a href="#">ROOMS & SUITES</a>
            <a href="#">DINING</a>
            <a href="#">EXPERIENCES</a>
            <a href="#">OFFERS</a>
            <a href="#">GALLERY</a>
            <a href="#">ESG</a>
        </div>

    </div>
</div>