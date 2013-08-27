From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 27 Aug 2013 09:13:12 +0000
Subject: Re: [PATCH] DMA: shdma: fix a bad merge - remove free_irq()
Message-Id: <20130827090112.GT2748@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1308261426320.1767@axis700.grange>
 <20130826135308.GP2748@intel.com>
 <Pine.LNX.4.64.1308271028500.11515@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1308271028500.11515@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms@verge.net.au>

On Tue, Aug 27, 2013 at 11:21:00AM +0200, Guennadi Liakhovetski wrote:
> Hi Vinod,
> 
> On Mon, 26 Aug 2013, Vinod Koul wrote:
> 
> > On Mon, Aug 26, 2013 at 02:27:51PM +0200, Guennadi Liakhovetski wrote:
> > > A bad merge resulted in a left-over free_irq() call. This patch removes it.
> > Applied, thanks
> > 
> > Can you also test this branch and see if anything is remaining
> > 
> > And can you take care then ARM patches in last serries are merged this week...
> 
> Ok, I wanted to just test -next, but the latest is still of 22 Aug and 
> that's too old. So, I took the current sh-mobile tree and merged your 
> tree on top. There was 1 merge conflict in arch/arm/Makefile, but that's 
> unrelated. After doing that I've discovered the following problems:
> 
> 1. you applied a wrong version (v1) of my patch "DMA: shdma: support the 
> new CHCLR register layout" - not v2, whose patchwork ID I provided:
> 
> > DMA: shdma: support the new CHCLR register layout
> > pw ID: 2825593
I have redone the topic branch picking the v2 patch

> I suggest to revert that commit and apply the correct one.
> 
> 2. you missed this patch:
> 
> > DMA: shdma: move two macros to a header
> > pw ID: 2831934
> 
> Please, pick it up too, even though it's just a cosmetic one.
I ahve fixed that up in merge, pls verfiy. So need need of update patch which
you sent..

~Vinod
