<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Admin Announcements</title>
</head>
<body>

<h2>All Announcements</h2>

<table border="1" cellpadding="8">
    <tr>
        <th>Title</th>
        <th>Club</th>
        <th>Author</th>
        <th>Date</th>
        <th>Actions</th>
    </tr>

    <c:forEach var="a" items="${announcements}">
        <tr>
            <td>${a.announcementTitle}</td>
            <td>${a.clubName}</td>
            <td>${a.authorName}</td>
            <td>${a.publishDate}</td>

            <!-- ✅ BUTTONS LIVE HERE -->
            <td>
                <a href="${pageContext.request.contextPath}/admin/announcement/view?id=${a.announcementID}">
                    View
                </a> |

                <a href="${pageContext.request.contextPath}/admin/announcement/edit?id=${a.announcementID}">
                    Edit
                </a> |

                <form action="${pageContext.request.contextPath}/admin/announcement/delete"
                      method="post" style="display:inline">

                    <input type="hidden" name="id"
                           value="${a.announcementID}">

                    <button type="submit"
                            onclick="return confirm('Delete this announcement?')">
                        Delete
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
