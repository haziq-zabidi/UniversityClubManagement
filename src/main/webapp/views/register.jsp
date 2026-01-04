<%-- 
    Document   : register
    Created on : 27 Dec 2025, 2:45:42 am
    Author     : TUF
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - University Club Management System</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
        </style>
    </head>
    <body class="bg-gradient-to-br from-blue-50 via-white to-indigo-50 min-h-screen py-8 px-4">
        <div class="max-w-6xl mx-auto">
            <!-- Header Section -->
            <div class="text-center mb-8">
                <div class="mx-auto h-16 w-16 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-xl flex items-center justify-center mb-4 shadow-lg">
                    <svg class="h-10 w-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                    </svg>
                </div>
                <h2 class="text-3xl font-bold text-gray-900">Create Account</h2>
                <p class="mt-2 text-sm text-gray-600">Join the University Club Management System</p>
            </div>

            <!-- Error Message Display -->
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
                <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-r-lg max-w-4xl mx-auto">
                    <div class="flex">
                        <div class="flex-shrink-0">
                            <svg class="h-5 w-5 text-red-400" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm text-red-700 font-medium"><%= errorMessage %></p>
                        </div>
                    </div>
                </div>
            <% } %>

            <!-- Registration Form -->
            <div class="bg-white shadow-xl rounded-2xl p-8 border border-gray-100">
                <form method="POST" action="register" id="registerForm">
                    
                    <!-- Row 1: Username and Email -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <!-- Username Field -->
                        <div>
                            <label for="userName" class="block text-sm font-semibold text-gray-700 mb-2">Full Name</label>
                            <input type="text" 
                                   id="userName"
                                   name="userName" 
                                   value="<%= request.getAttribute("userName") != null ? request.getAttribute("userName") : "" %>"
                                   required 
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200 outline-none"
                                   placeholder="Enter your full name">
                        </div>

                        <!-- Email Field -->
                        <div>
                            <label for="userEmail" class="block text-sm font-semibold text-gray-700 mb-2">Email Address</label>
                            <input type="email" 
                                   id="userEmail"
                                   name="userEmail" 
                                   value="<%= request.getAttribute("userEmail") != null ? request.getAttribute("userEmail") : "" %>"
                                   required 
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200 outline-none"
                                   placeholder="student@university.edu">
                        </div>
                    </div>

                    <!-- Row 2: Password and Confirm Password -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <!-- Password Field -->
                        <div>
                            <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">Password</label>
                            <input type="password" 
                                   name="userPassword" 
                                   id="password" 
                                   required 
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200 outline-none"
                                   placeholder="Minimum 8 characters">
                            <p class="mt-1 text-xs text-gray-500">Must be at least 8 characters long</p>
                        </div>

                        <!-- Confirm Password Field -->
                        <div>
                            <label for="confirmPassword" class="block text-sm font-semibold text-gray-700 mb-2">Confirm Password</label>
                            <input type="password" 
                                   name="confirmPassword" 
                                   id="confirmPassword" 
                                   required 
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200 outline-none"
                                   placeholder="Re-enter your password">
                        </div>
                    </div>

                    <!-- Row 3: Matric Number and Faculty -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <!-- Matric Number Field -->
                        <div>
                            <label for="matricNo" class="block text-sm font-semibold text-gray-700 mb-2">Matric Number</label>
                            <input type="text" 
                                   id="matricNo"
                                   name="matricNo" 
                                   value="<%= request.getAttribute("matricNo") != null ? request.getAttribute("matricNo") : "" %>"
                                   required 
                                   pattern="[0-9]+"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200 outline-none"
                                   placeholder="e.g., 2023123456">
                        </div>

                        <!-- Faculty Dropdown -->
                        <div>
                            <label for="faculty" class="block text-sm font-semibold text-gray-700 mb-2">Faculty</label>
                            <select name="faculty" 
                                    id="faculty"
                                    required
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200 outline-none bg-white">
                                <option value="">-- Select Faculty --</option>
                                <option value="Engineering" <%= "Engineering".equals(request.getAttribute("faculty")) ? "selected" : "" %>>Faculty of Engineering</option>
                                <option value="Science" <%= "Science".equals(request.getAttribute("faculty")) ? "selected" : "" %>>Faculty of Science</option>
                                <option value="Medicine" <%= "Medicine".equals(request.getAttribute("faculty")) ? "selected" : "" %>>Faculty of Medicine</option>
                                <option value="Arts" <%= "Arts".equals(request.getAttribute("faculty")) ? "selected" : "" %>>Faculty of Arts & Humanities</option>
                                <option value="Business" <%= "Business".equals(request.getAttribute("faculty")) ? "selected" : "" %>>Faculty of Business & Management</option>
                                <option value="Law" <%= "Law".equals(request.getAttribute("faculty")) ? "selected" : "" %>>Faculty of Law</option>
                                <option value="Education" <%= "Education".equals(request.getAttribute("faculty")) ? "selected" : "" %>>Faculty of Education</option>
                                <option value="Computer Science" <%= "Computer Science".equals(request.getAttribute("faculty")) ? "selected" : "" %>>Faculty of Computer Science & IT</option>
                                <option value="Social Sciences" <%= "Social Sciences".equals(request.getAttribute("faculty")) ? "selected" : "" %>>Faculty of Social Sciences</option>
                                <option value="Architecture" <%= "Architecture".equals(request.getAttribute("faculty")) ? "selected" : "" %>>Faculty of Architecture & Planning</option>
                            </select>
                        </div>
                    </div>

                    <!-- Row 4: Programme (Full Width) -->
                    <div class="mb-6">
                        <label for="programme" class="block text-sm font-semibold text-gray-700 mb-2">Programme</label>
                        <select name="programme" 
                                id="programme"
                                required
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition duration-200 outline-none bg-white">
                            <option value="">-- Select Programme --</option>
                        </select>
                    </div>

                    <!-- Submit Button -->
                    <div class="pt-2">
                        <button type="submit" 
                                class="w-full bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-semibold py-3 px-4 rounded-lg hover:from-blue-700 hover:to-indigo-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transform transition duration-200 hover:scale-[1.02] shadow-lg">
                            Create Account
                        </button>
                    </div>
                </form>

                <!-- Login Link -->
                <div class="mt-6 text-center">
                    <p class="text-sm text-gray-600">
                        Already have an account? 
                        <a href="login" class="font-semibold text-blue-600 hover:text-blue-500 transition duration-200">Sign in here</a>
                    </p>
                </div>
            </div>

            <!-- Footer -->
            <div class="mt-8 text-center">
                <p class="text-xs text-gray-500">
                    &copy; 2025 University Club Management System. All rights reserved.
                </p>
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
            
            // Store the previously selected programme (for form persistence after errors)
            const selectedProgramme = "<%= request.getAttribute("programme") != null ? request.getAttribute("programme") : "" %>";

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

            // Initialize programme options on page load if faculty is already selected
            window.addEventListener('DOMContentLoaded', function() {
                const selectedFaculty = "<%= request.getAttribute("faculty") != null ? request.getAttribute("faculty") : "" %>";
                
                if (selectedFaculty) {
                    facultySelect.value = selectedFaculty;
                    facultySelect.dispatchEvent(new Event('change'));
                    
                    // Set the selected programme after options are loaded
                    setTimeout(function() {
                        if (selectedProgramme) {
                            programmeSelect.value = selectedProgramme;
                        }
                    }, 100);
                }
            });

            // Form validation
            document.getElementById('registerForm').addEventListener('submit', function(e) {
                var password = document.getElementById('password').value;
                var confirmPassword = document.getElementById('confirmPassword').value;
                
                if (password.length < 8) {
                    e.preventDefault();
                    alert('Password must be at least 8 characters long!');
                    return false;
                }
                
                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('Passwords do not match!');
                    return false;
                }
                
                return true;
            });
        </script>
    </body>
</html>