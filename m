From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 20 Aug 2015 06:43:36 +0000
Subject: Re: [PATCH] dmaengine: Stricter legacy checking in dma_request_slave_channel_compat()
Message-Id: <20150820063136.GD13546@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1439816935-27554-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1439816935-27554-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Matt Porter <mporter@kernel.crashing.org>, dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 17, 2015 at 03:08:55PM +0200, Geert Uytterhoeven wrote:
> dma_request_slave_channel_compat() is meant for drivers that support
> both DT and legacy platform device based probing: if DT channel DMA
> setup fails, it will fall back to platform data based DMA channel setup,
> using hardcoded DMA channel IDs and a filter function.
> 
> However, if the DTS doesn't provide a "dmas" property for the device,
> the fallback is also used. If the legacy filter function is not
> hardcoded in the DMA slave driver, but comes from platform data, it will
> be NULL. Then dma_request_slave_channel_compat() will succeed
> incorrectly, and return a DMA channel, as a NULL legacy filter function
> actually means "all channels are OK", not "do not match".
> 
> Later, when trying to use that DMA channel, it will fail with:
> 
>     rcar-dmac e6700000.dma-controller: rcar_dmac_prep_slave_sg: bad parameter: len=1, id=-22
> 
> To fix this, ensure that both the filter function and the DMA channel ID
> are not NULL before using the legacy fallback.
> 
> Note that some DMA slave drivers can handle this failure, and will fall
> back to PIO.
> 
> See also commit 056f6c87028544de ("dmaengine: shdma: Make dummy
> shdma_chan_filter() always return false"), which fixed the same issue
> for the case where shdma_chan_filter() is hardcoded in a DMA slave
> driver.

Applied, thanks

-- 
~Vinod

