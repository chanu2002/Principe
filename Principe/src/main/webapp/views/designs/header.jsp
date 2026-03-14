<!-- header.jsp -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Poppins:wght@300;400;500;600&display=swap');

/* Reset */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Poppins', sans-serif;
}

/* ================= HEADER ================= */

.top-header{
    position:relative;
    top:0;
    left:0;
    width:100%;
    z-index:9999;

    background:url('${pageContext.request.contextPath}/views/images/header.jpg') center/cover no-repeat;

    height:230px;
    color:white;

    animation:fadeIn 1.2s ease-in-out;

    box-shadow:0 8px 25px rgba(0,0,0,0.6);
}

/* Dark luxury overlay */

.overlay{
    background:linear-gradient(to bottom, rgba(0,0,0,0.8), rgba(0,0,0,0.55));
    height:100%;

    padding:25px 90px;

    display:flex;
    flex-direction:column;
    justify-content:space-between;
}

/* ================= TOP ROW ================= */

.header-top-row{
    display:flex;
    justify-content:space-between;
    align-items:center;
    font-size:14px;
}

/* Left title */

.header-top-row strong{
    font-size:18px;
    letter-spacing:3px;
    font-weight:600;
}

/* Glass login box */

.header-top-row div:last-child{

    backdrop-filter:blur(12px);

    background:rgba(255,255,255,0.08);

    padding:8px 22px;

    border-radius:40px;

    border:1px solid rgba(255,255,255,0.15);

}

/* Links */

.header-top-row a{

    color:white;

    text-decoration:none;

    margin-left:18px;

    font-weight:500;

    position:relative;

    transition:0.3s;
}

/* Animated underline */

.header-top-row a::after{
    content:"";
    position:absolute;
    width:0%;
    height:2px;
    bottom:-4px;
    left:0;
    background:#ffd700;
    transition:0.4s;
}

.header-top-row a:hover::after{
    width:100%;
}

.header-top-row a:hover{
    color:#ffd700;
}

/* BOOK BUTTON */

.book-btn{

    background:linear-gradient(45deg,#ffd700,#f2c200);

    color:black !important;

    padding:9px 20px;

    border-radius:30px;

    font-weight:600;

    transition:0.35s;

}

.book-btn:hover{

    transform:translateY(-3px);

    box-shadow:0 10px 25px rgba(255,215,0,0.45);

}

/* ================= BRAND CENTER ================= */

.brand-center{

    text-align:center;

    animation:fadeUp 1.3s ease;
}

.brand-center h1{

    font-family:'Playfair Display', serif;

    font-size:46px;

    letter-spacing:5px;

    background:linear-gradient(to right,#ffd700,#fff,#ffd700);

    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;

}

.brand-center span{

    font-size:18px;

    letter-spacing:3px;

    color:#f5e6c8;

}

/* ================= NAVIGATION ================= */

.nav-menu{

    display:flex;

    justify-content:center;

    gap:38px;

    font-size:14px;

    flex-wrap:wrap;

    padding:10px 0;

}

/* Menu items */

.nav-menu a{

    color:white;

    text-decoration:none;

    font-weight:500;

    letter-spacing:1px;

    position:relative;

    padding-bottom:6px;

    transition:0.3s;

}

/* Smooth underline */

.nav-menu a::after{

    content:"";

    position:absolute;

    width:0%;

    height:2px;

    bottom:0;

    left:0;

    background:#ffd700;

    transition:0.35s;

}

.nav-menu a:hover::after{
    width:100%;
}

.nav-menu a:hover{
    color:#ffd700;
}

/* ================= ANIMATIONS ================= */

@keyframes fadeIn{

    from{opacity:0;}

    to{opacity:1;}

}

@keyframes fadeUp{

    from{
        transform:translateY(30px);
        opacity:0;
    }

    to{
        transform:translateY(0);
        opacity:1;
    }

}

/* ================= RESPONSIVE ================= */

@media screen and (max-width:992px){

    .overlay{
        padding:20px 40px;
    }

    .brand-center h1{
        font-size:36px;
    }

    .nav-menu{
        gap:22px;
    }

}

@media screen and (max-width:768px){

    .top-header{
        height:auto;
    }

    .overlay{
        padding:20px;
    }

    .header-top-row{
        flex-direction:column;
        gap:10px;
        text-align:center;
    }

    .nav-menu{
        flex-direction:column;
        gap:14px;
    }

    .brand-center h1{
        font-size:28px;
    }

    .brand-center span{
        font-size:15px;
    }

}

</style>

<div class="top-header">
    <div class="overlay">

        <div class="header-top-row">
            <div>
                <strong>OCEAN VIEW</strong>
            </div>

           <div>
<%
    model.User user = (model.User) session.getAttribute("user");

    if(user == null){
%>

        <a href="${pageContext.request.contextPath}/views/adminLogin.jsp">
            Admin Login
        </a>

        <a href="${pageContext.request.contextPath}/views/register.jsp">
            Register
        </a>

        <a href="${pageContext.request.contextPath}/views/login.jsp"
           class="book-btn">
           BOOK NOW
        </a>

<%
    } else {
%>

        <span style="color:#ffd700;font-weight:600;margin-right:15px;">
            👤 <%= user.getName() %>
        </span>

<a href="${pageContext.request.contextPath}/views/UserPages/MyBookings.jsp"
   class="book-btn">
   Show My Bookings
</a>

<a href="${pageContext.request.contextPath}/LogoutServlet"
   class="book-btn"
   onclick="return confirmLogout()">
   Logout
</a>

<script>
function confirmLogout() {
    return confirm("Are you sure you want to logout?");
}
</script>

<%
    }
%>
</div>
        </div>

        <div class="brand-center">
            <h1>OCEAN VIEW</h1>
            <span>RESORT GALLE</span>
        </div>

        <div class="nav-menu">

<%
    model.User userr = (model.User) session.getAttribute("user");
    if(userr == null){
%>

    <a href="${pageContext.request.contextPath}/index.jsp">HOME</a>

<%
    }
%>

<%
    model.User userrr = (model.User) session.getAttribute("user");

    String currentPage = request.getRequestURI();
    boolean isDashboard = currentPage.contains("userDashboard.jsp");

    if(userrr != null && !isDashboard){
%>

        <a href="${pageContext.request.contextPath}/views/userDashboard.jsp"
           class="book-btn">
           BOOK NOW
        </a>

<%
    }
%>

            <a href="${pageContext.request.contextPath}/views/UserPages/RoomsSuite.jsp">ROOMS & SUITES</a>
            <a href="${pageContext.request.contextPath}/views/UserPages/Dining.jsp">DINING</a>
            <a href="${pageContext.request.contextPath}/views/UserPages/Experience.jsp">EXPERIENCES</a>
            <a href="${pageContext.request.contextPath}/views/UserPages/Offers.jsp">OFFERS</a>
            <a href="${pageContext.request.contextPath}/views/UserPages/Gallery.jsp">GALLERY</a>
            <a href="${pageContext.request.contextPath}/views/UserPages/Esg.jsp">ESG</a>
            <a href="${pageContext.request.contextPath}/views/UserPages/Contact.jsp">CONTACT US</a>

        </div>

    </div>
</div>