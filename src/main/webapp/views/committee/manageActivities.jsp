<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        .modal {
            display: none;
            position: fixed;
            z-index: 50;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        .modal.show {
            display: flex;
            align-items: center;
            justify-content: center;
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
                           class="px-3 py-2 rounded-md text-sm font-medium bg-blue-100 text-blue-700">
                            Activities
                        </a>
                        <a href="${pageContext.request.contextPath}/committee/manage-members?action=view&clubID=${clubID}" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            View Members
                        </a>
                    </c:if>
                    
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
                    <h1 class="text-3xl font-bold text-gray-900">Manage Activities</h1>
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
            <!-- Create Activity Button -->
            <div class="mb-6">
                <button onclick="openModal('createActivityModal')" 
                        class="px-6 py-3 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition duration-200 shadow-md">
                    <svg class="inline h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                    </svg>
                    Create New Activity
                </button>
            </div>

            <!-- Activities List -->
            <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
                <h2 class="text-xl font-bold text-gray-900 mb-4">Activities (${fn:length(activitiesList)})</h2>
                
                <c:choose>
                    <c:when test="${empty activitiesList}">
                        <div class="text-center py-12">
                            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                            </svg>
                            <p class="mt-2 text-sm text-gray-600">No activities created yet</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-gray-50 border-b border-gray-200">
                                    <tr>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Activity Name</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Type</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Location</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Date</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Status</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Participants</th>
                                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200">
                                    <c:forEach items="${activitiesList}" var="activity">
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-4 py-4 text-sm font-medium text-gray-900">${activity.activityName}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${activity.activityType}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${activity.activityLocation}</td>
                                            <td class="px-4 py-4 text-sm text-gray-600">${activity.startDate}</td>
                                            <td class="px-4 py-4">
                                                <c:choose>
                                                    <c:when test="${activity.activityStatus == 'Open'}">
                                                        <span class="px-2 py-1 text-xs font-medium rounded-full bg-green-100 text-green-800">Open</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="px-2 py-1 text-xs font-medium rounded-full bg-gray-100 text-gray-800">Closed</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-4 py-4">
                                                <a href="${pageContext.request.contextPath}/committee/manage-activities?action=viewParticipants&activityID=${activity.activityID}" 
                                                   class="text-blue-600 hover:text-blue-800 font-medium text-sm">
                                                    ${activity.currentParticipants}/${activity.maxParticipants}
                                                </a>
                                            </td>
                                            <td class="px-4 py-4">
                                                <div class="flex items-center space-x-2">
                                                    <button onclick="editActivity(${activity.activityID}, '${activity.activityName}', '${activity.activityDescription}', '${activity.activityType}', '${activity.activityLocation}', '${activity.startDate}', '${activity.endDate}', ${activity.maxParticipants})"
                                                            class="text-yellow-600 hover:text-yellow-800">
                                                        <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                                        </svg>
                                                    </button>
                                                    <form action="${pageContext.request.contextPath}/committee/manage-activities" method="post" 
                                                          onsubmit="return confirm('Delete this activity?');">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="activityID" value="${activity.activityID}">
                                                        <input type="hidden" name="clubID" value="${clubID}">
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
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>

    <!-- Create Activity Modal -->
    <div id="createActivityModal" class="modal">
        <div class="bg-white rounded-xl shadow-2xl max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto">
            <div class="p-6 border-b border-gray-200">
                <h3 class="text-xl font-bold text-gray-900">Create New Activity</h3>
            </div>
            <form action="${pageContext.request.contextPath}/committee/manage-activities" method="post">
                <div class="p-6 space-y-4">
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="clubID" value="${clubID}">
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Activity Name *</label>
                        <input type="text" name="activityName" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Description</label>
                        <textarea name="activityDescription" rows="3"
                                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Activity Type *</label>
                            <select name="activityType" required
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                <option value="">Select Type</option>
                                <option value="Workshop">Workshop</option>
                                <option value="Seminar">Seminar</option>
                                <option value="Lecture">Lecture</option>
                                <option value="Competition">Competition</option>
                                <option value="Social Event">Social Event</option>
                                <option value="Training">Training</option>
                            </select>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Location *</label>
                            <input type="text" name="activityLocation" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Start Date *</label>
                            <input type="date" name="startDate" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">End Date *</label>
                            <input type="date" name="endDate" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Max Participants *</label>
                        <input type="number" name="maxParticipants" min="1" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                </div>
                <div class="p-6 border-t border-gray-200 flex justify-end space-x-3">
                    <button type="button" onclick="closeModal('createActivityModal')"
                            class="px-4 py-2 bg-gray-600 text-white font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                        Cancel
                    </button>
                    <button type="submit"
                            class="px-4 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition duration-200">
                        Create Activity
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit Activity Modal -->
    <div id="editActivityModal" class="modal">
        <div class="bg-white rounded-xl shadow-2xl max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto">
            <div class="p-6 border-b border-gray-200">
                <h3 class="text-xl font-bold text-gray-900">Edit Activity</h3>
            </div>
            <form action="${pageContext.request.contextPath}/committee/manage-activities" method="post">
                <div class="p-6 space-y-4">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="clubID" value="${clubID}">
                    <input type="hidden" name="activityID" id="editActivityID">
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Activity Name *</label>
                        <input type="text" name="activityName" id="editActivityName" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Description</label>
                        <textarea name="activityDescription" id="editActivityDescription" rows="3"
                                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Activity Type *</label>
                            <select name="activityType" id="editActivityType" required
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                <option value="Workshop">Workshop</option>
                                <option value="Seminar">Seminar</option>
                                <option value="Lecture">Lecture</option>
                                <option value="Competition">Competition</option>
                                <option value="Social Event">Social Event</option>
                                <option value="Training">Training</option>
                            </select>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Location *</label>
                            <input type="text" name="activityLocation" id="editActivityLocation" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Start Date *</label>
                            <input type="date" name="startDate" id="editStartDate" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">End Date *</label>
                            <input type="date" name="endDate" id="editEndDate" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Max Participants *</label>
                        <input type="number" name="maxParticipants" id="editMaxParticipants" min="1" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                </div>
                <div class="p-6 border-t border-gray-200 flex justify-end space-x-3">
                    <button type="button" onclick="closeModal('editActivityModal')"
                            class="px-4 py-2 bg-gray-600 text-white font-medium rounded-lg hover:bg-gray-700 transition duration-200">
                        Cancel
                    </button>
                    <button type="submit"
                            class="px-4 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition duration-200">
                        Update Activity
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModal(modalId) {
            document.getElementById(modalId).classList.add('show');
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('show');
        }
        
        function editActivity(id, name, desc, type, location, startDate, endDate, maxPart) {
            document.getElementById('editActivityID').value = id;
            document.getElementById('editActivityName').value = name;
            document.getElementById('editActivityDescription').value = desc;
            document.getElementById('editActivityType').value = type;
            document.getElementById('editActivityLocation').value = location;
            document.getElementById('editStartDate').value = startDate;
            document.getElementById('editEndDate').value = endDate;
            document.getElementById('editMaxParticipants').value = maxPart;
            openModal('editActivityModal');
        }
        
        window.onclick = function(event) {
            if (event.target.classList.contains('modal')) {
                event.target.classList.remove('show');
            }
        }
    </script>
</body>
</html>