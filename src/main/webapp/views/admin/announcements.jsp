<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Announcements - UCMS</title>
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
                <div class="hidden md:flex space-x-4">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" 
                       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                        Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/announcements" 
                       class="px-3 py-2 rounded-md text-sm font-medium bg-red-100 text-red-700">
                        Manage Announcements
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/profile" 
                       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                        Profile
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
                    <h1 class="text-3xl font-bold text-gray-900">Manage Announcements</h1>
                    <p class="text-gray-600 mt-1">Monitor and manage all club announcements</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/dashboard" 
                   class="px-4 py-2 bg-gray-600 text-white text-sm font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                    ← Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Announcements Table -->
        <div class="bg-white rounded-xl shadow-md border border-gray-100 overflow-hidden">
            <div class="p-6 border-b border-gray-200">
                <h2 class="text-xl font-bold text-gray-900">All Announcements (${announcements.size()})</h2>
            </div>
            
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-gray-50 border-b border-gray-200">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Title</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Club</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Author</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Published Date</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="a" items="${announcements}">
                            <tr class="hover:bg-gray-50">
                                <td class="px-6 py-4 text-sm font-medium text-gray-900">${a.announcementTitle}</td>
                                <td class="px-6 py-4 text-sm text-gray-600">${a.clubName}</td>
                                <td class="px-6 py-4 text-sm text-gray-600">${a.authorName}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${a.publishDate}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm">
                                    <div class="flex items-center space-x-2">
                                        <!-- View Button -->
                                        <a href="${pageContext.request.contextPath}/admin/announcement/view?id=${a.announcementID}"
                                           class="text-blue-600 hover:text-blue-800">
                                            <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                            </svg>
                                        </a>
                                        
                                        <!-- Edit Button -->
                                        <a href="${pageContext.request.contextPath}/admin/announcement/edit?id=${a.announcementID}"
                                           class="text-yellow-600 hover:text-yellow-800">
                                            <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                            </svg>
                                        </a>
                                        
                                        <!-- Delete Form -->
                                        <form action="${pageContext.request.contextPath}/admin/announcement/delete" 
                                              method="post" 
                                              onsubmit="return confirm('Delete this announcement?');">
                                            <input type="hidden" name="id" value="${a.announcementID}">
                                            <button type="submit" class="text-red-600 hover:text-red-800">
                                                <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                                </svg>
                                            </button>
                                        </form>
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