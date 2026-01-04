<%-- 
    Document   : joinClubList
    Created on : 2 Jan 2026, 2:17:49 am
    Author     : TUF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Clubs - UCMS</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
        </style>
    </head>
    <body class="bg-gradient-to-br from-blue-50 via-white to-indigo-50 min-h-screen">
        
        <!-- Navigation Bar -->
        <nav class="bg-white shadow-lg border-b border-gray-200">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center h-16">
                    <!-- Logo & Title -->
                    <div class="flex items-center">
                        <div class="h-10 w-10 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-lg flex items-center justify-center mr-3">
                            <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                            </svg>
                        </div>
                        <span class="text-xl font-bold text-gray-900">UCMS</span>
                    </div>
                    
                    <!-- Navigation Links -->
                    <div class="hidden md:flex space-x-4">
                        <a href="${pageContext.request.contextPath}/user/dashboard" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/user/clubs" 
                           class="px-3 py-2 rounded-md text-sm font-medium bg-blue-100 text-blue-700">
                            My Clubs
                        </a>
                        <a href="${pageContext.request.contextPath}/user/announcements" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            Announcements
                        </a>
                        <a href="${pageContext.request.contextPath}/user/profile" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            Profile
                        </a>
                    </div>
                    
                    <!-- User Menu -->
                    <div class="flex items-center">
                        <span class="text-sm font-medium text-gray-700 mr-4">Hi, ${userName}!</span>
                        <a href="${pageContext.request.contextPath}/logout" 
                           class="px-4 py-2 bg-red-600 text-white text-sm font-medium rounded-lg hover:bg-red-700 transition duration-200">
                            Logout
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            
            <!-- Page Header -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900">Browse All Clubs</h1>
                <p class="text-gray-600 mt-1">Join clubs and connect with fellow students</p>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="mb-6 bg-green-50 border-l-4 border-green-500 p-4 rounded-r-lg">
                    <div class="flex items-center">
                        <svg class="h-5 w-5 text-green-500 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                        <p class="text-green-700 font-medium">${successMessage}</p>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-r-lg">
                    <div class="flex items-center">
                        <svg class="h-5 w-5 text-red-500 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                        <p class="text-red-700 font-medium">${errorMessage}</p>
                    </div>
                </div>
            </c:if>

            <!-- Statistics Cards -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
                <div class="bg-white rounded-xl shadow-md border border-gray-100 p-4">
                    <div class="flex items-center">
                        <div class="h-12 w-12 bg-blue-100 rounded-lg flex items-center justify-center mr-3">
                            <svg class="h-6 w-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                            </svg>
                        </div>
                        <div>
                            <p class="text-2xl font-bold text-gray-900">${totalClubs}</p>
                            <p class="text-xs text-gray-600">Total Clubs</p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-md border border-gray-100 p-4">
                    <div class="flex items-center">
                        <div class="h-12 w-12 bg-green-100 rounded-lg flex items-center justify-center mr-3">
                            <svg class="h-6 w-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <div>
                            <p class="text-2xl font-bold text-gray-900">${activeCount}</p>
                            <p class="text-xs text-gray-600">Active Memberships</p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-md border border-gray-100 p-4">
                    <div class="flex items-center">
                        <div class="h-12 w-12 bg-yellow-100 rounded-lg flex items-center justify-center mr-3">
                            <svg class="h-6 w-6 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <div>
                            <p class="text-2xl font-bold text-gray-900">${pendingCount}</p>
                            <p class="text-xs text-gray-600">Pending Requests</p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-md border border-gray-100 p-4">
                    <div class="flex items-center">
                        <div class="h-12 w-12 bg-purple-100 rounded-lg flex items-center justify-center mr-3">
                            <svg class="h-6 w-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                            </svg>
                        </div>
                        <div>
                            <p class="text-2xl font-bold text-gray-900">${availableCount}</p>
                            <p class="text-xs text-gray-600">Available to Join</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- My Active Clubs Section -->
            <div class="mb-8">
                <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
                    <h2 class="text-xl font-bold text-gray-900 mb-4">
                        My Active Clubs (${activeCount})
                    </h2>
                    
                    <c:choose>
                        <c:when test="${empty activeClubs}">
                            <div class="text-center py-8">
                                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                </svg>
                                <p class="mt-2 text-sm text-gray-600">You don't have any active club memberships.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <c:forEach var="club" items="${activeClubs}">
                                    <div class="border-l-4 border-green-500 bg-green-50 rounded-r-lg p-4 hover:shadow-md transition duration-200">
                                        <div class="flex items-start justify-between">
                                            <div class="flex-1">
                                                <h3 class="text-lg font-semibold text-gray-900">${club.clubName}</h3>
                                                <span class="inline-flex items-center px-2 py-1 rounded-md bg-green-200 text-green-800 text-xs font-medium mt-2">
                                                    ✓ Active Member
                                                </span>
                                            </div>
                                        </div>
                                        <p class="text-sm text-gray-600 mt-3"><strong>Category:</strong> ${club.clubCategory}</p>
                                        <p class="text-sm text-gray-700 mt-2">${club.clubDescription}</p>
                                        <div class="mt-4">
                                            <a href="${pageContext.request.contextPath}/user/leave-club?clubID=${club.clubID}" 
                                               onclick="return confirm('Request to leave ${club.clubName}? This requires committee approval.')"
                                               class="text-sm text-red-600 hover:text-red-800 font-medium">
                                                Request to Leave Club
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- My Pending Requests Section -->
            <c:if test="${not empty pendingClubs}">
                <div class="mb-8">
                    <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
                        <h2 class="text-xl font-bold text-gray-900 mb-4">
                            My Pending Requests (${pendingCount})
                        </h2>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <c:forEach var="club" items="${pendingClubs}">
                                <div class="border-l-4 border-yellow-500 bg-yellow-50 rounded-r-lg p-4 hover:shadow-md transition duration-200">
                                    <div class="flex items-start justify-between">
                                        <div class="flex-1">
                                            <h3 class="text-lg font-semibold text-gray-900">${club.clubName}</h3>
                                            <span class="inline-flex items-center px-2 py-1 rounded-md bg-yellow-200 text-yellow-800 text-xs font-medium mt-2">
                                                ⏳ Pending Approval
                                            </span>
                                        </div>
                                    </div>
                                    <p class="text-sm text-gray-600 mt-3"><strong>Category:</strong> ${club.clubCategory}</p>
                                    <p class="text-sm text-gray-700 mt-2">${club.clubDescription}</p>
                                    <div class="mt-4">
                                        <a href="${pageContext.request.contextPath}/user/cancel-request?clubID=${club.clubID}" 
                                           onclick="return confirm('Cancel your request to join ${club.clubName}?')"
                                           class="text-sm text-orange-600 hover:text-orange-800 font-medium">
                                            Cancel Request
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Available Clubs Section -->
            <div>
                <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
                    <h2 class="text-xl font-bold text-gray-900 mb-4">
                        Available Clubs to Join (${availableCount})
                    </h2>
                    
                    <c:choose>
                        <c:when test="${empty availableClubs}">
                            <div class="text-center py-8">
                                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                <p class="mt-2 text-sm text-gray-600">No clubs available to join. You've either joined or requested to join all clubs!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                <c:forEach var="club" items="${availableClubs}">
                                    <div class="border border-gray-200 bg-white rounded-lg p-4 hover:shadow-lg hover:border-blue-300 transition duration-200">
                                        <h3 class="text-lg font-semibold text-gray-900">${club.clubName}</h3>
                                        <span class="inline-flex items-center px-2 py-1 rounded-md bg-gray-100 text-gray-700 text-xs font-medium mt-2">
                                            ${club.clubCategory}
                                        </span>
                                        <p class="text-sm text-gray-700 mt-3">${club.clubDescription}</p>
                                        <div class="mt-4">
                                            <a href="${pageContext.request.contextPath}/user/join-club?clubID=${club.clubID}" 
                                               onclick="return confirm('Request to join ${club.clubName}? This requires committee approval.')"
                                               class="inline-flex items-center px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition duration-200">
                                                <svg class="h-4 w-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                                </svg>
                                                Request to Join
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <script>
            // Auto-hide messages after 5 seconds
            setTimeout(function() {
                var messages = document.querySelectorAll('[style*="border: 1px solid green"], [style*="border: 1px solid red"]');
                messages.forEach(function(message) {
                    message.style.display = 'none';
                });
            }, 5000);
        </script>
    </body>
</html>