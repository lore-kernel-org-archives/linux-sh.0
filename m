From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 04 Sep 2015 11:35:50 +0000
Subject: Re: [PATCH 2/3] ml86v7667: implement g_std() method
Message-Id: <55E98216.3080602@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <6015647.cjLjRfTWc7@wasted.cogentembedded.com> <1725998.gULFgFImHk@wasted.cogentembedded.com>
In-Reply-To: <1725998.gULFgFImHk@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, mchehab@osg.samsung.com, linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

On 09/04/2015 01:16 AM, Sergei Shtylyov wrote:
> The driver was written with the 'soc_camera' use in mind, however the g_std()
> video method was forgotten. Implement it at last...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

> 
> ---
>  drivers/media/i2c/ml86v7667.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: media_tree/drivers/media/i2c/ml86v7667.c
> =================================> --- media_tree.orig/drivers/media/i2c/ml86v7667.c
> +++ media_tree/drivers/media/i2c/ml86v7667.c
> @@ -233,6 +233,15 @@ static int ml86v7667_g_mbus_config(struc
>  	return 0;
>  }
>  
> +static int ml86v7667_g_std(struct v4l2_subdev *sd, v4l2_std_id *std)
> +{
> +	struct ml86v7667_priv *priv = to_ml86v7667(sd);
> +
> +	*std = priv->std;
> +
> +	return 0;
> +}
> +
>  static int ml86v7667_s_std(struct v4l2_subdev *sd, v4l2_std_id std)
>  {
>  	struct ml86v7667_priv *priv = to_ml86v7667(sd);
> @@ -282,6 +291,7 @@ static const struct v4l2_ctrl_ops ml86v7
>  };
>  
>  static struct v4l2_subdev_video_ops ml86v7667_subdev_video_ops = {
> +	.g_std = ml86v7667_g_std,
>  	.s_std = ml86v7667_s_std,
>  	.querystd = ml86v7667_querystd,
>  	.g_input_status = ml86v7667_g_input_status,
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

