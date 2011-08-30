From: Vinod Koul <vinod.koul@linux.intel.com>
Date: Tue, 30 Aug 2011 10:14:02 +0000
Subject: Re: [PATCH] serial: sh-sci: don't filter on DMA device, use only
Message-Id: <1314698522.1606.164.camel@vkoul-udesk3>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1106241354060.6014@axis700.grange>
	 <1308916071.1536.4.camel@vkoul-udesk3>
	 <20110829080047.GJ31809@linux-sh.org>
	 <CANqRtoRn-Csu+Rns6dn6=cJmRqbZfLKXA9brs8Ug9rFvGRn78w@mail.gmail.com>
	 <1314618931.1606.114.camel@vkoul-udesk3>
	 <Pine.LNX.4.64.1108300931220.19151@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1108300931220.19151@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Magnus Damm <damm@opensource.se>

On Tue, 2011-08-30 at 09:54 +0200, Guennadi Liakhovetski wrote:
> On Mon, 29 Aug 2011, Vinod Koul wrote:
> > > >> You should not assign chan->private.
> > > >> Please move this  to dma_slave_control API
> > > >
> > > > I haven't seen any reply to this comment and this patch seems to still be
> > > > outstanding, is there an updated version of this patch that I've missed?
> > I don't recall seeing any updated version fixing this 
> 
> As a matter of fact, when you say "use dma_slave_control API," you 
> actually mean the dma_slave_config, right? Then, how is one supposed to 
> use it in this case? Shall we be issuing a DMA_SLAVE_CONFIG call inside of 
> the filter and check the return code? The problem is, that not all DMA 
> controllers on sh-mobile SoCs can service the same slave devices. So, if 
> we don't check in the filter we might well get an unsuitable DMA channel.
Here you are assigning to chan->private your specific values, which
should be moved to the dma_slave_config. 
But here you are removing the checks, and accepting the first channel
you got, so how do you find channel is suitable or not.

-- 
~Vinod

