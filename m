From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 28 Aug 2013 06:01:17 +0000
Subject: Re: [PATCH] DMA: shdma: fix a bad merge - remove free_irq()
Message-Id: <20130828054917.GI2748@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1308261426320.1767@axis700.grange>
 <20130826135308.GP2748@intel.com>
 <Pine.LNX.4.64.1308271028500.11515@axis700.grange>
 <20130827090112.GT2748@intel.com>
 <Pine.LNX.4.64.1308271625560.11515@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1308271625560.11515@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms@verge.net.au>

On Tue, Aug 27, 2013 at 04:46:51PM +0200, Guennadi Liakhovetski wrote:
> Ok, to me it looks like you did fix some patches in the topic/sh branch, 
> but:
> 
> patch "DMA: shdma: move two macros to a header" is missing
> patch "dma: use dev_get_platdata()" is missing (but ok, it's common for 
> drivers/dma, not sh-specific)
I havent applied that yet, its in my queue..
> patch "shdma: fixup sh_dmae_get_partial() calculation error" is missing
Can you resend these two...?

~Vinod
