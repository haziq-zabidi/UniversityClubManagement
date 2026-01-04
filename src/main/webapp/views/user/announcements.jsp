<%-- 
    Document   : announcement
    Created on : 30 Dec 2025, 1:18:16 pm
    Author     : TUF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Announcements & Activities - UCMS</title>
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
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            My Clubs
                        </a>
                        <a href="${pageContext.request.contextPath}/user/announcements" 
                           class="px-3 py-2 rounded-md text-sm font-medium bg-blue-100 text-blue-700">
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
        <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            
            <!-- Page Header -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900">Announcements & Activities</h1>
                <p class="text-gray-600 mt-1">Stay updated with all club announcements and events</p>
            </div>

            <c:choose>
                <c:when test="${empty combinedFeed}">
                    <!-- Empty State -->
                    <div class="bg-white rounded-xl shadow-md border border-gray-100 p-12">
                        <div class="text-center">
                            <svg class="mx-auto h-16 w-16 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
                            </svg>
                            <h3 class="mt-4 text-lg font-medium text-gray-900">No announcements or activities yet</h3>
                            <p class="mt-2 text-sm text-gray-500">Join clubs to see their latest updates and events</p>
                            <div class="mt-6">
                                <a href="${pageContext.request.contextPath}/user/clubs" 
                                   class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700">
                                    Browse Clubs
                                </a>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Filter Options -->
                    <div class="bg-white rounded-xl shadow-md border border-gray-100 p-4 mb-6">
                        <div class="flex items-center justify-between">
                            <div>
                                <span class="text-sm font-medium text-gray-700 mr-3">Filter by:</span>
                                <div class="inline-flex rounded-lg border border-gray-200">
                                    <a href="${pageContext.request.contextPath}/user/announcements?filter=all" 
                                       class="px-4 py-2 text-sm font-medium ${param.filter == null || param.filter == 'all' ? 'bg-blue-600 text-white' : 'bg-white text-gray-700 hover:bg-gray-50'} rounded-l-lg">
                                        All
                                    </a>
                                    <a href="${pageContext.request.contextPath}/user/announcements?filter=announcements" 
                                       class="px-4 py-2 text-sm font-medium ${param.filter == 'announcements' ? 'bg-blue-600 text-white' : 'bg-white text-gray-700 hover:bg-gray-50'} border-l border-gray-200">
                                        Announcements Only
                                    </a>
                                    <a href="${pageContext.request.contextPath}/user/announcements?filter=activities" 
                                       class="px-4 py-2 text-sm font-medium ${param.filter == 'activities' ? 'bg-blue-600 text-white' : 'bg-white text-gray-700 hover:bg-gray-50'} border-l border-gray-200 rounded-r-lg">
                                        Activities Only
                                    </a>
                                </div>
                            </div>
                            <span class="text-sm font-medium text-gray-500 bg-gray-100 px-3 py-1 rounded-full">
                                ${totalCount} items
                            </span>
                        </div>
                    </div>

                    <!-- Feed Content -->
                    <div class="space-y-4">
                        <c:forEach var="item" items="${combinedFeed}">
                            
                            <!-- Announcement Item -->
                            <c:if test="${item.type == 'announcement'}">
                                <div class="bg-white rounded-xl shadow-md border border-gray-100 overflow-hidden hover:shadow-lg transition duration-200">
                                    <div class="border-l-4 border-blue-500 p-6">
                                        <div class="flex items-start">
                                            <div class="flex-shrink-0">
                                                <div class="h-12 w-12 bg-blue-100 rounded-lg flex items-center justify-center">
                                                    <svg class="h-6 w-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"></path>
                                                    </svg>
                                                </div>
                                            </div>
                                            <div class="ml-4 flex-1">
                                                <div class="flex items-start justify-between">
                                                    <div>
                                                        <h3 class="text-xl font-semibold text-gray-900">${item.title}</h3>
                                                        <p class="text-sm text-blue-600 font-medium mt-1">${item.clubName}</p>
                                                    </div>
                                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                                        Announcement
                                                    </span>
                                                </div>
                                                <p class="text-gray-700 mt-3">${item.message}</p>
                                                <div class="flex items-center mt-4 text-xs text-gray-500">
                                                    <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                                    </svg>
                                                    Published: ${item.date}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            
                            <!-- Activity Item -->
                            <c:if test="${item.type == 'activity'}">
                                <div class="bg-white rounded-xl shadow-md border border-gray-100 overflow-hidden hover:shadow-lg transition duration-200">
                                    <div class="border-l-4 border-green-500 p-6">
                                        <div class="flex items-start">
                                            <div class="flex-shrink-0">
                                                <div class="h-12 w-12 bg-green-100 rounded-lg flex items-center justify-center">
                                                    <svg class="h-6 w-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                                    </svg>
                                                </div>
                                            </div>
                                            <div class="ml-4 flex-1">
                                                <div class="flex items-start justify-between">
                                                    <div>
                                                        <h3 class="text-xl font-semibold text-gray-900">${item.title}</h3>
                                                        <p class="text-sm text-green-600 font-medium mt-1">${item.clubName}</p>
                                                    </div>
                                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium ${item.status == 'Open' ? 'bg-green-100 text-green-800' : item.status == 'Completed' ? 'bg-gray-100 text-gray-800' : 'bg-red-100 text-red-800'}">
                                                        ${item.status}
                                                    </span>
                                                </div>
                                                <p class="text-gray-700 mt-3">${item.description}</p>
                                                
                                                <div class="mt-4 grid grid-cols-1 md:grid-cols-3 gap-3">
                                                    <div class="flex items-center text-sm text-gray-600 bg-gray-50 rounded-lg p-2">
                                                        <svg class="h-5 w-5 text-gray-400 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                                        </svg>
                                                        <span>${item.date}<c:if test="${item.endDate != null}"> - ${item.endDate}</c:if></span>
                                                    </div>
                                                    
                                                    <div class="flex items-center text-sm text-gray-600 bg-gray-50 rounded-lg p-2">
                                                        <svg class="h-5 w-5 text-gray-400 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                                        </svg>
                                                        <span>${item.location}</span>
                                                    </div>
                                                    
                                                    <div class="flex items-center text-sm text-gray-600 bg-gray-50 rounded-lg p-2">
                                                        <svg class="h-5 w-5 text-gray-400 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                                        </svg>
                                                        <span>${item.maxParticipants > 0 ? item.maxParticipants : 'Unlimited'} participants</span>
                                                    </div>
                                                </div>

                                                <div class="mt-4">
                                                    <c:choose>
                                                        <c:when test="${item.status == 'Completed' or item.status == 'Cancelled'}">
                                                            <span class="text-sm text-gray-500 italic">Activity ${item.status}</span>
                                                        </c:when>
                                                        <c:when test="${item.userAttended}">
                                                            <div class="flex items-center space-x-3">
                                                                <span class="inline-flex items-center px-3 py-1 rounded-md bg-green-100 text-green-800 text-sm font-medium">
                                                                    <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                                    </svg>
                                                                    Attendance Marked
                                                                </span>
                                                                <a href="${pageContext.request.contextPath}/user/record-attendance?activityID=${item.id}&action=remove" 
                                                                   onclick="return confirm('Remove attendance?')"
                                                                   class="text-sm text-red-600 hover:text-red-800 font-medium">
                                                                    Remove Attendance
                                                                </a>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/user/record-attendance?activityID=${item.id}" 
                                                               onclick="return confirm('Mark attendance for this activity?')"
                                                               class="inline-flex items-center px-4 py-2 bg-green-600 text-white text-sm font-medium rounded-lg hover:bg-green-700 transition duration-200">
                                                                <svg class="h-4 w-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                                </svg>
                                                                Mark Attendance
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            
                        </c:forEach>
                    </div>

                    <!-- Summary Footer -->
                    <div class="mt-8 text-center">
                        <p class="text-sm text-gray-500">End of list • Total items: ${totalCount}</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>