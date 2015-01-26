From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 26 Jan 2015 06:38:06 +0000
Subject: Re: [PATCH] dmaengine: rcar-hpbdma: tidyup residue_granularity
Message-Id: <20150126063806.GI28763@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbk0n3q3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbk0n3q3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 21, 2015 at 04:42:22AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> The driver doesn't support residue reporting at all.
> residue_granularity should be set to DMA_RESIDUE_GRANULARITY_DESCRIPTOR.
> Special thanks to Laurent

Applied, thanks

-- 
~Vinod

