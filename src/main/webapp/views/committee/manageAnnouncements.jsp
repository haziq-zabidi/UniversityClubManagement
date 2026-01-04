<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                        Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/committee/manage-announcements?clubID=${clubID}" 
                       class="px-3 py-2 rounded-md text-sm font-medium bg-blue-100 text-blue-700">
                        Announcements
                    </a>
                    <a href="${pageContext.request.contextPath}/committee/manage-activities?clubID=${clubID}" 
                       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                        Activities
                    </a>
                    <a href="${pageContext.request.contextPath}/committee/manage-members?action=view&clubID=${clubID}" 
                       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                        View Members
                    </a>
                    <a href="${pageContext.request.contextPath}/committee/profile" 
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
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <!-- Page Header -->
        <div class="mb-8">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Manage Announcements</h1>
                    <p class="text-gray-600 mt-1">Create and manage club announcements</p>
                </div>
                <a href="${pageContext.request.contextPath}/committee/dashboard" 
                   class="px-4 py-2 bg-gray-600 text-white text-sm font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                    ← Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Create Announcement Card -->
        <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6 mb-6">
            <div class="flex items-center mb-4">
                <div class="h-10 w-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3">
                    <svg class="h-6 w-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                    </svg>
                </div>
                <h2 class="text-xl font-bold text-gray-900">Create New Announcement</h2>
            </div>
            
            <form action="${pageContext.request.contextPath}/committee/manage-announcements" method="post">
                <input type="hidden" name="action" value="create"/>
                <input type="hidden" name="clubID" value="${clubID}"/>
                
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Title *</label>
                        <input type="text" name="title" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                               placeholder="Enter announcement title">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Message *</label>
                        <textarea name="message" required rows="4"
                                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                  placeholder="Enter your announcement message"></textarea>
                    </div>
                    
                    <div class="flex justify-end">
                        <button type="submit" 
                                class="px-6 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition duration-200 shadow-md">
                            Publish Announcement
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Announcements List -->
        <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
            <h2 class="text-xl font-bold text-gray-900 mb-4">All Announcements</h2>
            
            <c:choose>
                <c:when test="${empty announcementsList}">
                    <div class="text-center py-12">
                        <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"></path>
                        </svg>
                        <p class="mt-2 text-sm text-gray-600">No announcements created yet</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="space-y-4">
                        <c:forEach var="a" items="${announcementsList}">
                            <div class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition duration-200">
                                <div class="flex items-start justify-between mb-3">
                                    <div class="flex-1">
                                        <h3 class="text-lg font-semibold text-gray-900">${a.announcementTitle}</h3>
                                        <p class="text-sm text-gray-500 mt-1">Published on: ${a.publishDate}</p>
                                    </div>
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                        Active
                                    </span>
                                </div>
                                
                                <p class="text-gray-700 mb-4">${a.announcementMessage}</p>
                                
                                <!-- Edit Form -->
                                <div class="border-t border-gray-200 pt-4 mt-4">
                                    <form action="${pageContext.request.contextPath}/committee/manage-announcements" method="post">
                                        <input type="hidden" name="action" value="edit"/>
                                        <input type="hidden" name="clubID" value="${clubID}"/>
                                        <input type="hidden" name="announcementID" value="${a.announcementID}"/>
                                        
                                        <div class="space-y-3">
                                            <div>
                                                <label class="block text-sm font-medium text-gray-700 mb-1">Edit Title</label>
                                                <input type="text" name="title" value="${a.announcementTitle}" required
                                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-sm">
                                            </div>
                                            
                                            <div>
                                                <label class="block text-sm font-medium text-gray-700 mb-1">Edit Message</label>
                                                <textarea name="message" required rows="3"
                                                          class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-sm">${a.announcementMessage}</textarea>
                                            </div>
                                            
                                            <div class="flex items-center space-x-3">
                                                <button type="submit" 
                                                        class="px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition duration-200">
                                                    Save Changes
                                                </button>
                                                <button type="button" 
                                                        onclick="document.getElementById('deleteForm${a.announcementID}').submit()"
                                                        class="px-4 py-2 bg-red-600 text-white text-sm font-medium rounded-lg hover:bg-red-700 transition duration-200">
                                                    Delete
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                    
                                    <!-- Delete Form (Hidden) -->
                                    <form id="deleteForm${a.announcementID}" 
                                          action="${pageContext.request.contextPath}/committee/manage-announcements" 
                                          method="post" 
                                          onsubmit="return confirm('Are you sure you want to delete this announcement?')">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="clubID" value="${clubID}"/>
                                        <input type="hidden" name="announcementID" value="${a.announcementID}"/>
                                    </form>
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