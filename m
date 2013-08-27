From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 27 Aug 2013 09:21:00 +0000
Subject: Re: [PATCH] DMA: shdma: fix a bad merge - remove free_irq()
Message-Id: <Pine.LNX.4.64.1308271028500.11515@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1308261426320.1767@axis700.grange>
 <20130826135308.GP2748@intel.com>
In-Reply-To: <20130826135308.GP2748@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms@verge.net.au>

Hi Vinod,

On Mon, 26 Aug 2013, Vinod Koul wrote:

> On Mon, Aug 26, 2013 at 02:27:51PM +0200, Guennadi Liakhovetski wrote:
> > A bad merge resulted in a left-over free_irq() call. This patch removes it.
> Applied, thanks
> 
> Can you also test this branch and see if anything is remaining
> 
> And can you take care then ARM patches in last serries are merged this week...

Ok, I wanted to just test -next, but the latest is still of 22 Aug and 
that's too old. So, I took the current sh-mobile tree and merged your 
tree on top. There was 1 merge conflict in arch/arm/Makefile, but that's 
unrelated. After doing that I've discovered the following problems:

1. you applied a wrong version (v1) of my patch "DMA: shdma: support the 
new CHCLR register layout" - not v2, whose patchwork ID I provided:

> DMA: shdma: support the new CHCLR register layout
> pw ID: 2825593

I suggest to revert that commit and apply the correct one.

2. you missed this patch:

> DMA: shdma: move two macros to a header
> pw ID: 2831934

Please, pick it up too, even though it's just a cosmetic one.

3. Your merge:

commit ba1e06e3dff9a0bb0758d169e50cbb04a67a402c
Merge: daabb76 74cd26c
Author: Vinod Koul <vinod.koul@intel.com>
Date:   Sun Aug 25 13:22:06 2013 +0530

    Merge branch 'topic/sh' into next
    
    Conflicts:
        drivers/dma/sh/shdmac.c

dropped a "const" from a variable, which now generates a compiler warning. 
I'll send an incremental fix for that soon.

After fixing all the above the tree seems to be in a proper state. After 
your tree is fixed we can push ARM patches too.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
