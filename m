From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 21 Jun 2011 00:19:24 +0000
Subject: Re: [PATCH] dmaengine: failure to get a specific DMA channel is not
Message-Id: <w3pzklcxchm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1106201657280.11365@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1106201657280.11365@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>


Dear Guennadi, all

> There exist systems with multiple DMA controllers with different
> capabilities. For example, on some sh-mobile / rmobile systems there are
> DMA controllers, whose channels can be configured to be used with
> SD- and MMC-host controllers, serial ports etc. Besides there are also
> DMA controllers, that can only be used for one special function, e.g.,
> for USB. In such cases the DMA client filter function can just choose
> to specify to the DMA driver, which channel it needs. Then the
> .device_alloc_chan_resources() method of the DMA driver will check,
> whether it can provide that dunction. If not, it will fail and the loop
> in __dma_request_channel() will continue to the next DMA device, until
> it finds a suitable one. This works fine with just one minor glitch:
> the kernel logs error messages like
> 
> dmaengine: failed to get <channel name>: (-<error code>)
> 
> after each such non-critical failure. This patch lowers priority of
> this message to the debug level.
> 
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Morimoto-san, I don't expect this patch to fail;), but if you like, you 
> could give it a short spin and send your "tested-by" in reply to this 
> mail.

Thanks.
I tested this patch.

I don't know that the dmaengine design,
but this patch remove non-critical error message from USB-DMAC for me.
I tested it on mackerel board + renesas_usbhs + USB-DMAC

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
--
Kuninori Morimoto
 
