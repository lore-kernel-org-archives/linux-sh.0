From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Jan 2015 13:59:44 +0000
Subject: Re: [PATCH 1/6 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
Message-Id: <7584443.5zMCDTcVOF@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday 20 January 2015 01:44:38 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current Renesas Audio DMAC Peri Peri driver is based on
> SH_DMAE_BASE driver which is used for Renesas SH-Mobile.
> But, basically, SH_DMAE_BASE driver was created for
> SuperH SoC, and it is not fully cared for DT.
> 
> For example, current SH_DMAE_BASE base driver will return
> non-matching DMA channel if some non-SH_DMAE_BASE drivers
> are probed.
> So, sound driver will get wrong DMA channel
> if Audio DMAC (= rcar-dma) was not probed,
> but Audio DMAC Peri Peri (= SH_DMAE_BASE) was probed.
> 
> OTOH, many SH-Mobile series drivers are using SH_DMAE_BASE
> driver, and Renesas R-Car series will not use it anymore.
> Maintenance cost for fully cared DT support on SH_DMAE_BASE
> will be very high
> (and keeping compatibility will be very complex).
> 
> In addition, Audio DMAC Peri Peri itself is very simple device,
> and, no SoC/board is using it from non-DT environment.
> 
> This patch simply removes current rcar-audmapp driver.
> 

I'm confused by the description above. From what I understand,
the purpose of the SH_DMAE_BASE driver is to multiplex between
the DMA engines that all share the same slaves on some of the
shmobile/r-mobile/r-car chips. If the audma driver does not
share its slaves with another dmaengine, it needs to register
its own of_dma_controller, which it does.

The problem you describe with getting the wrong channel seems
to me that the shdma_chan_filter() function matches any DMA
engine that was registered through shdma_init(), because its
device_alloc_chan_resources function pointer matches. This problem
could be avoided by adding some flag in shdma_dev as a bug-fix
(also for backports to stable kernels).

That said, together with patch 2, this seems like a useful
simplification, it just needs a better description in my mind.

	Arnd
