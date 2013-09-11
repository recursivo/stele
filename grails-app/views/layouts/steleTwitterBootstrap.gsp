<!DOCTYPE html>
<html lang="en"> 
<head>
  <meta charset="utf-8">
  <title>Stete | Registro</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <r:require modules="bootstrap-js,bootstrap-css,bootstrap-responsive-css,font-awesome" />
  <style>
    body {
      padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
    }
  </style>
  <g:layoutHead/>
  <r:layoutResources />
</head> 
<body>
  <div class="top">
    <div class="container">               
    </div>      
  </div>
  <div class="header">               
    <div class="container"> 
      <!-- Logo -->       
      <div class="logo">                                             
        <a href="#"><img id="logo-header" src="${resource(dir: 'images/assets', file: 'logo1-default.png')}" alt="Logo"></a>
      </div><!-- /logo -->        
      
      <!-- Menu -->       
      <div class="navbar">                                
        <div class="navbar-inner">                                  
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a><!-- /nav-collapse -->                                  
          <div class="nav-collapse collapse">
            <!-- menu -->
            <ul class="nav top-2">
              <li>
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Home
                  <b class="caret"></b>                            
                </a>
                <ul class="dropdown-menu">
                  <li><a href="index.html">Option1: Landing Page</a></li>
                  <li><a href="page_home.html">Option2: Header Option</a></li>
                  <li><a href="page_home4.html">Option3: Revolution Slider</a></li>
                  <li><a href="page_home5.html">Option4: Amazing Content</a></li>
                  <li><a href="page_home1.html">Option5: Mixed Content</a></li>
                  <li><a href="page_home2.html">Option6: Content with Sidebar</a></li>
                  <li><a href="page_home3.html">Option7: Aplle Style Slider</a></li>
                  <li><a href="page_home_all.html">Home All In One</a></li>
                </ul>
                <b class="caret-out"></b>                        
              </li>
              <li class="active">
                <a href="" class="dropdown-toggle" data-toggle="dropdown">Pages
                  <b class="caret"></b>                            
                </a>
                <ul class="dropdown-menu">
                  <li><a href="page_about.html">About Us</a></li>
                  <li><a href="page_services.html">Services</a></li>
                  <li><a href="page_pricing.html">Pricing</a></li>
                  <li><a href="page_coming_soon.html">Coming Soon</a></li>
                  <li><a href="page_faq.html">FAQs</a></li>
                  <li><a href="page_search.html">Search Result</a></li>
                  <li><a href="page_gallery.html">Gallery</a></li>
                  <li class="active"><a href="page_registration.html">Registration</a></li>
                  <li><a href="page_login.html">Login</a></li>
                  <li><a href="page_404.html">404</a></li>
                  <li><a href="page_clients.html">Clients</a></li>
                  <li><a href="page_privacy.html">Privacy Policy</a></li>
                  <li><a href="page_terms.html">Terms of Service</a></li>
                  <li><a href="page_column_left.html">2 Columns (Left)</a></li>
                  <li><a href="page_column_right.html">2 Columns (Right)</a></li>
                </ul>
                <b class="caret-out"></b>                        
              </li>
              <li>
                <a href="" class="dropdown-toggle" data-toggle="dropdown">Features
                  <b class="caret"></b>                            
                </a>
                <ul class="dropdown-menu">
                  <li><a href="feature_grid.html">Grid Layout</a></li>
                  <li><a href="feature_typography.html">Typography</a></li>
                  <li><a href="feature_thumbnail.html">Thumbnails</a></li>
                  <li><a href="feature_component.html">Components</a></li>
                  <li><a href="feature_navigation.html">Navigation</a></li>
                  <li><a href="feature_table.html">Tables</a></li>
                  <li><a href="feature_form.html">Forms</a></li>
                  <li><a href="feature_icons.html">Icons</a></li>
                  <li><a href="feature_button.html">Buttons</a></li>
                </ul>
                <b class="caret-out"></b>                        
              </li>
              <li>
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Portfolio
                  <b class="caret"></b>                            
                </a>
                <ul class="dropdown-menu">
                  <li><a href="portfolio.html">Portfolio</a></li>
                  <li><a href="portfolio_item.html">Portfolio Item</a></li>
                  <li><a href="portfolio_2columns.html">Portfolio 2 Columns</a></li>
                  <li><a href="portfolio_3columns.html">Portfolio 3 Columns</a></li>
                  <li><a href="portfolio_4columns.html">Portfolio 4 Columns</a></li>
                </ul>
                <b class="caret-out"></b>                        
              </li>
              <li>
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Blog
                  <b class="caret"></b>                            
                </a>
                <ul class="dropdown-menu">
                  <li><a href="blog.html">Blog</a></li>
                  <li><a href="blog_item.html">Blog Item</a></li>
                  <li><a href="blog_left_sidebar.html">Blog Left Sidebar</a></li>
                  <li><a href="blog_item_left_sidebar.html">Blog Item Left Sidebar</a></li>
                </ul>
                <b class="caret-out"></b>                        
              </li>
              <li>
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Contact
                  <b class="caret"></b>                            
                </a>
                <ul class="dropdown-menu">
                  <li><a href="page_contact.html">Contact Default</a></li>
                  <li><a href="page_contact1.html">Contact Boxed Map</a></li>
                </ul>
                <b class="caret-out"></b>                        
              </li>
              <li><a class="search"><i class="icon-search search-btn"></i></a></li>                               
            </ul>
            <div class="search-open">
              <div class="input-append">
                <form>
                  <input type="text" class="span3" placeholder="Search" />
                  <button type="submit" class="btn-u">Go</button>
                </form>
              </div>
            </div>
          </div><!-- /nav-collapse -->                                
        </div><!-- /navbar-inner -->
      </div><!-- /navbar -->                          
    </div><!-- /container -->               
  </div><!--/header -->       
  
  <!--=== Copyright ===-->
  <div class="container">
    <g:layoutBody/>
    <div class="footer">
      <div class="row-fluid">
        <div class="span8">                     
          <p>2013 &copy; Stele de México, S.A. de C.V. Todos los derechos reservados. <a href="#">Política de privacidad</a> | <a href="#">Términos del servicio</a></p>
        </div>
        <div class="span4"> 
          <a href="index.html"><img id="logo-footer" src="${resource(dir: 'images/assets', file: 'logo2-default.png')}" class="pull-right" alt="" /></a>
        </div>
      </div><!--/row-fluid-->
    </div>
  </div><!--/container--> 
  <r:layoutResources />
</body>
</html> 