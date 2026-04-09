<html>
<head>
    <title>Upload Media</title>
</head>
<body>
<h2>Upload Media</h2>
<form action="../MediaServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="campaignId" value="<%= request.getParameter("campaignId") %>"/>
    <label>Select Media File:</label>
    <input type="file" name="mediaFile" required/><br/><br/>
    <label>Media Type:</label>
    <select name="fileType">
        <option value="Image">Image</option>
        <option value="Video">Video</option>
        <option value="Document">Document</option>
    </select><br/><br/>
    <button type="submit" name="action" value="upload">Upload</button>
</form>
</body>
</html>
