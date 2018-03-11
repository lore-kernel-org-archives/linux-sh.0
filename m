From: Sakari Ailus <sakari.ailus@iki.fi>
Date: Sun, 11 Mar 2018 20:15:14 +0000
Subject: Re: [PATCH 5/5] media: MAINTAINERS: Add entry for Aptina MT9T112
Message-Id: <20180311201514.7ljwikv4twj6hxpk@valkosipuli.retiisi.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1520008541-3961-1-git-send-email-jacopo+renesas@jmondi.org>
 <1520008541-3961-6-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1520008541-3961-6-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com, mchehab@kernel.org, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jacopo,

On Fri, Mar 02, 2018 at 05:35:41PM +0100, Jacopo Mondi wrote:
> Add entry for Aptina/Micron MT9T112 camera sensor. The driver is
> currently orphaned.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91ed6ad..1d8be25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9385,6 +9385,13 @@ S:	Maintained
>  F:	drivers/media/i2c/mt9t001.c
>  F:	include/media/i2c/mt9t001.h
>  
> +MT9T112 APTINA CAMERA SENSOR
> +L:	linux-media@vger.kernel.org
> +T:	git git://linuxtv.org/media_tree.git
> +S:	Orphan

I don't like adding a driver which is in orphaned state to begin with.

Would you like to maintain it? :-)

> +F:	drivers/media/i2c/mt9t112.c
> +F:	include/media/i2c/mt9t112.h
> +
>  MT9V032 APTINA CAMERA SENSOR
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	linux-media@vger.kernel.org

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
