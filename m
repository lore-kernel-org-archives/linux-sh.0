From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 May 2011 15:43:49 +0000
Subject: Re: [PATCH 00/03] dmaengine: shdma: sh73a0 and SH_DMAC_MAX_CHANNELS
Message-Id: <20110524154349.GB14329@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110524103104.10334.42987.sendpatchset@t400s>
In-Reply-To: <20110524103104.10334.42987.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 24, 2011 at 07:31:04PM +0900, Magnus Damm wrote:
> dmaengine: shdma: sh73a0 and SH_DMAC_MAX_CHANNELS
> 
> [PATCH 01/03] dmaengine: shdma: Make second memory window optional
> [PATCH 02/03] dmaengine: shdma: Fix SH_DMAC_MAX_CHANNELS handling
> [PATCH 03/03] dmaengine: shdma: Update SH_DMAC_MAX_CHANNELS to 20
> 
> These patches update the shdma dmaengine driver to support DMA
> controllers with more than 6 slave-id capable channels mapped
> into a single I/O-memory window. While at it fix the handling
> of SH_DMAC_MAX_CHANNELS that without [PATCH 02/03] may overflow
> some arrays at probe() time depending on platform data.
> 
> Needed to support the 20-channel SY-DMAC block included in sh73a0.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Since these patches are only touching the shdma driver perhaps
>  merging through the sh-2.6 tree is the easiest?
> 
Easiest perhaps, but as the merge window is closing on Sunday and I've
already sent the sh bits off, none of this is likely to make it for -rc1.

I'm also not very thrilled about the amount of churn that the rmobile
bits add on top of this with regards to -rc2 timing, and with -rc1 timing
there's basically zero time for -next coverage should I slam all of it in
to the rmobile tree -- none of these options are terribly appealing. This
all should have been posted weeks ago.
