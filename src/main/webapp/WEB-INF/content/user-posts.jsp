<%@ page import="step.learning.entities.Post" %>
<%@ page import="step.learning.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String home = request.getContextPath() ;
    User authUser = (User) request.getAttribute( "AuthUser" ) ;
    Post[] posts = (Post[]) request.getAttribute("posts");
    String regError = (String) request.getAttribute( "regError" ) ;
    String regOk = (String) request.getAttribute( "regOk" ) ;
    String SaveName = (String) request.getAttribute( "SaveName" );
    String SaveContent = (String)  request.getAttribute( "SaveContent" );
%>
<div class = "row" style="width: 100%">
    <% if( regError != null ) { %><h3 class="card-title text-center reg-error"><%=regError%></h3><% } %>
    <% if( regOk != null ) { %><h3 class="card-title text-center reg-ok"><%=regOk%></h3><% } %>
    <% if (posts.length != 0) {%>
    <div class="row" style="width: 70%">
        <div class="col s8" style="width: 100%; ">
            <div class="row">
                <div class="col s11">
                    <h1 style="width: 50%;"><%=authUser.getName()%>'s posts</h1>
                </div>
                <div class="col s1">
                    <!-- Modal Trigger -->
                    <a class="waves-effect btn modal-trigger" href="#modal1" style="margin-top: 50%">Add</a>
                    <!-- Modal Structure -->
                    <form method="POST" action="" enctype="multipart/form-data">
                    <div id="modal1" class="modal">
                        <div class="modal-content">
                            <h4>Add post</h4>
                                <div class="row">
                                    <div class="input-field">
                                        <input name="addName" id="nam" type="text" class="validate"
                                            <%if(SaveName != null){%>
                                               value="<%=SaveName%>"
                                            <%}%>
                                        >
                                        <label for="nam">Name</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="input-field">
                                        <input name="addContent" id="cont" type="text" class="validate"
                                            <%if(SaveContent != null){%>
                                               value="<%=SaveContent%>"
                                            <%}%>>
                                        <label for="cont">Content</label>
                                    </div>
                                </div>
                                <!-- Avatar -->
                                <div class="file-field input-field">
                                    <div class="btn">
                                        <span>File</span>
                                        <input name="addPreview" type="file">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <label>
                                            <input class="file-path validate"  type="text">
                                        </label>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary" >Create post</button>
                        </div>
                        <div class="modal-footer">
                            <a href="#!" class="modal-close waves-effect waves-red btn-flat">Close</a>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
            <div>
                <% for(Post post:posts) {%>
                <div class ="row" style="box-shadow: 0 0 15px rgba(0, 0, 0, .2); width: 100%">
                    <div class="col s3" style="padding: 10px 10px">
                        <img
                            <%if (post.getPreview() != null){%>
                                src="<%=home%>/image/<%=post.getPreview()%>"
                            <%}else{%>
                                src="<%=home%>/image/NoImageVailable.png"
                            <%}%>

                                width="100%" height="100%" style="text-align: center" alt="">
                    </div>
                    <div class="col s9">
                        <div class="row" style="padding: 10px; margin:0">
                            <div class ="col s9">
                                <h4 style="margin: 0 0"><%=post.getName()%></h4>
                                <input hidden id="post-id" type="text" class="validate" value="<%=post.getId()%>">
                            </div>
                            <div class ="col s3" >
                                <span style="color: gray; float:right"><%=post.getDate()%></span>
                            </div>
                        </div>
                        <div class="row" style="padding: 10px; margin:0">
                            <%=post.getContent()%>
                        </div>
                        <div class="row" style="padding: 10px; margin:0; float:right; width: 100%">
                            <div class="col s2">
                                <button type="submit" class=" waves-light lime btn" style="width: 100%">Edit</button>
                            </div>
                            <div class="col s2">
                                <button type="submit" class=" waves-light red lighten-1 btn" id="delete-post-button" style="width: 100%">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
        <div class="col s2" style="width: 100%">
        </div>
    </div>
    <%}else {%>
    <h1>Posts not found</h1>
    <%}%>
</div>

<script>
    document.addEventListener( "DOMContentLoaded", () => {

        for( let nameElement of document.querySelectorAll( "#delete-post-button" ) ){
            nameElement.addEventListener( 'click', deletePostClick )
        }

        const avatarSaveButton = document.querySelector( "#avatar-edit-button" ) ;
        if( ! avatarSaveButton ) throw "'#avatar-edit-button' not found" ;
        avatarSaveButton.addEventListener( 'click', previewSaveClick ) ;


    });

    function deletePostClick(e) {
        const posts = document.querySelector('#post-id') ;
        if( ! posts ) throw "#post-id not found" ;
        alert(posts.value)

        // fetch( "/Java_WebBasics_war_exploded/user-posts/?id=" + post.value, {
        //     method: "DELETE",
        //     headers: { },
        //     body: ""
        // }).then( r => r.text() )
        //     .then( t => {
        //         alert(t + " (id)"); // сообщени об успешном (или неуспешном) обновлении
        //     } ) ;
    }

    function previewSaveClick() {
        const avatarInput = document.querySelector( "#avatar-input" ) ;
        if( ! avatarInput ) throw "'#avatar-input' not found" ;
        if( avatarInput.files.length === 0 ) {
            alert( "select a file" ) ;
            return ;
        }
        let formData = new FormData() ;
        formData.append( "userAvatar", avatarInput.files[0] ) ;
        fetch( "/Java_WebBasics_war_exploded/user-posts/", {
            method: "PUT",
            headers: { },
            body: formData  // наличие файла в formData автоматически сформирует multipart запрос
        }).then( r => r.text() )
            .then( t => {
                alert(t);
            } ) ;
    }



</script>
