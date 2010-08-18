From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 18 Aug 2010 21:44:40 +0000
Subject: Re: [regression] in linux-next: sh_mobile_ceu_camera broken by
Message-Id: <20100818214440.GA22254@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
	<20100810092759.GB31759@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008102117000.18934@axis700.grange>
	<20100810212638.GC7702@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008182107210.17895@axis700.grange>
	<20100818194109.GA19126@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008182218150.17895@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008182218150.17895@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 18, 2010 at 10:31:10PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 18 Aug 2010, Russell King - ARM Linux wrote:
> > Sounds like a sane approach to fixing this to me.
> 
> I assume, you mean adding a new flag to skip ioremap(). But then we have 
> to pass the virtual address to the function. Its prototype is
> 
> int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
> 				dma_addr_t device_addr, size_t size, int flags);
> 
> bus_addr is unused in this case, but I don't think abusing it to pass a 
> "void *" would be an acceptable solution - apart from all the ugly 
> type-casting, if we ever get 64-bit virtual addresses on ARM with 32-bit 
> DMA addresses, we've got a problem. Or is this never going to happen? Or 
> whould I rather add a new function?

A new function sounds saner.
