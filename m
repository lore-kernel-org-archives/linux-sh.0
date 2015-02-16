From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 16 Feb 2015 19:47:00 +0000
Subject: Re: [PATCH 0/3 v3][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <7874620.5qCoKeFt9V@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday 09 February 2015 01:37:41 Kuninori Morimoto wrote:
> 
> Hi Vinod, Arnd
> 
> Can I have feedback from you about below mail, and this patch ?
> 
> http://thread.gmane.org/gmane.linux.ports.sh.devel/41063/focusC372

I had the chance to discuss this in more depth with Laurent last
week. What it basically comes down to is that you try to do something
that the existing DT binding and slave API does not support: we
only really do DMA_DEV_TO_MEM or DMA_MEM_TO_DEV, but not DMA_DEV_TO_DEV.

To properly support this with the dmaengine API, we would likely first
need to extend the generic DT binding, and then implement the driver
to use that extended binding.

The easiest way out however seems to be to move the audmapp
implementation into the rcar audio driver itself. As Laurent pointed
out, it is not really a general-purpose dmaengine anyway and it
only ever gets used by one driver, so we could not find any downsides.

	Arnd
