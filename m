From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 16 Jul 2012 10:01:25 +0000
Subject: Re: [PATCH 5/7 v2] dma: sh: use an integer slave ID to improve API compatibility
Message-Id: <Pine.LNX.4.64.1207161155280.12302@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de> 
 <1341484183-10757-6-git-send-email-g.liakhovetski@gmx.de> 
 <1342418828.1726.37.camel@vkoul-udesk3>  <Pine.LNX.4.64.1207160832540.12302@axis700.grange>
  <1342421587.1726.49.camel@vkoul-udesk3>  <Pine.LNX.4.64.1207160907180.12302@axis700.grange>
  <1342427305.1726.50.camel@vkoul-udesk3>  <Pine.LNX.4.64.1207161040070.12302@axis700.grange>
 <1342431452.1726.54.camel@vkoul-udesk3>
In-Reply-To: <1342431452.1726.54.camel@vkoul-udesk3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 16 Jul 2012, Vinod Koul wrote:

> On Mon, 2012-07-16 at 10:47 +0200, Guennadi Liakhovetski wrote:
> > > I want to know what does ccr and mid_rid mean to dmac here?
> > 
> > CHCR contains a few fields, some enable various interrupt sources, some 
> > specify repeat- and renew-modes, others yet specify transfer size, source 
> > and destination address-modes (incrementing, constant, decrementing), 
> > others yet select a DMA client category (slave / memcpy / ...), and a 
> > transfer flag. Some of these fields could be calculated, others are 
> > pre-defined for various slaves, the exact layout of those fields can also 
> > vary between SoCs.
> I do not understand how clients would provide these values. 
> For pre-defined values, they should be dmac property why should client
> like spi or mmc have clue about it?
> 
> For others like you mentioned, i guess they could be easily calculated,
> right?
> 
> > MID_RID is actually a slave-selector, it contains a magic value, that 
> > cannot be calculated. 
> and again, how does client know this?

I might be misunderstanding you, but from earlier discussions I got an 
impression, that the DMAC should know nothing about clients, i.e., should 
receive no client-specific information from its platform data. Instead 
clients should provide it when configuring the channel. If this is 
correct, then the preferred way would be to specify these values in client 
platform data and then pass it to the DMAC with slave-config calls? Or 
have I misunderstood you and this per-client information should be kept in 
DMAC platform data?

I.e., in both cases magic values are provided by platforms, the only 
difference is - either keep them in DMAC platform data or move them in 
each individual DMA client platform data.

Yes, some CHCR fields can be calculated, but location and width of those 
fields might vary between DMAC versions, so, they will have to be passed 
with DMAC platform data. But this definitely can be done in the future.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
