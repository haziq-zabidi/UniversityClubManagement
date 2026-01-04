<%-- 
    Document   : manageUser
    Created on : 2 Jan 2026, 6:12:54 pm
    Author     : TUF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Profile - UCMS</title>
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
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                            </svg>
                        </div>
                        <span class="text-xl font-bold text-gray-900">UCMS</span>
                    </div>
                    
                    <!-- Navigation Links -->
                    <div class="hidden md:flex space-x-4">
                        <a href="${pageContext.request.contextPath}/user/dashboard" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/user/clubs" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            My Clubs
                        </a>
                        <a href="${pageContext.request.contextPath}/user/announcements" 
                           class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-100">
                            Announcements
                        </a>
                        <a href="${pageContext.request.contextPath}/user/profile" 
                           class="px-3 py-2 rounded-md text-sm font-medium bg-blue-100 text-blue-700">
                            Profile
                        </a>
                    </div>
                    
                    <!-- User Menu -->
                    <div class="flex items-center">
                        <span class="text-sm font-medium text-gray-700 mr-4">Hi, ${userName}!</span>
                        <a href="${pageContext.request.contextPath}/logout" 
                           class="px-4 py-2 bg-red-600 text-white text-sm font-medium rounded-lg hover:bg-red-700 transition duration-200">
                            Logout
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            
            <!-- Page Header -->
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900">My Profile</h1>
                <p class="text-gray-600 mt-1">Manage your personal information and security settings</p>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="mb-6 bg-green-50 border-l-4 border-green-500 p-4 rounded-r-lg">
                    <div class="flex items-center">
                        <svg class="h-5 w-5 text-green-500 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                        <p class="text-green-700 font-medium">${successMessage}</p>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-r-lg">
                    <div class="flex items-center">
                        <svg class="h-5 w-5 text-red-500 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                        <p class="text-red-700 font-medium">${errorMessage}</p>
                    </div>
                </div>
            </c:if>

            <!-- Profile Information Card -->
            <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6 mb-6">
                <div class="flex items-center mb-6">
                    <div class="h-12 w-12 bg-gradient-to-br from-purple-500 to-pink-500 rounded-lg flex items-center justify-center mr-4">
                        <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <div>
                        <h2 class="text-xl font-bold text-gray-900">Personal Information</h2>
                        <p class="text-sm text-gray-600">Update your profile details</p>
                    </div>
                </div>
                
                <form action="${pageContext.request.contextPath}/user/profile" method="POST">
                    <input type="hidden" name="action" value="update_profile">
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Full Name</label>
                            <input type="text" name="userName" value="${user.userName}" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Email Address</label>
                            <input type="email" name="userEmail" value="${user.userEmail}" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Matric Number</label>
                            <input type="text" name="matricNo" value="${user.matricNo}"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Faculty</label>
                            <select name="faculty" id="faculty"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                <option value="">-- Select Faculty --</option>
                                <option value="Engineering" ${user.faculty == 'Engineering' ? 'selected' : ''}>Faculty of Engineering</option>
                                <option value="Science" ${user.faculty == 'Science' ? 'selected' : ''}>Faculty of Science</option>
                                <option value="Medicine" ${user.faculty == 'Medicine' ? 'selected' : ''}>Faculty of Medicine</option>
                                <option value="Arts" ${user.faculty == 'Arts' ? 'selected' : ''}>Faculty of Arts & Humanities</option>
                                <option value="Business" ${user.faculty == 'Business' ? 'selected' : ''}>Faculty of Business & Management</option>
                                <option value="Law" ${user.faculty == 'Law' ? 'selected' : ''}>Faculty of Law</option>
                                <option value="Education" ${user.faculty == 'Education' ? 'selected' : ''}>Faculty of Education</option>
                                <option value="Computer Science" ${user.faculty == 'Computer Science' ? 'selected' : ''}>Faculty of Computer Science & IT</option>
                                <option value="Social Sciences" ${user.faculty == 'Social Sciences' ? 'selected' : ''}>Faculty of Social Sciences</option>
                                <option value="Architecture" ${user.faculty == 'Architecture' ? 'selected' : ''}>Faculty of Architecture & Planning</option>
                            </select>
                        </div>
                        
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Programme</label>
                            <select name="programme" id="programme"
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white">
                                <option value="">-- Select Programme --</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="mt-6 flex justify-end">
                        <button type="submit" 
                                class="px-6 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition duration-200 shadow-md">
                            Update Profile
                        </button>
                    </div>
                </form>
            </div>

            <!-- Change Password Card -->
            <div class="bg-white rounded-xl shadow-md border border-gray-100 p-6">
                <div class="flex items-center mb-6">
                    <div class="h-12 w-12 bg-gradient-to-br from-orange-500 to-red-500 rounded-lg flex items-center justify-center mr-4">
                        <svg class="h-6 w-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                        </svg>
                    </div>
                    <div>
                        <h2 class="text-xl font-bold text-gray-900">Security Settings</h2>
                        <p class="text-sm text-gray-600">Update your password to keep your account secure</p>
                    </div>
                </div>
                
                <form action="${pageContext.request.contextPath}/user/profile" method="POST" id="passwordForm">
                    <input type="hidden" name="action" value="change_password">
                    
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Current Password</label>
                            <input type="password" name="currentPassword" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">New Password</label>
                            <input type="password" name="newPassword" id="newPassword" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            <p class="text-xs text-gray-500 mt-1">Password must be at least 8 characters long</p>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Confirm New Password</label>
                            <input type="password" name="confirmPassword" id="confirmPassword" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                    </div>
                    
                    <div class="mt-6 flex justify-end">
                        <button type="submit" 
                                class="px-6 py-2 bg-orange-600 text-white font-medium rounded-lg hover:bg-orange-700 transition duration-200 shadow-md">
                            Change Password
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            // Programme options for each faculty
            const programmes = {
                'Engineering': [
                    'Civil Engineering',
                    'Mechanical Engineering',
                    'Electrical Engineering',
                    'Chemical Engineering',
                    'Aerospace Engineering',
                    'Industrial Engineering'
                ],
                'Science': [
                    'Physics',
                    'Chemistry',
                    'Biology',
                    'Mathematics',
                    'Environmental Science',
                    'Biotechnology'
                ],
                'Medicine': [
                    'Medicine (MBBS)',
                    'Nursing',
                    'Pharmacy',
                    'Dentistry',
                    'Medical Laboratory Science',
                    'Physiotherapy'
                ],
                'Arts': [
                    'English Literature',
                    'History',
                    'Philosophy',
                    'Languages & Linguistics',
                    'Performing Arts',
                    'Fine Arts'
                ],
                'Business': [
                    'Business Administration',
                    'Accounting',
                    'Finance',
                    'Marketing',
                    'Human Resource Management',
                    'Entrepreneurship'
                ],
                'Law': [
                    'Bachelor of Laws (LLB)',
                    'Legal Studies',
                    'International Law',
                    'Criminal Justice'
                ],
                'Education': [
                    'Early Childhood Education',
                    'Primary Education',
                    'Secondary Education',
                    'Educational Psychology',
                    'Special Education',
                    'Educational Administration'
                ],
                'Computer Science': [
                    'Computer Science',
                    'Software Engineering',
                    'Information Technology',
                    'Data Science',
                    'Cybersecurity',
                    'Artificial Intelligence'
                ],
                'Social Sciences': [
                    'Psychology',
                    'Sociology',
                    'Political Science',
                    'Economics',
                    'Anthropology',
                    'International Relations'
                ],
                'Architecture': [
                    'Architecture',
                    'Urban Planning',
                    'Landscape Architecture',
                    'Interior Design',
                    'Quantity Surveying',
                    'Building Technology'
                ]
            };

            // Get the faculty and programme dropdowns
            const facultySelect = document.getElementById('faculty');
            const programmeSelect = document.getElementById('programme');
            
            // Store the current programme value
            const currentProgramme = "${user.programme}";

            // Update programme options when faculty changes
            facultySelect.addEventListener('change', function() {
                const selectedFaculty = this.value;
                
                // Clear existing options
                programmeSelect.innerHTML = '<option value="">-- Select Programme --</option>';
                
                // Add new options based on selected faculty
                if (selectedFaculty && programmes[selectedFaculty]) {
                    programmes[selectedFaculty].forEach(function(prog) {
                        const option = document.createElement('option');
                        option.value = prog;
                        option.textContent = prog;
                        programmeSelect.appendChild(option);
                    });
                }
            });

            // Initialize programme options on page load
            window.addEventListener('DOMContentLoaded', function() {
                const currentFaculty = "${user.faculty}";
                
                if (currentFaculty && programmes[currentFaculty]) {
                    // Trigger change to populate programmes
                    facultySelect.dispatchEvent(new Event('change'));
                    
                    // Set the current programme after options are loaded
                    setTimeout(function() {
                        if (currentProgramme) {
                            programmeSelect.value = currentProgramme;
                        }
                    }, 100);
                }
            });
        
            // Auto-hide messages after 5 seconds
            setTimeout(function() {
                var messages = document.querySelectorAll('div');
                messages.forEach(function(message) {
                    if (message.innerHTML.includes('Success:') || message.innerHTML.includes('Error:')) {
                        message.style.display = 'none';
                    }
                });
            }, 5000);
            
            // Password confirmation validation
            document.getElementById('passwordForm').addEventListener('submit', function(e) {
                var newPassword = document.getElementById('newPassword').value;
                var confirmPassword = document.getElementById('confirmPassword').value;
                
                if (newPassword !== confirmPassword) {
                    e.preventDefault();
                    alert('New passwords do not match!');
                    return false;
                }
                
                if (newPassword.length < 8) {
                    e.preventDefault();
                    alert('Password must be at least 8 characters long!');
                    return false;
                }
                
                return true;
            });
        </script>
    </body>
</html>