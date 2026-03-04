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
   position: relative;        /* Make it fixed at top */
    top: 0;                 /* Stick to top */
    left: 0;
    width: 100%;            /* Full width */
    z-index: 9999;          /* On top of everything */
    background: url('${pageContext.request.contextPath}/views/images/header.jpg') center/cover no-repeat;
    height: 230px;
    color: white;
    animation: fadeIn 1.2s ease-in-out;
    transition: all 0.5s ease;
}

/* Dark Luxury Overlay */
.overlay{
    background:linear-gradient(to bottom, rgba(0,0,0,0.75), rgba(0,0,0,0.55));
    height:100%;
    padding:25px 80px;
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
    animation:slideDown 1s ease;
}

.header-top-row strong{
    font-size:18px;
    letter-spacing:2px;
}

/* Glass effect box */
.header-top-row div:last-child{
    backdrop-filter:blur(8px);
    background:rgba(255,255,255,0.06);
    padding:8px 18px;
    border-radius:30px;
}

.header-top-row a{
    color:white;
    text-decoration:none;
    margin-left:20px;
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
    background:linear-gradient(45deg,#ffd700,#e6c200);
    color:black !important;
    padding:8px 18px;
    border-radius:30px;
    font-weight:600;
    transition:0.3s ease;
}

.book-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 8px 20px rgba(255,215,0,0.4);
}

/* ================= BRAND CENTER ================= */

.brand-center{
    text-align:center;
    animation:fadeUp 1.5s ease;
}

.brand-center h1{
    font-family:'Playfair Display', serif;
    font-size:42px;
    letter-spacing:4px;
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
    gap:35px;
    font-size:14px;
    flex-wrap:wrap;      /* ✅ allows items to move to next line */
}

.nav-menu a{
    color:white;
    text-decoration:none;
    font-weight:500;
    position:relative;
    padding-bottom:5px;
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
    transition:0.4s ease;
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

@keyframes slideDown{
    from{transform:translateY(-30px); opacity:0;}
    to{transform:translateY(0); opacity:1;}
}

@keyframes fadeUp{
    from{transform:translateY(30px); opacity:0;}
    to{transform:translateY(0); opacity:1;}
}

/* ================= RESPONSIVE ================= */

@media screen and (max-width:992px){
    .overlay{
        padding:20px 40px;
    }

    .brand-center h1{
        font-size:34px;
    }

    .nav-menu{
        gap:20px;
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
        gap:12px;
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
                <strong>PRINCIPE</strong>
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

        <span style="
    color:#ffd700;
    font-weight:600;
    margin-right:15px;
">
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
            <h1>Principe</h1>
            <span>GRAND COLOMBO</span>
        </div>

        <div class="nav-menu">
         	<%
    model.User userr = (model.User) session.getAttribute("user");
    if(userr == null){
%>

    <a href="${pageContext.request.contextPath}/index.jsp">Home</a>

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
            
        </div>

    </div>
</div>