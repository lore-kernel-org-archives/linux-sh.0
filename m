From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 01 Feb 2008 03:00:24 +0000
Subject: Re: [PATCH] sh: use declared coherent memory for dreamcast pci ethernet adapter
Message-Id: <20080201030024.GA2150@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jan 27, 2008 at 01:37:40PM +0900, Magnus Damm wrote:
> On Jan 26, 2008 6:46 AM, Adrian McMenamin
> <adrian@newgolddream.dyndns.info> wrote:
> >
> > On Fri, 2008-01-25 at 21:00 +0000, Adrian McMenamin wrote:
> > > On Fri, 2008-01-25 at 13:16 +0900, Magnus Damm wrote:
> > >
> > > > Can you please apply the attached patch and test both with and without
> > > > the 3 declared coherent patches? I'd like to see the values printed
> > > > out by printk() both with and without the declared coherent patches.
> > > >
> > > > Thank you.
> > > >
> > > > / magnus
> > >
> > > Without the coherency patches...
> > > [    2.833387] zzzzzzzz:tx_bufs = 0xa1840000/0x01840000, rx_ring > > > 0xa1842000/0x01842000, (0x00000000)
> > >
> > With the coherency patches...
> >
> >
> > [    2.890870] zzzzzzzz:tx_bufs = 0xa1840000/0x01840000, rx_ring = 0x00000000/0x00000000, (0x8cd010e0)
> 
> Ok, it looks like i got the dma values right at least, but that the rx
> ring allocation fails.
> 
> The amount of dma memory for the dreamcast ethernet adapter seems to
> be 8 pages (32k), and for dreamcast the 8139too driver allocates 2
> pages (4*1536) for tx and 5 pages (16k+16+2048) for rx. It all adds up
> to 7 pages (tx+rx) which in theory should fit within 8 pages of
> available dma memory.
> 
> It does however look like the bitmap code operates on order
> granularity both when it comes to size and alignment which means that
> the rx allocation of 5 pages becomes an order 3 allocation - 8 pages
> aligned to 8 pages - which in turn results in that we can't fulfill
> the allocation request. At least that's my theory. =)
> 
> As a test and/or workaround, can you try changing RX_BUF_IDX in
> 8139too.c from 1 in the dreamcast case to 0? That should result in 3
> pages for the rx buffer which should lead to an order 2 allocation
> unless I'm mistaken. And we should be able to fulfill that request
> without problems.
> 
> Does the RX_BUF_IDX change make the declared coherent patches work?
> 
Adrian? It would be nice to know if dropping RX_BUF_IDX works for you.
The other alternative is to break this down on to a single page boundary,
but that requires that we change the bitmap management approach away from
order-granularity. I've hacked together some changes in the bitmap API to
handle this as a proof of concept, so at least it's doable, and it may
make sense to try and extend the API in this way in the future.
