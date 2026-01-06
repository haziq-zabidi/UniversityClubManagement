<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UCMS - University Club Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        .gradient-bg {
            background: linear-gradient(135deg, #1e40af 0%, #3b82f6 50%, #60a5fa 100%);
        }
        .card-hover {
            transition: all 0.3s ease;
        }
        .card-hover:hover {
            transform: translateY(-8px);
            box-shadow: 0 25px 50px rgba(59, 130, 246, 0.15);
        }
        .feature-icon {
            background: linear-gradient(135deg, #3b82f6 0%, #1e40af 100%);
        }
        .blue-gradient {
            background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
        }
        .blue-gradient-text {
            background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .stat-card {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
        .float-animation {
            animation: float 6s ease-in-out infinite;
        }
    </style>
</head>
<body class="bg-gray-50">
    
    <!-- Navigation Bar -->
    <nav class="bg-white shadow-lg fixed w-full z-50 border-b border-gray-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo & Title -->
                <div class="flex items-center">
                    <div class="h-10 w-10 blue-gradient rounded-lg flex items-center justify-center mr-3 shadow-md">
                        <i class="fas fa-university text-white text-lg"></i>
                    </div>
                    <div>
                        <span class="text-xl font-bold text-gray-900">UCMS</span>
                        <span class="ml-2 text-xs font-medium text-white blue-gradient px-2 py-1 rounded shadow-sm">University</span>
                    </div>
                </div>
                
                <!-- Navigation Links -->
                <div class="hidden md:flex space-x-1">
                    <a href="#features" class="px-4 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-blue-50 hover:text-blue-700 transition duration-200">
                        Features
                    </a>
                    <a href="#benefits" class="px-4 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-blue-50 hover:text-blue-700 transition duration-200">
                        Benefits
                    </a>
                    <a href="#about" class="px-4 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-blue-50 hover:text-blue-700 transition duration-200">
                        How It Works
                    </a>
                    <a href="#contact" class="px-4 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-blue-50 hover:text-blue-700 transition duration-200">
                        Contact
                    </a>
                </div>
                
                <!-- Auth Buttons -->
                <div class="flex items-center space-x-3">
                    <a href="login" 
                       class="px-5 py-2 text-blue-700 text-sm font-semibold rounded-lg border-2 border-blue-700 hover:bg-blue-50 transition duration-200">
                        Login
                    </a>
                    <a href="register" 
                       class="px-5 py-2 blue-gradient text-white text-sm font-semibold rounded-lg hover:opacity-90 transition duration-200 shadow-md">
                        Get Started
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="pt-24 pb-20 px-4 sm:px-6 lg:px-8 gradient-bg relative overflow-hidden">
        <!-- Decorative elements -->
        <div class="absolute top-0 right-0 w-96 h-96 bg-blue-400 opacity-20 rounded-full blur-3xl"></div>
        <div class="absolute bottom-0 left-0 w-96 h-96 bg-blue-600 opacity-20 rounded-full blur-3xl"></div>
        
        <div class="max-w-7xl mx-auto relative z-10">
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                <!-- Left Content -->
                <div class="text-left">
                    <div class="inline-block mb-6">
                        <span class="bg-white bg-opacity-20 backdrop-blur-sm text-white px-4 py-2 rounded-full text-sm font-medium">
                            <i class="fas fa-star text-yellow-300 mr-2"></i>
                            Official University Platform
                        </span>
                    </div>
                    <h1 class="text-4xl md:text-6xl font-extrabold text-white mb-6 leading-tight">
                        University Club<br/>
                        <span class="text-blue-200">Management System</span>
                    </h1>
                    <p class="text-xl text-blue-100 mb-8 leading-relaxed">
                        Streamline club operations, manage activities, and enhance student engagement with our comprehensive digital platform designed for modern universities.
                    </p>
                    <div class="flex flex-col sm:flex-row space-y-4 sm:space-y-0 sm:space-x-4">
                        <a href="register.jsp" 
                           class="px-8 py-4 bg-white text-blue-700 font-bold rounded-lg hover:bg-gray-100 transition duration-200 shadow-xl text-center group">
                            Register Now
                            <i class="fas fa-arrow-right ml-2 group-hover:translate-x-1 transition-transform duration-200"></i>
                        </a>
                        <a href="#features" 
                           class="px-8 py-4 bg-transparent border-2 border-white text-white font-bold rounded-lg hover:bg-white hover:text-blue-700 transition duration-200 text-center backdrop-blur-sm">
                            Learn More
                        </a>
                    </div>
                    
                    <!-- Stats -->
                    <div class="grid grid-cols-3 gap-4 mt-12">
                        <div class="text-center">
                            <div class="text-3xl font-bold text-white">50+</div>
                            <div class="text-sm text-blue-200">Active Clubs</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold text-white">1000+</div>
                            <div class="text-sm text-blue-200">Students</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold text-white">200+</div>
                            <div class="text-sm text-blue-200">Events</div>
                        </div>
                    </div>
                </div>
                
                <!-- Right Illustration -->
                <div class="hidden lg:block">
                    <div class="relative float-animation">
                        <div class="bg-white bg-opacity-10 backdrop-blur-lg rounded-3xl p-8 shadow-2xl border border-white border-opacity-20">
                            <div class="grid grid-cols-2 gap-4">
                                <div class="bg-white rounded-xl p-6 shadow-lg">
                                    <i class="fas fa-users text-blue-600 text-3xl mb-3"></i>
                                    <div class="text-2xl font-bold text-gray-900">250+</div>
                                    <div class="text-xs text-gray-600">Club Members</div>
                                </div>
                                <div class="bg-white rounded-xl p-6 shadow-lg">
                                    <i class="fas fa-calendar-check text-blue-600 text-3xl mb-3"></i>
                                    <div class="text-2xl font-bold text-gray-900">50+</div>
                                    <div class="text-xs text-gray-600">Activities</div>
                                </div>
                                <div class="bg-white rounded-xl p-6 shadow-lg">
                                    <i class="fas fa-trophy text-blue-600 text-3xl mb-3"></i>
                                    <div class="text-2xl font-bold text-gray-900">15+</div>
                                    <div class="text-xs text-gray-600">Achievements</div>
                                </div>
                                <div class="bg-white rounded-xl p-6 shadow-lg">
                                    <i class="fas fa-bullhorn text-blue-600 text-3xl mb-3"></i>
                                    <div class="text-2xl font-bold text-gray-900">100+</div>
                                    <div class="text-xs text-gray-600">Announcements</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div id="features" class="py-20 bg-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <span class="text-blue-600 font-semibold text-sm uppercase tracking-wide">Comprehensive Features</span>
                <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mb-4 mt-2">
                    Everything You Need in <span class="blue-gradient-text">One Platform</span>
                </h2>
                <p class="text-gray-600 text-lg max-w-3xl mx-auto">
                    Powerful tools designed to simplify club management and boost student engagement
                </p>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Feature 1 -->
                <div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl p-8 card-hover border border-blue-100">
                    <div class="h-16 w-16 blue-gradient rounded-xl flex items-center justify-center mb-6 shadow-lg">
                        <i class="fas fa-users text-white text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3">Club Management</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Create and manage clubs with detailed profiles, committee structures, member databases, and automated membership workflows.
                    </p>
                </div>
                
                <!-- Feature 2 -->
                <div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl p-8 card-hover border border-blue-100">
                    <div class="h-16 w-16 blue-gradient rounded-xl flex items-center justify-center mb-6 shadow-lg">
                        <i class="fas fa-calendar-alt text-white text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3">Event Scheduling</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Plan and schedule activities with calendar integration, automatic reminders, and real-time attendance tracking.
                    </p>
                </div>
                
                <!-- Feature 3 -->
                <div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl p-8 card-hover border border-blue-100">
                    <div class="h-16 w-16 blue-gradient rounded-xl flex items-center justify-center mb-6 shadow-lg">
                        <i class="fas fa-bullhorn text-white text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3">Instant Announcements</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Broadcast important updates and news to all members instantly with targeted messaging capabilities.
                    </p>
                </div>
                
                <!-- Feature 4 -->
                <div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl p-8 card-hover border border-blue-100">
                    <div class="h-16 w-16 blue-gradient rounded-xl flex items-center justify-center mb-6 shadow-lg">
                        <i class="fas fa-user-shield text-white text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3">Role-Based Access</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Secure system with admin, committee, and student roles, each with appropriate permissions and controls.
                    </p>
                </div>
                
                <!-- Feature 5 -->
                <div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl p-8 card-hover border border-blue-100">
                    <div class="h-16 w-16 blue-gradient rounded-xl flex items-center justify-center mb-6 shadow-lg">
                        <i class="fas fa-chart-line text-white text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3">Analytics & Reports</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Track engagement, participation, and growth with comprehensive analytics dashboards and exportable reports.
                    </p>
                </div>
                
                <!-- Feature 6 -->
                <div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl p-8 card-hover border border-blue-100">
                    <div class="h-16 w-16 blue-gradient rounded-xl flex items-center justify-center mb-6 shadow-lg">
                        <i class="fas fa-mobile-alt text-white text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3">Mobile Responsive</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Access the platform anywhere, anytime with our fully responsive design optimized for all devices.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Benefits Section -->
    <div id="benefits" class="py-20 bg-gradient-to-br from-gray-50 to-blue-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <span class="text-blue-600 font-semibold text-sm uppercase tracking-wide">Why Choose UCMS</span>
                <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mb-4 mt-2">
                    Transform Your Club Management
                </h2>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
                <div class="space-y-6">
                    <div class="flex items-start space-x-4">
                        <div class="flex-shrink-0">
                            <div class="h-12 w-12 blue-gradient rounded-lg flex items-center justify-center">
                                <i class="fas fa-check text-white"></i>
                            </div>
                        </div>
                        <div>
                            <h3 class="text-xl font-bold text-gray-900 mb-2">Save Time & Effort</h3>
                            <p class="text-gray-600">Automate repetitive tasks and streamline administrative workflows, saving hours of manual work every week.</p>
                        </div>
                    </div>
                    
                    <div class="flex items-start space-x-4">
                        <div class="flex-shrink-0">
                            <div class="h-12 w-12 blue-gradient rounded-lg flex items-center justify-center">
                                <i class="fas fa-check text-white"></i>
                            </div>
                        </div>
                        <div>
                            <h3 class="text-xl font-bold text-gray-900 mb-2">Boost Engagement</h3>
                            <p class="text-gray-600">Increase student participation with easy-to-use tools and instant communication channels.</p>
                        </div>
                    </div>
                    
                    <div class="flex items-start space-x-4">
                        <div class="flex-shrink-0">
                            <div class="h-12 w-12 blue-gradient rounded-lg flex items-center justify-center">
                                <i class="fas fa-check text-white"></i>
                            </div>
                        </div>
                        <div>
                            <h3 class="text-xl font-bold text-gray-900 mb-2">Data-Driven Decisions</h3>
                            <p class="text-gray-600">Make informed decisions with real-time analytics and comprehensive reporting features.</p>
                        </div>
                    </div>
                    
                    <div class="flex items-start space-x-4">
                        <div class="flex-shrink-0">
                            <div class="h-12 w-12 blue-gradient rounded-lg flex items-center justify-center">
                                <i class="fas fa-check text-white"></i>
                            </div>
                        </div>
                        <div>
                            <h3 class="text-xl font-bold text-gray-900 mb-2">Secure & Reliable</h3>
                            <p class="text-gray-600">Enterprise-grade security with regular backups and 99.9% uptime guarantee.</p>
                        </div>
                    </div>
                </div>
                
                <div class="bg-white rounded-2xl p-8 shadow-2xl">
                    <div class="space-y-6">
                        <div class="border-l-4 border-blue-600 pl-6">
                            <div class="text-4xl font-bold text-blue-600 mb-2">75%</div>
                            <p class="text-gray-600">Reduction in administrative tasks</p>
                        </div>
                        <div class="border-l-4 border-blue-600 pl-6">
                            <div class="text-4xl font-bold text-blue-600 mb-2">3x</div>
                            <p class="text-gray-600">Increase in student engagement</p>
                        </div>
                        <div class="border-l-4 border-blue-600 pl-6">
                            <div class="text-4xl font-bold text-blue-600 mb-2">100%</div>
                            <p class="text-gray-600">Digital transformation of club operations</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- How It Works -->
    <div id="about" class="py-20 bg-white">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <span class="text-blue-600 font-semibold text-sm uppercase tracking-wide">Simple Process</span>
                <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mb-4 mt-2">
                    Get Started in Minutes
                </h2>
                <p class="text-gray-600 text-lg max-w-3xl mx-auto">
                    Four simple steps to revolutionize your club management experience
                </p>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                <!-- Step 1 -->
                <div class="text-center relative">
                    <div class="h-24 w-24 blue-gradient rounded-2xl flex items-center justify-center mx-auto mb-6 text-3xl font-bold text-white shadow-xl relative z-10">
                        1
                    </div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3">Create Account</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Sign up with your university credentials in under 2 minutes
                    </p>
                </div>
                
                <!-- Step 2 -->
                <div class="text-center relative">
                    <div class="h-24 w-24 blue-gradient rounded-2xl flex items-center justify-center mx-auto mb-6 text-3xl font-bold text-white shadow-xl relative z-10">
                        2
                    </div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3">Join Clubs</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Browse and join clubs that match your interests
                    </p>
                </div>
                
                <!-- Step 3 -->
                <div class="text-center relative">
                    <div class="h-24 w-24 blue-gradient rounded-2xl flex items-center justify-center mx-auto mb-6 text-3xl font-bold text-white shadow-xl relative z-10">
                        3
                    </div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3">Stay Updated</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Receive announcements and event notifications instantly
                    </p>
                </div>
                
                <!-- Step 4 -->
                <div class="text-center relative">
                    <div class="h-24 w-24 blue-gradient rounded-2xl flex items-center justify-center mx-auto mb-6 text-3xl font-bold text-white shadow-xl relative z-10">
                        4
                    </div>
                    <h3 class="text-xl font-bold text-gray-900 mb-3">Get Involved</h3>
                    <p class="text-gray-600 leading-relaxed">
                        Participate in activities and grow your network
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- CTA Section -->
    <div class="py-20 blue-gradient">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <h2 class="text-4xl md:text-5xl font-bold text-white mb-6">
                Ready to Transform Your Club Experience?
            </h2>
            <p class="text-xl text-blue-100 mb-8">
                Join thousands of students already using UCMS to enhance their university life
            </p>
            <div class="flex flex-col sm:flex-row justify-center space-y-4 sm:space-y-0 sm:space-x-4">
                <a href="register.jsp" 
                   class="px-10 py-4 bg-white text-blue-700 font-bold rounded-lg hover:bg-gray-100 transition duration-200 shadow-xl text-lg">
                    Start Free Today
                </a>
                <a href="#contact" 
                   class="px-10 py-4 bg-transparent border-2 border-white text-white font-bold rounded-lg hover:bg-white hover:text-blue-700 transition duration-200 text-lg">
                    Contact Us
                </a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer id="contact" class="bg-gray-900 text-white py-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-12">
                <!-- Company Info -->
                <div class="md:col-span-2">
                    <div class="flex items-center mb-6">
                        <div class="h-12 w-12 blue-gradient rounded-lg flex items-center justify-center mr-3 shadow-lg">
                            <i class="fas fa-university text-white text-xl"></i>
                        </div>
                        <div>
                            <span class="text-2xl font-bold">UCMS</span>
                            <span class="block text-sm text-gray-400">University Club Management</span>
                        </div>
                    </div>
                    <p class="text-gray-400 leading-relaxed mb-6">
                        Official Club Management System designed for modern universities. Streamlining student club operations and enhancing campus engagement through innovative digital solutions.
                    </p>
                    <div class="flex space-x-4">
                        <a href="#" class="h-10 w-10 bg-gray-800 hover:bg-blue-600 rounded-lg flex items-center justify-center transition duration-200">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="h-10 w-10 bg-gray-800 hover:bg-blue-600 rounded-lg flex items-center justify-center transition duration-200">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="h-10 w-10 bg-gray-800 hover:bg-blue-600 rounded-lg flex items-center justify-center transition duration-200">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="h-10 w-10 bg-gray-800 hover:bg-blue-600 rounded-lg flex items-center justify-center transition duration-200">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </div>
                </div>
                
                <!-- Quick Links -->
                <div>
                    <h3 class="text-lg font-bold mb-6">Quick Links</h3>
                    <ul class="space-y-3">
                        <li><a href="login" class="text-gray-400 hover:text-white transition duration-200 flex items-center"><i class="fas fa-chevron-right text-blue-500 text-xs mr-2"></i>Login</a></li>
                        <li><a href="register" class="text-gray-400 hover:text-white transition duration-200 flex items-center"><i class="fas fa-chevron-right text-blue-500 text-xs mr-2"></i>Register</a></li>
                        <li><a href="#features" class="text-gray-400 hover:text-white transition duration-200 flex items-center"><i class="fas fa-chevron-right text-blue-500 text-xs mr-2"></i>Features</a></li>
                        <li><a href="#about" class="text-gray-400 hover:text-white transition duration-200 flex items-center"><i class="fas fa-chevron-right text-blue-500 text-xs mr-2"></i>How It Works</a></li>
                    </ul>
                </div>
                
                <!-- Contact -->
                <div>
                    <h3 class="text-lg font-bold mb-6">Contact Us</h3>
                    <ul class="space-y-4 text-gray-400">
                        <li class="flex items-start">
                            <i class="fas fa-envelope text-blue-500 mr-3 mt-1"></i>
                            <div>
                                <div class="text-white font-medium">Email</div>
                                support@ucms.edu
                            </div>
                        </li>
                        <li class="flex items-start">
                            <i class="fas fa-phone text-blue-500 mr-3 mt-1"></i>
                            <div>
                                <div class="text-white font-medium">Phone</div>
                                +60 123-456-7890
                            </div>
                        </li>
                        <li class="flex items-start">
                            <i class="fas fa-map-marker-alt text-blue-500 mr-3 mt-1"></i>
                            <div>
                                <div class="text-white font-medium">Location</div>
                                University Campus
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            
            <div class="border-t border-gray-800 mt-12 pt-8 text-center text-gray-400">
                <p class="text-sm">© 2025 University Club Management System. All rights reserved.</p>
                <p class="text-xs mt-2">Empowering student clubs through innovative technology solutions</p>
            </div>
        </div>
    </footer>

    <!-- Scroll to top button -->
    <button id="scrollToTop" class="fixed bottom-8 right-8 blue-gradient text-white p-4 rounded-full shadow-2xl hover:opacity-90 transition duration-200 hidden z-50">
        <i class="fas fa-arrow-up text-lg"></i>
    </button>

    <script>
        // Scroll// Scroll to top functionality
        const scrollToTopBtn = document.getElementById('scrollToTop');
        
        window.addEventListener('scroll', () => {
            if (window.pageYOffset > 300) {
                scrollToTopBtn.classList.remove('hidden');
            } else {
                scrollToTopBtn.classList.add('hidden');
            }
        });
        
        scrollToTopBtn.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
        
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const targetId = this.getAttribute('href');
                if(targetId === '#') return;
                
                const targetElement = document.querySelector(targetId);
                if(targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 80,
                        behavior: 'smooth'
                    });
                }
            });
        });
    </script>
</body>
</html>
