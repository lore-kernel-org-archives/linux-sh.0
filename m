From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Sun, 27 Jan 2008 04:37:40 +0000
Subject: Re: [PATCH] sh: use declared coherent memory for dreamcast pci ethernet adapter
Message-Id: <aec7e5c30801262037w23d99912n13414aa9f5e2667d@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adrian,

Thanks for testing and posting the results.

On Jan 26, 2008 6:46 AM, Adrian McMenamin
<adrian@newgolddream.dyndns.info> wrote:
>
> On Fri, 2008-01-25 at 21:00 +0000, Adrian McMenamin wrote:
> > On Fri, 2008-01-25 at 13:16 +0900, Magnus Damm wrote:
> >
> > > Can you please apply the attached patch and test both with and without
> > > the 3 declared coherent patches? I'd like to see the values printed
> > > out by printk() both with and without the declared coherent patches.
> > >
> > > Thank you.
> > >
> > > / magnus
> >
> > Without the coherency patches...
> > [    2.833387] zzzzzzzz:tx_bufs = 0xa1840000/0x01840000, rx_ring > > 0xa1842000/0x01842000, (0x00000000)
> >
> With the coherency patches...
>
>
> [    2.890870] zzzzzzzz:tx_bufs = 0xa1840000/0x01840000, rx_ring = 0x00000000/0x00000000, (0x8cd010e0)

Ok, it looks like i got the dma values right at least, but that the rx
ring allocation fails.

The amount of dma memory for the dreamcast ethernet adapter seems to
be 8 pages (32k), and for dreamcast the 8139too driver allocates 2
pages (4*1536) for tx and 5 pages (16k+16+2048) for rx. It all adds up
to 7 pages (tx+rx) which in theory should fit within 8 pages of
available dma memory.

It does however look like the bitmap code operates on order
granularity both when it comes to size and alignment which means that
the rx allocation of 5 pages becomes an order 3 allocation - 8 pages
aligned to 8 pages - which in turn results in that we can't fulfill
the allocation request. At least that's my theory. =)

As a test and/or workaround, can you try changing RX_BUF_IDX in
8139too.c from 1 in the dreamcast case to 0? That should result in 3
pages for the rx buffer which should lead to an order 2 allocation
unless I'm mistaken. And we should be able to fulfill that request
without problems.

Does the RX_BUF_IDX change make the declared coherent patches work?

Thank you!

/ magnus
