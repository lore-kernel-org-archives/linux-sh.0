From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 18 Jul 2014 12:52:26 +0000
Subject: Re: [PATCH 4/7] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <1562155.3bON52qvYG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1405455522-20676-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405455522-20676-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wednesday 16 July 2014 20:25:50 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > > mid_rid > 0 : slave mode
> > > mid_rid = 0 : memcpy mode
> > > mid_rid < 0 : error
> > 
> > Sorry, I spoke too fast. mid_rid = 0 is a valid hardware value in slave
> > mode. mid_rid < 0 denotes memcpy mode.
> 
> Ahh, OK I understand.
> Thank you for your explaining
> 
> > > This driver is counting driver users.
> > > So, I thought that we can initialize driver if it was 1st user.
> > 
> > It could be done, but that would be more complex as the DMAC would be
> > reinitialized every time the use count increases from 0 to 1.
> 
> I don't have strong objection to current method.
> So, you don't need to exchange it in v2
> 
> But, current code is doing
>    MSTP ON -> device init -> MSTP OFF.
> and we will use this driver, like
>    MSTP ON -> transfer -> MSTP OFF.

If runtime PM is enabled, the pm_runtime_get_sync() call will result in the 
runtime_resume operation (implemented in rcar_dmac_resume) being called. 
There's a call to rcar_dmac_init() there, so the DMAC will be reinitialized. 
The order of operations is thus

	MSTP ON -> device init -> transfer -> MSTP OFF

If runtime PM is disabled, pm_runtime_get_sync() will be a no-op. The 
rcar_dmac_resume() function will never be called, and the MSTP clock gate will 
always be on. The device will be initialized once only, at probe time. 

> My concern is that is this initialization really
> still enabled after MSTP OFF/ON ?
> Maybe this is OK current DMAC,
> but, we don't know future DMAC...

If we don't know, we can't really decide now, but we can always fix the driver 
if this becomes a problem in the future :-)

-- 
Regards,

Laurent Pinchart

