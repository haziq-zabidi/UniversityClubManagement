<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Members - UCMS</title>
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
                
                <div class="hidden md:flex space-x-4">
                    <a href="${pageContext.request.contextPath}/committee/dashboard" 
                       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                        Dashboard
                    </a>
                    <c:if test="${not empty clubID}">
                        <a href="${pageContext.request.contextPath}/committee/manage-announcements?clubID=${clubID}" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            Announcements
                        </a>
                        <a href="${pageContext.request.contextPath}/committee/manage-activities?clubID=${clubID}" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            Activities
                        </a>
                        <a href="${pageContext.request.contextPath}/committee/manage-members?action=view&clubID=${clubID}" 
                           class="px-3 py-2 rounded-md text-sm font-medium bg-blue-100 text-blue-700">
                            View Members
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/committee/profile" 
                       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                        Profile
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

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <div class="mb-8">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Manage Members</h1>
                    <c:if test="${not empty club}">
                        <p class="text-gray-600 mt-1">${club.clubName}</p>
                    </c:if>
                </div>
                <a href="${pageContext.request.contextPath}/committee/dashboard" 
                   class="px-4 py-2 bg-gray-600 text-white text-sm font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                    ← Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="mb-6 bg-green-50 border-l-4 border-green-500 p-4 rounded-r-lg">
                <p class="text-green-700 font-medium">${successMessage}</p>
            </div>
            <% session.removeAttribute("successMessage"); %>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-r-lg">
                <p class="text-red-700 font-medium">${errorMessage}</p>
            </div>
            <% session.removeAttribute("errorMessage"); %>
        </c:if>

        <c:if test="${not empty club}">
            <!-- Pending Join Requests -->
            <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6 mb-6">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-xl font-bold text-gray-900">Pending Join Requests</h2>
                    <span class="text-sm font-medium text-gray-500 bg-blue-100 px-3 py-1 rounded-full">
                        ${fn:length(pendingJoinRequests)} pending
                    </span>
                </div>
                
                <c:choose>
                    <c:when test="${empty pendingJoinRequests}">
                        <div class="text-center py-8">
                            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                            <p class="mt-2 text-sm text-gray-600">No pending join requests</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-gray-50 border-b border-gray-200">
                                    <tr>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Name</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Email</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Matric No</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Faculty</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Request Date</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200">
                                    <c:forEach items="${pendingJoinRequests}" var="membership">
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-4 py-4 text-sm font-medium text-gray-900">${membership.user.userName}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.user.userEmail}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.user.matricNo}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.user.faculty}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.joinDate}</td>
                                            <td class="px-4 py-4">
                                                <div class="flex items-center space-x-2">
                                                    <form action="${pageContext.request.contextPath}/committee/manage-members" method="post">
                                                        <input type="hidden" name="action" value="approve">
                                                        <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                                        <input type="hidden" name="clubID" value="${clubID}">
                                                        <button type="submit" 
                                                                class="px-3 py-1 bg-green-600 text-white text-sm font-medium rounded hover:bg-green-700">
                                                            ✓ Approve
                                                        </button>
                                                    </form>
                                                    <form action="${pageContext.request.contextPath}/committee/manage-members" method="post">
                                                        <input type="hidden" name="action" value="reject">
                                                        <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                                        <input type="hidden" name="clubID" value="${clubID}">
                                                        <button type="submit" 
                                                                class="px-3 py-1 bg-red-600 text-white text-sm font-medium rounded hover:bg-red-700">
                                                            ✗ Reject
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Pending Leave Requests -->
            <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6 mb-6">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-xl font-bold text-gray-900">Pending Leave Requests</h2>
                    <span class="text-sm font-medium text-gray-500 bg-yellow-100 px-3 py-1 rounded-full">
                        ${fn:length(pendingLeaveRequests)} pending
                    </span>
                </div>
                
                <c:choose>
                    <c:when test="${empty pendingLeaveRequests}">
                        <div class="text-center py-8">
                            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                            <p class="mt-2 text-sm text-gray-600">No pending leave requests</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-gray-50 border-b border-gray-200">
                                    <tr>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Name</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Email</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Matric No</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Faculty</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Member Since</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200">
                                    <c:forEach items="${pendingLeaveRequests}" var="membership">
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-4 py-4 text-sm font-medium text-gray-900">${membership.user.userName}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.user.userEmail}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.user.matricNo}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.user.faculty}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.joinDate}</td>
                                            <td class="px-4 py-4">
                                                <div class="flex items-center space-x-2">
                                                    <form action="${pageContext.request.contextPath}/committee/manage-members" method="post" 
                                                          onsubmit="return confirm('Approve leave request?');">
                                                        <input type="hidden" name="action" value="approveLeave">
                                                        <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                                        <input type="hidden" name="clubID" value="${clubID}">
                                                        <button type="submit" 
                                                                class="px-3 py-1 bg-green-600 text-white text-sm font-medium rounded hover:bg-green-700">
                                                            ✓ Approve
                                                        </button>
                                                    </form>
                                                    <form action="${pageContext.request.contextPath}/committee/manage-members" method="post">
                                                        <input type="hidden" name="action" value="rejectLeave">
                                                        <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                                        <input type="hidden" name="clubID" value="${clubID}">
                                                        <button type="submit" 
                                                                class="px-3 py-1 bg-red-600 text-white text-sm font-medium rounded hover:bg-red-700">
                                                            ✗ Reject
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Active Members -->
            <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-xl font-bold text-gray-900">Active Members</h2>
                    <span class="text-sm font-medium text-gray-500 bg-green-100 px-3 py-1 rounded-full">
                        ${fn:length(activeMembers)} members
                    </span>
                </div>
                
                <c:choose>
                    <c:when test="${empty activeMembers}">
                        <div class="text-center py-8">
                            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                            </svg>
                            <p class="mt-2 text-sm text-gray-600">No active members yet</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-gray-50 border-b border-gray-200">
                                    <tr>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Name</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Email</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Matric No</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Faculty</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Join Date</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200">
                                    <c:forEach items="${activeMembers}" var="membership">
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-4 py-4 text-sm font-medium text-gray-900">${membership.user.userName}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.user.userEmail}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.user.matricNo}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.user.faculty}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${membership.joinDate}</td>
                                            <td class="px-4 py-4">
                                                <form action="${pageContext.request.contextPath}/committee/manage-members" method="post" 
                                                      onsubmit="return confirm('Remove this member?');">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                                    <input type="hidden" name="clubID" value="${clubID}">
                                                    <button type="submit" 
                                                            class="px-3 py-1 bg-orange-600 text-white text-sm font-medium rounded hover:bg-orange-700">
                                                        Remove
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</body>
</html>