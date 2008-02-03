From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 03 Feb 2008 21:32:15 +0000
Subject: Re: [PATCH] sh: use declared coherent memory for dreamcast pci
Message-Id: <1202074335.9936.1.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Sun, 2008-01-27 at 13:37 +0900, Magnus Damm wrote:
> Adrian,
> 
> Thanks for testing and posting the results.
> 
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



I am afraid the short answer is "no".

[    2.749341] eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
[    3.756113] Sending DHCP requests .<3>eth0: PCI Bus error 2200.
[    3.760108] eth0: PCI Bus error 2200.
[    3.764106] eth0: PCI Bus error 2200.
[    3.768130] eth0: PCI Bus error 2200.
[    3.772120] eth0: PCI Bus error 2200.
[    3.776112] eth0: PCI Bus error 2200.
[    3.780113] eth0: PCI Bus error 2200.
[    3.784113] eth0: PCI Bus error 2200.
[    3.788090] eth0: PCI Bus error 2200.
[    3.791806] eth0: PCI Bus error 2200.
[    3.792113] eth0: PCI Bus error 2200.
[    3.796113] eth0: PCI Bus error 2200.
[    3.800118] eth0: PCI Bus error 2200.
[    3.804117] eth0: PCI Bus error 2200.
[    3.808113] eth0: PCI Bus error 2200.
[    3.812113] eth0: PCI Bus error 2200.
[    3.816113] eth0: PCI Bus error 2200.
[    3.820122] eth0: PCI Bus error 2200.
[    3.824113] eth0: PCI Bus error 2200.
[    3.828113] eth0: PCI Bus error 2200.
[    3.832113] eth0: PCI Bus error 2200.
[    3.836118] eth0: PCI Bus error 2200.
[    3.840117] eth0: PCI Bus error 2200.
[    3.844114] eth0: PCI Bus error 2200.
[    3.848113] eth0: PCI Bus error 2200.
[    3.852113] eth0: PCI Bus error 2200.
[    3.856122] eth0: PCI Bus error 2200.
[    3.859835] eth0: PCI Bus error 2200.
[    3.860114] eth0: PCI Bus error 2200.
[    3.864114] eth0: PCI Bus error 2200.
[    3.868122] eth0: PCI Bus error 2200.
[    3.872114] eth0: PCI Bus error 2200.
[    3.876114] eth0: PCI Bus error 2200.
[    3.880114] eth0: PCI Bus error 2200.
[    3.884119] eth0: PCI Bus error 2200.
[    3.888118] eth0: PCI Bus error 2200.
[    3.892114] eth0: PCI Bus error 2200.
[    3.896114] eth0: PCI Bus error 2200.
[    3.900114] eth0: PCI Bus error 2200.
[    3.904123] eth0: PCI Bus error 2200.
[    3.908114] eth0: PCI Bus error 2200.
[    3.912115] eth0: PCI Bus error 2200.
[    3.916115] eth0: PCI Bus error 2200.
[    3.920120] eth0: PCI Bus error 2200.
[    3.924119] eth0: PCI Bus error 2200.
[    3.928114] eth0: PCI Bus error 2200.


And so on, seemingly for ever.

