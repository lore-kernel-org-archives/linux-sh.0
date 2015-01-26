From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 26 Jan 2015 06:39:12 +0000
Subject: Re: [PATCH 0/2] dmaengine: shdmac/rcar-hpbdma: fixup WARNING of slave caps retrieval
Message-Id: <20150126063912.GJ28763@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878ugvmtoa.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878ugvmtoa.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 22, 2015 at 02:31:42AM +0000, Kuninori Morimoto wrote:
> 
> Vi Vinod
> 
> I had sent rcar-hpbdma directions fixup patches before
> 
> 	Subject: [PATCH v3] dmaengine:: rcar-hpbdma: add dma_dev->directions
> 	Date: Tue, 20 Jan 2015 01:22:48 +0000
> 
> After that, I got feedback from Laurent about residue_granularity.
> But, then, I could find above patch on dma/next branch, so, I sent below
> patch as additional patch.
> 
> 	Subject: [PATCH] dmaengine: rcar-hpbdma: tidyup residue_granularity
> 	Date: Wed, 21 Jan 2015 04:42:22 +0000
> 
> But, could you please replace it to 1) if possible ?
> I found shdmac has same issue (= 2).
> 
> Kuninori Morimoto (2):
>       1) dmaengine: rcar-hpbdma: fixup WARNING of slave caps retrieval
>       2) dmaengine: shdmac: fixup WARNING of slave caps retrieval
I tried applying, got conflict on 1st one, applied second one, please rebase
and resnd 1st.

Thanks

-- 
~Vinod
