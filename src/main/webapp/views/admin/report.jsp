<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Report - ${currentMonth}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        @media print {
            .no-print { display: none; }
            body { background: white; }
        }
    </style>
</head>
<body class="bg-gray-50">
    
    <!-- Navigation Bar -->
    <nav class="bg-white shadow-lg border-b border-gray-200 no-print">
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
                       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100 hover:text-gray-900">
                        Manage Activities
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/announcements" 
                       class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100 hover:text-gray-900">
                        Manage Announcements
                    </a>
                </div>
                
                <!-- Print & Logout Buttons -->
                <div class="flex items-center space-x-3">
                    <button onclick="window.print()" 
                            class="px-4 py-2 bg-indigo-600 text-white text-sm font-medium rounded-lg hover:bg-indigo-700 transition duration-200">
                        🖨️ Print
                    </button>
                    <a href="${pageContext.request.contextPath}/logout" 
                       class="px-4 py-2 bg-red-600 text-white text-sm font-medium rounded-lg hover:bg-red-700 transition duration-200">
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </nav>
    
    <!-- Report Header -->
    <div class="bg-gradient-to-r from-red-600 to-orange-600 text-white py-6">
        <div class="max-w-7xl mx-auto px-4">
            <h1 class="text-2xl font-bold">System Analytics Report</h1>
            <p class="text-red-100 mt-1">${currentMonth}</p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 py-8">
        
        <!-- Report Info -->
        <div class="bg-white rounded-xl shadow-md p-6 mb-6">
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-2xl font-bold text-gray-900">Monthly System Report</h2>
                    <p class="text-gray-600 mt-1">Generated on: ${reportDate}</p>
                </div>
                <div class="text-right">
                    <div class="text-sm text-gray-500">Report Period</div>
                    <div class="text-lg font-bold text-gray-900">${currentMonth}</div>
                </div>
            </div>
        </div>

        <!-- Executive Summary -->
        <div class="bg-white rounded-xl shadow-md p-6 mb-6">
            <h3 class="text-xl font-bold text-gray-900 mb-4">📊 Executive Summary</h3>
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                <div class="text-center p-4 bg-blue-50 rounded-lg">
                    <div class="text-4xl font-bold text-blue-600">${totalClubs}</div>
                    <div class="text-sm text-gray-600 mt-2">Total Clubs</div>
                </div>
                <div class="text-center p-4 bg-green-50 rounded-lg">
                    <div class="text-4xl font-bold text-green-600">${totalUsers}</div>
                    <div class="text-sm text-gray-600 mt-2">Total Users</div>
                </div>
                <div class="text-center p-4 bg-purple-50 rounded-lg">
                    <div class="text-4xl font-bold text-purple-600">${totalActivities}</div>
                    <div class="text-sm text-gray-600 mt-2">Total Activities</div>
                </div>
                <div class="text-center p-4 bg-yellow-50 rounded-lg">
                    <div class="text-4xl font-bold text-yellow-600">${totalAnnouncements}</div>
                    <div class="text-sm text-gray-600 mt-2">Announcements</div>
                </div>
            </div>
        </div>

        <!-- User Analytics -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
            
            <!-- User Distribution -->
            <div class="bg-white rounded-xl shadow-md p-6">
                <h3 class="text-xl font-bold text-gray-900 mb-4">👥 User Distribution</h3>
                <div class="space-y-4">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <div class="h-10 w-10 bg-red-100 rounded-lg flex items-center justify-center mr-3">
                                <span class="text-red-600 font-bold">A</span>
                            </div>
                            <div>
                                <div class="font-semibold text-gray-900">Administrators</div>
                                <div class="text-sm text-gray-500">System admins</div>
                            </div>
                        </div>
                        <div class="text-2xl font-bold text-gray-900">${adminCount}</div>
                    </div>
                    
                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <div class="h-10 w-10 bg-purple-100 rounded-lg flex items-center justify-center mr-3">
                                <span class="text-purple-600 font-bold">C</span>
                            </div>
                            <div>
                                <div class="font-semibold text-gray-900">Committee Members</div>
                                <div class="text-sm text-gray-500">Club managers</div>
                            </div>
                        </div>
                        <div class="text-2xl font-bold text-gray-900">${committeeCount}</div>
                    </div>
                    
                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <div class="h-10 w-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3">
                                <span class="text-blue-600 font-bold">S</span>
                            </div>
                            <div>
                                <div class="font-semibold text-gray-900">Students</div>
                                <div class="text-sm text-gray-500">Club members</div>
                            </div>
                        </div>
                        <div class="text-2xl font-bold text-gray-900">${studentCount}</div>
                    </div>
                </div>
                
                <div class="mt-6">
                    <div style="max-width: 300px; margin: 0 auto;">
                        <canvas id="userRoleChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Faculty Distribution -->
            <div class="bg-white rounded-xl shadow-md p-6">
                <h3 class="text-xl font-bold text-gray-900 mb-4">🎓 Faculty Distribution</h3>
                <div class="space-y-3">
                    <c:forEach var="entry" items="${facultyDistribution}">
                        <div class="flex items-center justify-between">
                            <div class="flex-1">
                                <div class="text-sm font-medium text-gray-900">${entry.key}</div>
                                <div class="w-full bg-gray-200 rounded-full h-2 mt-1">
                                    <div class="bg-blue-600 h-2 rounded-full" 
                                         style="width: ${entry.value * 100 / totalUsers}%"></div>
                                </div>
                            </div>
                            <div class="ml-4 text-lg font-bold text-gray-900">${entry.value}</div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="mt-6">
                    <div style="max-width: 300px; margin: 0 auto;">
                        <canvas id="facultyChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Activity Statistics -->
        <div class="bg-white rounded-xl shadow-md p-6 mb-6">
            <h3 class="text-xl font-bold text-gray-900 mb-4">📅 Activity Statistics</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="text-center p-6 bg-green-50 rounded-lg">
                    <div class="text-3xl font-bold text-green-600">${activeActivities}</div>
                    <div class="text-sm text-gray-600 mt-2">Active Activities</div>
                    <div class="text-xs text-gray-500 mt-1">Currently open</div>
                </div>
                <div class="text-center p-6 bg-blue-50 rounded-lg">
                    <div class="text-3xl font-bold text-blue-600">${completedActivities}</div>
                    <div class="text-sm text-gray-600 mt-2">Closed</div>
                    <div class="text-xs text-gray-500 mt-1">Successfully finished</div>
                </div>
                <div class="text-center p-6 bg-gray-50 rounded-lg">
                    <div class="text-3xl font-bold text-gray-600">${cancelledActivities}</div>
                    <div class="text-sm text-gray-600 mt-2">Cancelled</div>
                    <div class="text-xs text-gray-500 mt-1">Did not proceed</div>
                </div>
            </div>
            
            <div class="mt-6">
                <canvas id="activityChart"></canvas>
            </div>
        </div>

        <!-- Attendance Statistics -->
        <div class="bg-white rounded-xl shadow-md p-6 mb-6">
            <h3 class="text-xl font-bold text-gray-900 mb-4">✓ Attendance Overview</h3>
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                <div class="text-center p-6 bg-indigo-50 rounded-lg">
                    <div class="text-3xl font-bold text-indigo-600">${totalAttendanceRecords}</div>
                    <div class="text-sm text-gray-600 mt-2">Total Records</div>
                </div>
                <div class="text-center p-6 bg-green-50 rounded-lg">
                    <div class="text-3xl font-bold text-green-600">${presentCount}</div>
                    <div class="text-sm text-gray-600 mt-2">Present</div>
                </div>
                <div class="text-center p-6 bg-red-50 rounded-lg">
                    <div class="text-3xl font-bold text-red-600">${absentCount}</div>
                    <div class="text-sm text-gray-600 mt-2">Absent</div>
                </div>
                <div class="text-center p-6 bg-purple-50 rounded-lg">
                    <div class="text-3xl font-bold text-purple-600">${attendanceRate}%</div>
                    <div class="text-sm text-gray-600 mt-2">Attendance Rate</div>
                </div>
            </div>
            
            <div class="mt-6">
                <div style="max-width: 300px; margin: 0 auto;">
                    <canvas id="attendanceChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Club Performance Table -->
        <div class="bg-white rounded-xl shadow-md p-6 mb-6">
            <h3 class="text-xl font-bold text-gray-900 mb-4">🏆 Club Performance Summary</h3>
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead>
                        <tr class="border-b border-gray-200">
                            <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700">Club Name</th>
                            <th class="text-left py-3 px-4 font-semibold text-sm text-gray-700">Category</th>
                            <th class="text-center py-3 px-4 font-semibold text-sm text-gray-700">Members</th>
                            <th class="text-center py-3 px-4 font-semibold text-sm text-gray-700">Activities</th>
                            <th class="text-center py-3 px-4 font-semibold text-sm text-gray-700">Announcements</th>
                            <th class="text-center py-3 px-4 font-semibold text-sm text-gray-700">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="club" items="${clubStats}">
                            <tr class="border-b border-gray-100 hover:bg-gray-50">
                                <td class="py-3 px-4 text-sm font-medium text-gray-900">${club.clubName}</td>
                                <td class="py-3 px-4">
                                    <span class="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-blue-100 text-blue-800">
                                        ${club.category}
                                    </span>
                                </td>
                                <td class="py-3 px-4 text-center text-sm text-gray-900">${club.memberCount}</td>
                                <td class="py-3 px-4 text-center text-sm text-gray-900">${club.activityCount}</td>
                                <td class="py-3 px-4 text-center text-sm text-gray-900">${club.announcementCount}</td>
                                <td class="py-3 px-4 text-center">
                                    <c:choose>
                                        <c:when test="${club.memberCount > 0 && club.activityCount > 0}">
                                            <span class="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-green-100 text-green-800">
                                                Active
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-yellow-100 text-yellow-800">
                                                Inactive
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Footer -->
        <div class="bg-white rounded-xl shadow-md p-6 text-center mb-6">
            <p class="text-sm text-gray-600">
                This report was automatically generated by the University Club Management System
            </p>
            <p class="text-xs text-gray-500 mt-2">
                © 2025 UCMS - All rights reserved
            </p>
        </div>
    </div>

    <!-- Charts Script -->
    <script>
        // User Role Distribution Chart
        const userRoleCtx = document.getElementById('userRoleChart').getContext('2d');
        new Chart(userRoleCtx, {
            type: 'doughnut',
            data: {
                labels: ['Admins', 'Committee', 'Students'],
                datasets: [{
                    data: [${adminCount}, ${committeeCount}, ${studentCount}],
                    backgroundColor: ['#ef4444', '#a855f7', '#3b82f6'],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        // Faculty Distribution Chart
        const facultyCtx = document.getElementById('facultyChart').getContext('2d');
        new Chart(facultyCtx, {
            type: 'pie',
            data: {
                labels: [<c:forEach var="entry" items="${facultyDistribution}" varStatus="status">'${entry.key}'${!status.last ? ',' : ''}</c:forEach>],
                datasets: [{
                    data: [<c:forEach var="entry" items="${facultyDistribution}" varStatus="status">${entry.value}${!status.last ? ',' : ''}</c:forEach>],
                    backgroundColor: ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899', '#14b8a6', '#f97316']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        // Activity Status Chart
        const activityCtx = document.getElementById('activityChart').getContext('2d');
        new Chart(activityCtx, {
            type: 'bar',
            data: {
                labels: ['Active', 'Closed', 'Cancelled'],
                datasets: [{
                    label: 'Activities',
                    data: [${activeActivities}, ${completedActivities}, ${cancelledActivities}],
                    backgroundColor: ['#10b981', '#3b82f6', '#6b7280'],
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Attendance Chart
        const attendanceCtx = document.getElementById('attendanceChart').getContext('2d');
        new Chart(attendanceCtx, {
            type: 'doughnut',
            data: {
                labels: ['Present', 'Absent'],
                datasets: [{
                    data: [${presentCount}, ${absentCount}],
                    backgroundColor: ['#10b981', '#ef4444'],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    </script>
</body>
</html>