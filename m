From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 10 Sep 2014 21:56:45 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: sh73a0: Remove unnecessary SoC data allocation
Message-Id: <1538500.zxR7U9yTIT@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1410355999-13266-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410355999-13266-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wednesday 10 September 2014 17:25:24 Geert Uytterhoeven wrote:
> On Wed, Sep 10, 2014 at 3:33 PM, Laurent Pinchart wrote:
> > The SoC data structure allocated at init time only holds a regulator
> > pointer that is only used in the init function. Replace it with a local
> > variable and get rid of the SoC data structure allocation altogether.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> > 
> > -       pfc->soc_data = data;
> 
> Now soc_data is also unused, so it can be removed from struct sh_pfc.
> Likewise for sh_pfc_soc_operations.exit(), which only used to exist for
> freeing the data associated with soc_data.

Indeed, good point. I've submitted a v2.

-- 
Regards,

Laurent Pinchart

