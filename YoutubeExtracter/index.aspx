<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="YoutubeExtractor.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Youtube Data Extractor</title>
    <script src="scripts/jQuery.min.js"></script>
     <script src="https://apis.google.com/js/platform.js"></script>
    <script>
        function visualizeData(data) {
            $("#videoPanel").empty();
            $("#channelPanal").empty();
            var videoTemplate = '<li class="col-lg-3 col-sm-4 col-xs-6">' +
		    '<a href="videoUrl" target="_blank" title="header">' +
			'<img src="thumbnail" alt="Barca" class="img-responsive" height="130px" />' +
			'<h2>header</h2>' +
			'<span class="glyphicon glyphicon-play-circle"></span>' +
			//'<span class="duration">03:15</span>'+
		    '</a>' +
            '</li>';


            var channelButtonTemplate = '<div class="g-ytsubscribe" data-channelid="channelName" data-layout="full" data-count="default"></div>';

            for (var i = 0; i < data.items.length; i++) {
                if (data.items[i].id.kind === "youtube#video") {
                    //video

                    var videoTemplateModified = videoTemplate.replace(/header/g, data.items[i].snippet.description);
                    videoTemplateModified = videoTemplateModified.replace(/videoUrl/g, "https://www.youtube.com/watch?v="+data.items[i].id.videoId);
                    
                   videoTemplateModified = videoTemplateModified.replace(/thumbnail/g, data.items[i].snippet.thumbnails.default.url);

                   $("#videoPanel").append(videoTemplateModified);
                } else if(data.items[i].id.kind === "youtube#channel") {
                    var buttonTemplateModified = channelButtonTemplate.replace(/channelName/g, data.items[i].snippet.channelId);
                    $("#channelPanal").append(buttonTemplateModified);
                    
                }
                //
            }



        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <label>API Key</label>
                    <asp:TextBox runat="server" ID="txtAPIKey"></asp:TextBox>

                    <label>Channel Name</label>
                    <asp:TextBox runat="server" ID="txtSearchQuery"></asp:TextBox>

                    <asp:Button runat="server" ID="btnSearchVideos" Text="Search" OnClick="btnSearchVideos_Click" />
                </div>
                <div class="clearfix"></div>
                <br/> <br/> <br/>
                <div class="col-md-6">
                    <h3>Videos</h3>
                    <ul class="list-unstyled video-list-thumbs row" id="videoPanel">
                    </ul>
                </div>
                 <div class="col-md-3">
                    <h3>Channels</h3>
                    <div id="channelPanal">
                    </div>
                </div>
            </div>
        </div>


    </form>
</body>

<link href="styles/css/bootstrap.min.css" rel="stylesheet" />
<style>
    .video-list-thumbs {
    }

        .video-list-thumbs > li {
            margin-bottom: 12px;
        }

            .video-list-thumbs > li:last-child {
            }

            .video-list-thumbs > li > a {
                display: block;
                position: relative;
                background-color: #111;
                color: #fff;
                padding: 8px;
                border-radius: 3px transition:all 500ms ease-in-out;
                border-radius: 4px;
            }

                .video-list-thumbs > li > a:hover {
                    box-shadow: 0 2px 5px rgba(0,0,0,.3);
                    text-decoration: none;
                }

        .video-list-thumbs h2 {
            bottom: 0;
            font-size: 14px;
            height: 33px;
            margin: 8px 0 0;
        }

        .video-list-thumbs .glyphicon-play-circle {
            font-size: 60px;
            opacity: 0.6;
            position: absolute;
            right: 39%;
            top: 31%;
            text-shadow: 0 1px 3px rgba(0,0,0,.5);
            transition: all 500ms ease-in-out;
        }

        .video-list-thumbs > li > a:hover .glyphicon-play-circle {
            color: #fff;
            opacity: 1;
            text-shadow: 0 1px 3px rgba(0,0,0,.8);
        }

        .video-list-thumbs .duration {
            background-color: rgba(0, 0, 0, 0.4);
            border-radius: 2px;
            color: #fff;
            font-size: 11px;
            font-weight: bold;
            left: 12px;
            line-height: 13px;
            padding: 2px 3px 1px;
            position: absolute;
            top: 12px;
            transition: all 500ms ease;
        }

        .video-list-thumbs > li > a:hover .duration {
            background-color: #000;
        }

    @media (min-width:320px) and (max-width: 480px) {
        .video-list-thumbs .glyphicon-play-circle {
            font-size: 35px;
            right: 36%;
            top: 27%;
        }

        .video-list-thumbs h2 {
            bottom: 0;
            font-size: 12px;
            height: 22px;
            margin: 8px 0 0;
        }
    }
</style>
</html>
