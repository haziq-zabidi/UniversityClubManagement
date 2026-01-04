<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activity Participants - UCMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        @media print {
            .no-print { display: none !important; }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 via-white to-indigo-50 min-h-screen">
    
    <!-- Navigation Bar -->
    <nav class="bg-white shadow-lg border-b border-gray-200 no-print">
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
        
        <!-- Page Header -->
        <div class="mb-8 no-print">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Activity Participants</h1>
                    <p class="text-gray-600 mt-1">View and manage participant list</p>
                </div>
                <a href="${pageContext.request.contextPath}/committee/manage-activities?clubID=${clubID}" 
                   class="px-4 py-2 bg-gray-600 text-white text-sm font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                    ← Back to Activities
                </a>
            </div>
        </div>

        <!-- Activity Details Card -->
        <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6 mb-6">
            <h2 class="text-2xl font-bold text-gray-900 mb-4">${activity.activityName}</h2>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="space-y-2">
                    <div class="flex items-start">
                        <span class="font-medium text-gray-700 w-32">Type:</span>
                        <span class="text-gray-600">${activity.activityType}</span>
                    </div>
                    <div class="flex items-start">
                        <span class="font-medium text-gray-700 w-32">Location:</span>
                        <span class="text-gray-600">${activity.activityLocation}</span>
                    </div>
                    <div class="flex items-start">
                        <span class="font-medium text-gray-700 w-32">Description:</span>
                        <span class="text-gray-600">${activity.activityDescription}</span>
                    </div>
                </div>
                
                <div class="space-y-2">
                    <div class="flex items-start">
                        <span class="font-medium text-gray-700 w-32">Start Date:</span>
                        <span class="text-gray-600">${activity.startDate}</span>
                    </div>
                    <div class="flex items-start">
                        <span class="font-medium text-gray-700 w-32">End Date:</span>
                        <span class="text-gray-600">${activity.endDate}</span>
                    </div>
                    <div class="flex items-start">
                        <span class="font-medium text-gray-700 w-32">Status:</span>
                        <c:choose>
                            <c:when test="${activity.activityStatus == 'Open'}">
                                <span class="px-2 py-1 text-xs font-medium rounded-full bg-green-100 text-green-800">Open</span>
                            </c:when>
                            <c:otherwise>
                                <span class="px-2 py-1 text-xs font-medium rounded-full bg-gray-100 text-gray-800">Closed</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="flex items-start">
                        <span class="font-medium text-gray-700 w-32">Capacity:</span>
                        <span class="text-gray-600">${fn:length(participants)} / ${activity.maxParticipants} participants</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Statistics Cards -->
        <c:if test="${not empty participants}">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6 no-print">
                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600">Total Registered</p>
                            <p class="text-3xl font-bold text-blue-600 mt-2">${fn:length(participants)}</p>
                        </div>
                        <div class="h-12 w-12 bg-blue-100 rounded-lg flex items-center justify-center">
                            <svg class="h-6 w-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600">Max Capacity</p>
                            <p class="text-3xl font-bold text-purple-600 mt-2">${activity.maxParticipants}</p>
                        </div>
                        <div class="h-12 w-12 bg-purple-100 rounded-lg flex items-center justify-center">
                            <svg class="h-6 w-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                            </svg>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-md p-6 border border-gray-100">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-medium text-gray-600">Slots Remaining</p>
                            <p class="text-3xl font-bold text-green-600 mt-2">${activity.maxParticipants - fn:length(participants)}</p>
                        </div>
                        <div class="h-12 w-12 bg-green-100 rounded-lg flex items-center justify-center">
                            <svg class="h-6 w-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Participants List -->
        <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
            <div class="flex items-center justify-between mb-4 no-print">
                <h2 class="text-xl font-bold text-gray-900">Registered Participants (${fn:length(participants)})</h2>
                <div class="flex space-x-2">
                    <button onclick="exportToCSV()" 
                            class="px-4 py-2 bg-green-600 text-white text-sm font-medium rounded-lg hover:bg-green-700 transition duration-200">
                        Export CSV
                    </button>
                    <button onclick="window.print()" 
                            class="px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded-lg hover:bg-blue-700 transition duration-200">
                        Print List
                    </button>
                </div>
            </div>
            
            <c:choose>
                <c:when test="${empty participants}">
                    <div class="text-center py-12">
                        <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                        </svg>
                        <p class="mt-2 text-sm text-gray-600">No participants registered yet</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50 border-b border-gray-200">
                                <tr>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">#</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Name</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Email</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Matric No</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Faculty</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Programme</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Registration Date</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase no-print">Status</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200">
                                <c:forEach items="${participants}" var="attendance" varStatus="status">
                                    <tr class="hover:bg-gray-50">
                                        <td class="px-4 py-4 text-sm text-gray-600">${status.index + 1}</td>
                                        <td class="px-4 py-4 text-sm font-medium text-gray-900">${attendance.user.userName}</td>
                                        <td class="px-4 py-4 text-sm text-gray-600">${attendance.user.userEmail}</td>
                                        <td class="px-4 py-4 text-sm text-gray-600">${attendance.user.matricNo}</td>
                                        <td class="px-4 py-4 text-sm text-gray-600">${attendance.user.faculty}</td>
                                        <td class="px-4 py-4 text-sm text-gray-600">${attendance.user.programme}</td>
                                        <td class="px-4 py-4 text-sm text-gray-600">${attendance.attendanceDate}</td>
                                        <td class="px-4 py-4 no-print">
                                            <c:choose>
                                                <c:when test="${attendance.attendanceStatus == 'Present'}">
                                                    <span class="px-2 py-1 text-xs font-medium rounded-full bg-green-100 text-green-800">
                                                        Registered
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2 py-1 text-xs font-medium rounded-full bg-yellow-100 text-yellow-800">
                                                        ${attendance.attendanceStatus}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        function exportToCSV() {
            var csv = 'Name,Email,Matric No,Faculty,Programme,Registration Date,Status\n';
            
            <c:forEach items="${participants}" var="attendance">
                csv += '"${attendance.user.userName}",';
                csv += '"${attendance.user.userEmail}",';
                csv += '"${attendance.user.matricNo}",';
                csv += '"${attendance.user.faculty}",';
                csv += '"${attendance.user.programme}",';
                csv += '"${attendance.attendanceDate}",';
                csv += '"${attendance.attendanceStatus}"\n';
            </c:forEach>
            
            var blob = new Blob([csv], { type: 'text/csv' });
            var url = window.URL.createObjectURL(blob);
            var a = document.createElement('a');
            a.href = url;
            a.download = '${activity.activityName}_participants.csv';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        }
    </script>
</body>
</html>