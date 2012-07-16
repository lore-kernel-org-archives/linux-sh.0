From: Vinod Koul <vinod.koul@linux.intel.com>
Date: Mon, 16 Jul 2012 08:40:25 +0000
Subject: Re: [PATCH 5/7 v2] dma: sh: use an integer slave ID to improve API compatibility
Message-Id: <1342427305.1726.50.camel@vkoul-udesk3>
List-Id: <linux-sh.vger.kernel.org>
References: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
	 <1341484183-10757-6-git-send-email-g.liakhovetski@gmx.de>
	 <1342418828.1726.37.camel@vkoul-udesk3>
	 <Pine.LNX.4.64.1207160832540.12302@axis700.grange>
	 <1342421587.1726.49.camel@vkoul-udesk3>
	 <Pine.LNX.4.64.1207160907180.12302@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207160907180.12302@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2012-07-16 at 09:13 +0200, Guennadi Liakhovetski wrote:
> > > They tell the driver how the channel has to be configured to
> support this 
> > > specific client. They are values of two specific registers. In
> fact, CHCR 
> > > means exactly that - CHannel Control Register.
> > what exactly does the channel control register do in shdma? Should
> shdma
> > driver deduce this value rather than client giving it?
> > Same question for mid_rid?
> 
> See, e.g.,
> arch/arm/mach-shmobile/setup-sh7372.c::sh7372_dmae_slaves[]. 
> Platforms are supplying these values with shdma driver platform data, 
> together with slave IDs. Them when slaves request channels and supply 
> their slave IDs, the driver searches the above array, looking for the 
> matching slave ID, then it uses the rest of the information in those 
> structs to configure the channel for this client. Again, this is
> nothing 
> new, this is how the driver has been functioning since a long time,
> this 
> driver is not modifying anything there. Any changes to this
> procedure, 
> like providing all thig information from clients themselves instead
> of 
> keeping it with DMACs, requires these patches to be committed first.
That wasn't my question.

I want to know what does ccr and mid_rid mean to dmac here?

-- 
~Vinod

