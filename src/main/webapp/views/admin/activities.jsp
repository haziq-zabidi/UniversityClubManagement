<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Activities - UCMS</title>
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
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <!-- Page Header -->
        <div class="mb-8">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Manage Activities</h1>
                    <p class="text-gray-600 mt-1">Oversee and manage all club activities</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/dashboard" 
                   class="px-4 py-2 bg-gray-600 text-white text-sm font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                    ← Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Activities Table -->
        <div class="bg-white rounded-xl shadow-md border border-gray-100 overflow-hidden">
            <div class="p-6 border-b border-gray-200">
                <h2 class="text-xl font-bold text-gray-900">All Activities (${activities.size()})</h2>
            </div>
            
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-gray-50 border-b border-gray-200">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Activity Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Status</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Club ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${activities}" var="a">
                            <tr class="hover:bg-gray-50">
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${a.activityID}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${a.activityName}</td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${a.activityStatus == 'Open'}">
                                            <span class="px-2 py-1 text-xs font-medium rounded-full bg-green-100 text-green-800">Open</span>
                                        </c:when>
                                        <c:when test="${a.activityStatus == 'Closed'}">
                                            <span class="px-2 py-1 text-xs font-medium rounded-full bg-gray-100 text-gray-800">Closed</span>
                                        </c:when>
                                        <c:when test="${a.activityStatus == 'Cancelled'}">
                                            <span class="px-2 py-1 text-xs font-medium rounded-full bg-red-100 text-red-800">Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="px-2 py-1 text-xs font-medium rounded-full bg-blue-100 text-blue-800">${a.activityStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${a.clubID}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm">
                                    <div class="flex items-center space-x-3">
                                        <!-- Update Status Form -->
                                        <form method="post" action="${pageContext.request.contextPath}/admin/activities" class="flex items-center space-x-2">
                                            <input type="hidden" name="action" value="status">
                                            <input type="hidden" name="activityID" value="${a.activityID}">
                                            <select name="activityStatus" 
                                                    class="px-3 py-1 text-sm border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent bg-white">
                                                <option value="Open" ${a.activityStatus=='Open'?'selected':''}>Open</option>
                                                <option value="Closed" ${a.activityStatus=='Closed'?'selected':''}>Closed</option>
                                                <option value="Cancelled" ${a.activityStatus=='Cancelled'?'selected':''}>Cancelled</option>
                                            </select>
                                            <button type="submit" 
                                                    class="px-3 py-1 bg-purple-600 text-white text-sm font-medium rounded hover:bg-purple-700 transition duration-200">
                                                Update
                                            </button>
                                        </form>
                                        
                                        <!-- View Button -->
                                        <a href="${pageContext.request.contextPath}/admin/activity/view?id=${a.activityID}"
                                           class="px-3 py-1 bg-blue-600 text-white text-sm font-medium rounded hover:bg-blue-700 transition duration-200">
                                            View
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>