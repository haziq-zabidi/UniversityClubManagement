<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Edit Announcement</title>
</head>
<body>

<h2>Edit Announcement (Admin)</h2>

<form method="post"
      action="${pageContext.request.contextPath}/admin/announcement/edit">

    <input type="hidden" name="id"
           value="${announcement.announcementID}" />

    <p>
        <label>Title</label><br>
        <input type="text" name="title"
               value="${announcement.announcementTitle}"
               required>
    </p>

    <p>
        <label>Message</label><br>
        <textarea name="message" rows="6" cols="50" required>
${announcement.announcementMessage}</textarea>
    </p>

    <button type="submit">Update</button>
    <a href="${pageContext.request.contextPath}/admin/announcements">
        Cancel
    </a>

</form>

</body>
</html>
