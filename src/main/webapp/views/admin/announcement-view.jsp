<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Announcement Details - UCMS</title>
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
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <!-- Page Header -->
        <div class="mb-8">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Announcement Details</h1>
                    <p class="text-gray-600 mt-1">View complete announcement information</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/announcements" 
                   class="px-4 py-2 bg-gray-600 text-white text-sm font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                    ← Back to Announcements
                </a>
            </div>
        </div>

        <!-- Announcement Details Card -->
        <div class="bg-white rounded-xl shadow-md border border-gray-100 overflow-hidden">
            <div class="p-6 bg-gradient-to-r from-yellow-600 to-orange-600">
                <div class="flex items-center">
                    <div class="h-12 w-12 bg-white bg-opacity-20 rounded-lg flex items-center justify-center mr-4">
                        <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"></path>
                        </svg>
                    </div>
                    <h2 class="text-2xl font-bold text-white">${announcement.announcementTitle}</h2>
                </div>
            </div>
            
            <div class="p-6">
                <!-- Metadata -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                    <div class="bg-blue-50 rounded-lg p-4">
                        <p class="text-xs font-medium text-blue-600 uppercase tracking-wider mb-1">Club Name</p>
                        <p class="text-lg font-semibold text-gray-900">${announcement.clubName}</p>
                    </div>
                    
                    <div class="bg-purple-50 rounded-lg p-4">
                        <p class="text-xs font-medium text-purple-600 uppercase tracking-wider mb-1">Author</p>
                        <p class="text-lg font-semibold text-gray-900">${announcement.authorName}</p>
                    </div>
                    
                    <div class="bg-green-50 rounded-lg p-4">
                        <p class="text-xs font-medium text-green-600 uppercase tracking-wider mb-1">Published Date</p>
                        <p class="text-lg font-semibold text-gray-900">${announcement.publishDate}</p>
                    </div>
                </div>
                
                <!-- Message Content -->
                <div class="border-t border-gray-200 pt-6">
                    <h3 class="text-sm font-medium text-gray-500 uppercase tracking-wider mb-3">Announcement Message</h3>
                    <div class="prose max-w-none">
                        <p class="text-gray-900 leading-relaxed text-lg">${announcement.announcementMessage}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="mt-6 flex justify-between items-center">
            <a href="${pageContext.request.contextPath}/admin/announcements" 
               class="px-6 py-3 bg-gray-600 text-white font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                ← Back to All Announcements
            </a>
            
            <div class="flex space-x-3">
                <a href="${pageContext.request.contextPath}/admin/announcement/edit?id=${announcement.announcementID}" 
                   class="px-6 py-3 bg-yellow-600 text-white font-medium rounded-lg hover:bg-yellow-700 transition duration-200">
                    Edit Announcement
                </a>
            </div>
        </div>
    </div>
</body>
</html>