From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 25 Nov 2015 03:43:23 +0000
Subject: Re: [PATCH] thermal: rcar: enable to set tripN-temp via DT
Message-Id: <20151125034320.GA14278@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <HK2PR04MB0804B55DC6CE36094AEF5162BC1C0@HK2PR04MB0804.apcprd04.prod.outlook.com>
 <564D14A1.70806@renesas.com>
 <87h9kiilbe.wl%kuninori.morimoto.gx@renesas.com>
 <56545CE5.3040502@renesas.com>
 <87mvu37wv2.wl%kuninori.morimoto.gx@renesas.com>
 <5655059C.40509@renesas.com>
 <87io4q97s7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87io4q97s7.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "osd2-bV+sCa4451V9uiUsa/gSgQ@public.gmane.org" <osd2-bV+sCa4451V9uiUsa/gSgQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Morimoto-san,


On Wed, Nov 25, 2015 at 01:45:14AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current rcar thermal driver is using 90 degrees as trip temp, but it
> should be based on each SoC / platform.
> This patch enables to set trip temp via DT. (It uses db8500-thermal
> style for it)
> It will use 90 degrees as default trip temp if DT doesn't have it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/thermal/rcar-thermal.txt   |  2 ++
>  drivers/thermal/rcar_thermal.c                     | 34 ++++++++++++++++++++--
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> index 332e625..6c57f7e 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> @@ -18,6 +18,8 @@ Required properties:
>  Option properties:
>  
>  - interrupts		: use interrupt
> +- tripN-temp		: temperature of trip point N. it will use 90000 as default
> +			  if DT doesn't have tripN-temp

First of all, you are creating an entry with is specific to your driver.
That requires it to use proper prefixing.

Besides, your property is already covered by of-thermal. Please convert
your driver to use of-thermal, this way it will give you the flexibility
to configure thermal data in DT.

BR,
