<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Clubs - UCMS Admin</title>
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
                
                <div class="hidden md:flex space-x-4">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" 
                       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                        Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/manage-clubs" 
                       class="px-3 py-2 rounded-md text-sm font-medium bg-red-100 text-red-700">
                        Manage Clubs
                    </a>
                </div>
                
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
            <h1 class="text-3xl font-bold text-gray-900">Manage Clubs</h1>
            <p class="text-gray-600 mt-1">Create, edit, and assign committee members to clubs</p>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-r-lg">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <svg class="h-5 w-5 text-red-400" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm text-red-700 font-medium">${errorMessage}</p>
                    </div>
                </div>
            </div>
        </c:if>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            
            <!-- Form Section (Left) -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
                    <c:choose>
                        <c:when test="${not empty editClub}">
                            <h2 class="text-xl font-bold text-gray-900 mb-4">Edit Club</h2>
                            <form action="${pageContext.request.contextPath}/admin/manage-clubs" method="post" class="space-y-4">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="clubID" value="${editClub.clubID}">
                                
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Club Name</label>
                                    <input type="text" name="clubName" value="${editClub.clubName}" required 
                                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none">
                                </div>
                                
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Description</label>
                                    <textarea name="clubDescription" rows="4" required 
                                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none">${editClub.clubDescription}</textarea>
                                </div>
                                
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Category</label>
                                    <input type="text" name="clubCategory" value="${editClub.clubCategory}" required 
                                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none">
                                </div>
                                
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Committee Member</label>
                                    <select name="adminUserID" required 
                                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none bg-white">
                                        <option value="">-- Select User --</option>
                                        <c:forEach var="user" items="${allUsers}">
                                            <option value="${user.userID}" ${editClub.adminUserID == user.userID ? 'selected' : ''}>
                                                ${user.userName} - ${user.userEmail}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <p class="text-xs text-gray-500 mt-1">This user will become the committee member for this club</p>
                                </div>
                                
                                <div class="flex space-x-3 pt-2">
                                    <button type="submit" 
                                            class="flex-1 bg-blue-600 text-white font-semibold py-2 px-4 rounded-lg hover:bg-blue-700 transition duration-200">
                                        Update Club
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/manage-clubs" 
                                       class="flex-1 text-center bg-gray-200 text-gray-700 font-semibold py-2 px-4 rounded-lg hover:bg-gray-300 transition duration-200">
                                        Cancel
                                    </a>
                                </div>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <h2 class="text-xl font-bold text-gray-900 mb-4">Create New Club</h2>
                            <form action="${pageContext.request.contextPath}/admin/manage-clubs" method="post" class="space-y-4">
                                <input type="hidden" name="action" value="create">
                                
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Club Name</label>
                                    <input type="text" name="clubName" required 
                                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                                           placeholder="e.g., Robotics Club">
                                </div>
                                
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Description</label>
                                    <textarea name="clubDescription" rows="4" required 
                                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                                              placeholder="Describe the club's purpose and activities..."></textarea>
                                </div>
                                
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Category</label>
                                    <input type="text" name="clubCategory" required 
                                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                                           placeholder="e.g., Engineering, Arts, Sports">
                                </div>
                                
                                <div>
                                    <label class="block text-sm font-semibold text-gray-700 mb-2">Assign Committee Member</label>
                                    <select name="adminUserID" required 
                                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none bg-white">
                                        <option value="">-- Select User --</option>
                                        <c:forEach var="user" items="${allUsers}">
                                            <option value="${user.userID}">
                                                ${user.userName} - ${user.userEmail}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <p class="text-xs text-gray-500 mt-1">This user will become the committee member for this club</p>
                                </div>
                                
                                <div class="pt-2">
                                    <button type="submit" 
                                            class="w-full bg-green-600 text-white font-semibold py-2 px-4 rounded-lg hover:bg-green-700 transition duration-200">
                                        Create Club
                                    </button>
                                </div>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Table Section (Right) -->
            <div class="lg:col-span-2">
                <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
                    <h2 class="text-xl font-bold text-gray-900 mb-4">All Clubs (${clubs.size()})</h2>
                    
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="border-b border-gray-200">
                                    <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700">ID</th>
                                    <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700">Name</th>
                                    <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700">Category</th>
                                    <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700">Committee</th>
                                    <th class="text-center py-3 px-4 font-semibold text-sm text-gray-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="club" items="${clubs}">
                                    <tr class="border-b border-gray-100 hover:bg-gray-50">
                                        <td class="py-3 px-4 text-sm text-gray-900">${club.clubID}</td>
                                        <td class="py-3 px-4">
                                            <div class="text-sm font-medium text-gray-900">${club.clubName}</div>
                                            <div class="text-xs text-gray-500 truncate max-w-xs">${club.clubDescription}</div>
                                        </td>
                                        <td class="py-3 px-4">
                                            <span class="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-blue-100 text-blue-800">
                                                ${club.clubCategory}
                                            </span>
                                        </td>
                                        <td class="py-3 px-4 text-sm text-gray-600">
                                            <c:forEach var="user" items="${allUsers}">
                                                <c:if test="${user.userID == club.adminUserID}">
                                                    <div class="text-sm font-medium text-gray-900">${user.userName}</div>
                                                    <div class="text-xs text-gray-500">${user.userEmail}</div>
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td class="py-3 px-4 text-center">
                                            <div class="flex items-center justify-center space-x-2">
                                                <a href="${pageContext.request.contextPath}/admin/manage-clubs?editID=${club.clubID}" 
                                                   class="inline-flex items-center px-3 py-1 bg-blue-100 text-blue-700 text-xs font-medium rounded hover:bg-blue-200 transition duration-200">
                                                    <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                                    </svg>
                                                    Edit
                                                </a>
                                                
                                                <form action="${pageContext.request.contextPath}/admin/manage-clubs" method="post" style="display:inline">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="clubID" value="${club.clubID}">
                                                    <button type="submit" 
                                                            onclick="return confirm('Are you sure you want to delete ${club.clubName}?')"
                                                            class="inline-flex items-center px-3 py-1 bg-red-100 text-red-700 text-xs font-medium rounded hover:bg-red-200 transition duration-200">
                                                        <svg class="h-4 w-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                                        </svg>
                                                        Delete
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
        </div>

        <!-- Back Button -->
        <div class="mt-6">
            <a href="${pageContext.request.contextPath}/admin/dashboard" 
               class="inline-flex items-center text-sm font-medium text-gray-600 hover:text-gray-900">
                <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                </svg>
                Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>