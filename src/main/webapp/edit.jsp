<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/includes.jsp" %>

<%--@elvariable id="board" type="com.hcs.soundboard.data.Board"--%>
<c:set var="version" value="${board.unsharedVersion}"/>

<hcs:standard-page title="Edit Soundboard" page="create">
    <div class="jumbotron">
        <h1><c:out value="${version.title}"/></h1>
        <p class="lead"><c:out value="${version.description}"/></p>
    </div>
    <div id="buttons">
        <hcs:form action="/board/${board.id}/edit-board" method="post">
            <c:forEach var="sound" items="${version.sounds}">
                <p>
                    <hcs:sound-button sound="${sound}"/>
                    <input type="hidden" name="soundId" value="${sound.id}">
                    <input type="checkbox" name="deleted" value="${sound.id}">
                    <input type="hidden" name="originalName" value="${sound.name}">
                    <input type="text" name="name" value="${sound.name}">
                </p>
            </c:forEach>
            <input type="submit" value="Submit Changes">
        </hcs:form>
    </div>
    <div>
        <hcs:form method="post" enctype="multipart/form-data" action="/board/${board.id}/upload">
            <input class="btn" type="file" accept="audio/*" capture="microphone" name="sounds" required="required"
                   multiple/>
            <input class="btn" type="submit"/>
        </hcs:form>
    </div>
    <div>
        <c:choose>
            <c:when test="${version.sounds.size() == 0}">
                You can share your soundboard once you've added some sounds.
            </c:when>
            <c:when test="${!board.hasUnsharedChanges()}">
                You don't have any unshared changes.
            </c:when>
            <c:otherwise>
                <a href="/board/${board.id}/preview">Preview Changes</a>
                <hcs:form method="post" action="/board/${board.id}/share">
                    <input class="btn btn-primary" type="submit" value="Share Soundboard">
                </hcs:form>
            </c:otherwise>
        </c:choose>
    </div>
</hcs:standard-page>