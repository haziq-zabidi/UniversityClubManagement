<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activity Details - UCMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-50 via-white to-gray-50 min-h-screen">
    
    <!-- Navigation Bar -->
    <nav class="bg-white shadow-lg border-b border-gray-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <!-- Logo & Title -->
                <div class="flex items-center">
                    <div class="h-10 w-10 bg-gradient-to-br from-red-600 to-orange-600 rounded-lg flex items-center justify-center mr-3">
                        <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                        </svg>
                    </div>
                    <div>
                        <span class="text-xl font-bold text-gray-900">UCMS</span>
                        <span class="ml-2 text-xs font-medium text-white bg-red-600 px-2 py-1 rounded">Admin</span>
                    </div>
                </div>
                
                <!-- Navigation Links -->
<div class="hidden md:flex space-x-1">
    <a href="${pageContext.request.contextPath}/admin/dashboard" 
       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100 hover:text-gray-900">
        Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/admin/manage-clubs" 
       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100 hover:text-gray-900">
        Manage Clubs
    </a>
    <a href="${pageContext.request.contextPath}/admin/manage-users" 
       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100 hover:text-gray-900">
        Manage Users
    </a>
    <a href="${pageContext.request.contextPath}/admin/activities" 
       class="px-3 py-2 rounded-md text-sm font-medium bg-red-100 text-red-700">
        Manage Activities
    </a>
    <a href="${pageContext.request.contextPath}/admin/announcements" 
       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100 hover:text-gray-900">
        Manage Announcements
    </a>
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
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <!-- Page Header -->
        <div class="mb-8">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Activity Details</h1>
                    <p class="text-gray-600 mt-1">View complete information about this activity</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/activities" 
                   class="px-4 py-2 bg-gray-600 text-white text-sm font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                    ← Back to Activities
                </a>
            </div>
        </div>

        <!-- Activity Details Card -->
        <div class="bg-white rounded-xl shadow-md border border-gray-100 overflow-hidden">
            <div class="p-6 bg-gradient-to-r from-purple-600 to-indigo-600">
                <h2 class="text-2xl font-bold text-white">${activity.activityName}</h2>
            </div>
            
            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Left Column -->
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-500 mb-1">Activity ID</label>
                            <p class="text-lg font-semibold text-gray-900">${activity.activityID}</p>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-500 mb-1">Activity Type</label>
                            <p class="text-lg text-gray-900">${activity.activityType}</p>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-500 mb-1">Status</label>
                            <p class="text-lg">
                                <c:choose>
                                    <c:when test="${activity.activityStatus == 'Open'}">
                                        <span class="px-3 py-1 text-sm font-medium rounded-full bg-green-100 text-green-800">Open</span>
                                    </c:when>
                                    <c:when test="${activity.activityStatus == 'Closed'}">
                                        <span class="px-3 py-1 text-sm font-medium rounded-full bg-gray-100 text-gray-800">Closed</span>
                                    </c:when>
                                    <c:when test="${activity.activityStatus == 'Cancelled'}">
                                        <span class="px-3 py-1 text-sm font-medium rounded-full bg-red-100 text-red-800">Cancelled</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="px-3 py-1 text-sm font-medium rounded-full bg-blue-100 text-blue-800">${activity.activityStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-500 mb-1">Location</label>
                            <p class="text-lg text-gray-900">${activity.activityLocation}</p>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-500 mb-1">Club ID</label>
                            <p class="text-lg text-gray-900">${activity.clubID}</p>
                        </div>
                    </div>
                    
                    <!-- Right Column -->
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-500 mb-1">Start Date</label>
                            <p class="text-lg text-gray-900">${activity.startDate}</p>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-500 mb-1">End Date</label>
                            <p class="text-lg text-gray-900">${activity.endDate}</p>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-500 mb-1">Max Participants</label>
                            <p class="text-lg text-gray-900">${activity.maxParticipants}</p>
                        </div>
                    </div>
                </div>
                
                <!-- Description (Full Width) -->
                <div class="mt-6 pt-6 border-t border-gray-200">
                    <label class="block text-sm font-medium text-gray-500 mb-2">Description</label>
                    <p class="text-gray-900 leading-relaxed">${activity.activityDescription}</p>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="mt-6 flex justify-between items-center">
            <a href="${pageContext.request.contextPath}/admin/activities" 
               class="px-6 py-3 bg-gray-600 text-white font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                ← Back to All Activities
            </a>
        </div>
    </div>
</body>
</html>