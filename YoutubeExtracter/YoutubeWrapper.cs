using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.Upload;
using Google.Apis.Util.Store;
using Google.Apis.YouTube.v3;
using Google.Apis.YouTube.v3.Data;

namespace YoutubeExtractor
{
    public class YoutubeWrapper
    {
        YouTubeService youtubeService;
        public YoutubeWrapper(string apiKey)
        {
            youtubeService = new YouTubeService(new BaseClientService.Initializer()
            {
                ApiKey = apiKey,
                ApplicationName = this.GetType().ToString()
            });
        }


        public object GetVideosByChannelName(string searchQuery)
        {
            var mySearch = youtubeService.Search.List("snippet");
            mySearch.Q = searchQuery;
            mySearch.MaxResults = 25;
    

            return mySearch.ExecuteAsync().Result;

          
        }
    }
}