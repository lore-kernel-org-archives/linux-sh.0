From: "Roni Feldman" <ronifeldman@gmail.com>
Date: Sat, 04 Oct 2008 16:14:57 +0000
Subject: Re: [RFC] sh7751(r): Adding support for PCI-DMA
Message-Id: <7b5883fc0810040914j20118f8bt737af5982c3f53a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <7b5883fc0809260450w642dde94k1c25166d8305f007@mail.gmail.com>
In-Reply-To: <7b5883fc0809260450w642dde94k1c25166d8305f007@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Ah, I see. I'm using this on a custom platform as a mechanism for
message delivery between the PC and the card on which the SH-4 sits.
But I get your point -- if nobody besides me seems to need it / use
it, then there's no need to add it to the tree.
As for "generic tying" -- from what I've seen, most of the PCI
mechanisms in the kernel are concerned with memory/PCI exposure, and
not the act of transfer itself, since most of the time the CPU doesn't
do the transfer. I couldn't think of a good way to insert this into
the existing DMA code.

If you want a simple example:
---
u32 val;
int retval;
dma_addr_t dma_addr;
int chan;

val = 0xAABBCCDD;
chan = request_pci_dma();
dma_addr = pci_map_single(NULL, (void *)&val, sizeof(val), PCI_DMA_TODEVICE);
pci_dma_start_transfer(chan, dma_addr, SOME_PCI_ADDRESS, sizeof(val),
PCI_DMA_TODEVICE);
retval = pci_dma_wait_for_completion(chan);
free_pci_dma(chan);
pci_unmap_single ...
---

Anyway, feel free to put it on hold until somebody finds use for it.

Roni.


On Tue, Sep 30, 2008 at 4:56 AM, Paul Mundt <lethal@linux-sh.org> wrote:
>
> On Tue, Sep 30, 2008 at 12:02:57AM +0300, Roni Feldman wrote:
> > Hey Paul,
> >
> > The code only supplies a transfer mechanism, that is - a way to start
> > it and a way to be notified when it ends. If I'm not mistaken the
> > PCI-DMA mapping thing is supposed to behave like any other DMA
> > mechanism in the system. You just use pci_map_*, do a transfer, and
> > then pci_unmap_* it. That's what I do in my code, at least.
> >
> Yes, but the actual user of this code is missing from your patch, which
> is why I was wondering how you were attempting to use it. If you can post
> the patch for that also, then we can look at what needs to be done for
> tying it in generically.
