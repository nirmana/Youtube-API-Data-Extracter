using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace YoutubeExtractor
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtAPIKey.Text = "YOUR YOUTUBE API KEY";
                txtSearchQuery.Text = "";
            }
        }

        protected void btnSearchVideos_Click(object sender, EventArgs e)
        {
            try
            {
                var apiKey = txtAPIKey.Text;
                if (string.IsNullOrEmpty(apiKey))
                {
                    string script = "alert(\"Please enter valid API Key!\");";
                    ScriptManager.RegisterStartupScript(this, GetType(),
                                          "ServerControlScript", script, true);
                }

                var searchQuery = txtSearchQuery.Text;
                if (string.IsNullOrEmpty(searchQuery))
                {
                    string script = "alert(\"Please enter valid channel name!\");";
                    ScriptManager.RegisterStartupScript(this, GetType(),
                                          "ServerControlScript", script, true);
                }


                //good to go
                var resp = new YoutubeWrapper(apiKey).GetVideosByChannelName(searchQuery);
                string output = JsonConvert.SerializeObject(resp);
                string scriptForVisualize = "visualizeData(" + output + ");";
                ScriptManager.RegisterStartupScript(this, GetType(),
                                      "ServerControlScript", scriptForVisualize, true);

            }
            catch (Exception ex)
            {
                string script = "alert(\""+ ex.Message + " \");";
                ScriptManager.RegisterStartupScript(this, GetType(),
                                      "ServerControlScript", script, true);
            }
        }
    }
}