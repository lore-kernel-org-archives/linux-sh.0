From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Jul 2014 03:25:50 +0000
Subject: Re: [PATCH 4/7] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <87y4vsekeb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405455522-20676-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405455522-20676-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > mid_rid > 0 : slave mode
> > mid_rid = 0 : memcpy mode
> > mid_rid < 0 : error
> 
> Sorry, I spoke too fast. mid_rid = 0 is a valid hardware value in slave mode. 
> mid_rid < 0 denotes memcpy mode.

Ahh, OK I understand.
Thank you for your explaining

> > This driver is counting driver users.
> > So, I thought that we can initialize driver if it was 1st user.
> 
> It could be done, but that would be more complex as the DMAC would be 
> reinitialized every time the use count increases from 0 to 1.

I don't have strong objection to current method.
So, you don't need to exchange it in v2

But, current code is doing
   MSTP ON -> device init -> MSTP OFF.
and we will use this driver, like
   MSTP ON -> transfer -> MSTP OFF.
My concern is that is this initialization really
still enabled after MSTP OFF/ON ?
Maybe this is OK current DMAC,
but, we don't know future DMAC...

