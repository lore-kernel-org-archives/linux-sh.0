From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 28 Aug 2013 07:18:55 +0000
Subject: Re: [PATCH] DMA: shdma: fix a bad merge - remove free_irq()
Message-Id: <Pine.LNX.4.64.1308280841530.22743@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1308261426320.1767@axis700.grange>
 <20130826135308.GP2748@intel.com> <Pine.LNX.4.64.1308271028500.11515@axis700.grange>
 <20130827090112.GT2748@intel.com> <Pine.LNX.4.64.1308271625560.11515@axis700.grange>
 <20130828054917.GI2748@intel.com>
In-Reply-To: <20130828054917.GI2748@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms@verge.net.au>

Hi Vinod,

On Wed, 28 Aug 2013, Vinod Koul wrote:

> On Tue, Aug 27, 2013 at 04:46:51PM +0200, Guennadi Liakhovetski wrote:
> > Ok, to me it looks like you did fix some patches in the topic/sh branch, 
> > but:
> > 
> > patch "DMA: shdma: move two macros to a header" is missing
> > patch "dma: use dev_get_platdata()" is missing (but ok, it's common for 
> > drivers/dma, not sh-specific)
> I havent applied that yet, its in my queue..
> > patch "shdma: fixup sh_dmae_get_partial() calculation error" is missing
> Can you resend these two...?

Ok, sorry, there was some confusion: yesterday no -next tree was 
available, so, I had to use the ARM sh-mobile tree with your slave-dma 
"next" branch merged on top. So, of the 3 above patches

1. "DMA: shdma: move two macros to a header"
2. "dma: use dev_get_platdata()"
3. "shdma: fixup sh_dmae_get_partial() calculation error"

#2 and #3 are already in "next" as 3c4d927 and d4adcc0 respectively, so, 
no need to resend. #1 is available here 
https://patchwork.kernel.org/patch/2831934/

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
