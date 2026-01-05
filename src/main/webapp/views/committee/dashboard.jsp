<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Committee Dashboard - UCMS</title>
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
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                        </svg>
                    </div>
                    <div>
                        <span class="text-xl font-bold text-gray-900">UCMS</span>
                        <span class="ml-2 text-xs font-medium text-white bg-purple-600 px-2 py-1 rounded">Committee</span>
                    </div>
                </div>
                
                <!-- Navigation Links -->
                <div class="hidden md:flex space-x-4">
                    <a href="${pageContext.request.contextPath}/committee/dashboard" 
                       class="px-3 py-2 rounded-md text-sm font-medium bg-blue-100 text-blue-700">
                        Dashboard
                    </a>
                    <c:if test="${not empty clubsList && clubsList.size() > 0}">
                        <a href="${pageContext.request.contextPath}/committee/manage-announcements?clubID=${clubsList[0].clubID}" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            Announcements
                        </a>
                        <a href="${pageContext.request.contextPath}/committee/manage-activities?clubID=${clubsList[0].clubID}" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            Activities
                        </a>
                        <a href="${pageContext.request.contextPath}/committee/manage-members?action=view&clubID=${clubsList[0].clubID}" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            View Members
                        </a>
                    </c:if>
                    
                </div>
                
                <!-- Logout Button -->
                <div class="flex items-center">
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
        
        <!-- Welcome Section -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900">Committee Dashboard</h1>
            <p class="text-gray-600 mt-1">Manage your club activities and members</p>
        </div>

        <!-- Quick Stats Section -->
        <c:if test="${not empty clubsList}">
            <div class="mb-6 grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- Total Members Card -->
                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600">Total Members</p>
                            <p class="text-3xl font-bold text-gray-900 mt-2">${totalMembers}</p>
                            <p class="text-xs text-gray-500 mt-1">Across all clubs</p>
                        </div>
                        <div class="h-12 w-12 bg-blue-100 rounded-lg flex items-center justify-center">
                            <svg class="h-6 w-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Active Activities Card -->
                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600">Active Activities</p>
                            <p class="text-3xl font-bold text-gray-900 mt-2">${totalActivities}</p>
                            <p class="text-xs text-gray-500 mt-1">Ongoing events</p>
                        </div>
                        <div class="h-12 w-12 bg-green-100 rounded-lg flex items-center justify-center">
                            <svg class="h-6 w-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"></path>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Announcements Card -->
                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600">Announcements</p>
                            <p class="text-3xl font-bold text-gray-900 mt-2">${totalAnnouncements}</p>
                            <p class="text-xs text-gray-500 mt-1">Published posts</p>
                        </div>
                        <div class="h-12 w-12 bg-yellow-100 rounded-lg flex items-center justify-center">
                            <svg class="h-6 w-6 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"></path>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Your Clubs Section -->
        <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-xl font-bold text-gray-900">Your Clubs</h2>
                <span class="text-sm font-medium text-gray-500 bg-gray-100 px-3 py-1 rounded-full">
                    <c:choose>
                        <c:when test="${empty clubsList}">0 clubs</c:when>
                        <c:otherwise>${clubsList.size()} club(s)</c:otherwise>
                    </c:choose>
                </span>
            </div>
            
            <c:choose>
                <c:when test="${empty clubsList}">
                    <!-- Empty State -->
                    <div class="text-center py-12">
                        <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
                        </svg>
                        <h3 class="mt-2 text-sm font-medium text-gray-900">No clubs assigned</h3>
                        <p class="mt-1 text-sm text-gray-500">You are not assigned as committee member to any club yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Clubs Grid -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <c:forEach var="club" items="${clubsList}">
                            <div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-xl p-6 border border-blue-200 hover:shadow-lg transition duration-200">
                                <!-- Club Header -->
                                <div class="flex items-start justify-between mb-4">
                                    <div class="flex-1">
                                        <h3 class="text-lg font-bold text-gray-900 mb-1">${club.clubName}</h3>
                                        <span class="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-blue-200 text-blue-800">
                                            ${club.clubCategory}
                                        </span>
                                    </div>
                                    <div class="h-10 w-10 bg-blue-600 rounded-lg flex items-center justify-center flex-shrink-0">
                                        <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                        </svg>
                                    </div>
                                </div>
                                
                                <!-- Club Description -->
                                <p class="text-sm text-gray-600 mb-4 line-clamp-2">${club.clubDescription}</p>
                                
                                <!-- Club Stats -->
                                <c:if test="${not empty clubStats[club.clubID]}">
                                    <div class="mb-4 grid grid-cols-3 gap-2">
                                        <div class="bg-white rounded-lg p-2 text-center">
                                            <p class="text-xs text-gray-600">Members</p>
                                            <p class="text-lg font-bold text-blue-600">${clubStats[club.clubID].members}</p>
                                        </div>
                                        <div class="bg-white rounded-lg p-2 text-center">
                                            <p class="text-xs text-gray-600">Activities</p>
                                            <p class="text-lg font-bold text-green-600">${clubStats[club.clubID].activities}</p>
                                        </div>
                                        <div class="bg-white rounded-lg p-2 text-center">
                                            <p class="text-xs text-gray-600">Posts</p>
                                            <p class="text-lg font-bold text-yellow-600">${clubStats[club.clubID].announcements}</p>
                                        </div>
                                    </div>
                                </c:if>
                                
                                <!-- Management Actions -->
                                <div class="space-y-2">
                                    <a href="${pageContext.request.contextPath}/committee/manage-announcements?clubID=${club.clubID}" 
                                       class="flex items-center justify-between w-full px-4 py-2 bg-white rounded-lg hover:bg-blue-100 transition duration-200 group">
                                        <div class="flex items-center">
                                            <svg class="h-5 w-5 text-blue-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"></path>
                                            </svg>
                                            <span class="text-sm font-medium text-gray-700">Announcements</span>
                                        </div>
                                        <svg class="h-4 w-4 text-gray-400 group-hover:text-blue-600 transition duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                                        </svg>
                                    </a>
                                    
                                    <a href="${pageContext.request.contextPath}/committee/manage-activities?clubID=${club.clubID}" 
                                       class="flex items-center justify-between w-full px-4 py-2 bg-white rounded-lg hover:bg-blue-100 transition duration-200 group">
                                        <div class="flex items-center">
                                            <svg class="h-5 w-5 text-green-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                            </svg>
                                            <span class="text-sm font-medium text-gray-700">Activities</span>
                                        </div>
                                        <svg class="h-4 w-4 text-gray-400 group-hover:text-green-600 transition duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                                        </svg>
                                    </a>
                                    
                                    <a href="${pageContext.request.contextPath}/committee/manage-members?action=view&clubID=${club.clubID}" 
                                       class="flex items-center justify-between w-full px-4 py-2 bg-white rounded-lg hover:bg-blue-100 transition duration-200 group">
                                        <div class="flex items-center">
                                            <svg class="h-5 w-5 text-purple-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                                            </svg>
                                            <span class="text-sm font-medium text-gray-700">View Members</span>
                                        </div>
                                        <svg class="h-4 w-4 text-gray-400 group-hover:text-purple-600 transition duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                                        </svg>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>