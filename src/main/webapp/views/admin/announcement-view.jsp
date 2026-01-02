<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Announcement Details</title>
</head>
<body>

<h2>${announcement.announcementTitle}</h2>

<p><strong>Club:</strong> ${announcement.clubName}</p>
<p><strong>Author:</strong> ${announcement.authorName}</p>
<p><strong>Published:</strong> ${announcement.publishDate}</p>

<hr>

<p>${announcement.announcementMessage}</p>

<br>
<a href="${pageContext.request.contextPath}/admin/announcements">⬅ Back</a>

</body>
</html>
