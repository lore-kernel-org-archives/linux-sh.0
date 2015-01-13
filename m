From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 13 Jan 2015 18:37:04 +0000
Subject: Re: [PATCH v2] dma: rcar-hpbdma: fixup WARNING of slave caps retrieval
Message-Id: <20150113182504.GH15411@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppaqt5in.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ppaqt5in.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 08, 2015 at 01:38:50AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> ecc19d17868be9c9f8f00ed928791533c420f3e0
> (dmaengine: Add a warning for drivers not using the generic slave
> caps retrieval) added WARN() for DMA_SLAVE.
> Kernel will shows WARNING without this patch.
> 
Please use the right subsystem name.

Applied now 

Thanks
-- 
~Vinod
