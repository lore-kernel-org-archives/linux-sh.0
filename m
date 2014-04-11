From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 11 Apr 2014 12:19:41 +0000
Subject: Re: [PATCH 0/2]: sh-pfc: r8a7791: Add sound pin support
Message-Id: <2638157.g6TI1Hh7Bo@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87sipkoeqj.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87sipkoeqj.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patches.

On Thursday 10 April 2014 18:07:41 Kuninori Morimoto wrote:
> Hi Simon, Laurent
> Cc Geert, Magnus
> 
> These are r8a7791 sound pin support patches
> 
> Kuninori Morimoto (2):
>       sh-pfc: r8a7791: Add SSI pin support
>       sh-pfc: r8a7791: Add Audio pin support
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  375 +++++++++++++++++++++++++++++++
>  1 file changed, 375 insertions(+)

Could you please make sure to CC Linus Walleij on PFC patches ?

For the whole series,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

