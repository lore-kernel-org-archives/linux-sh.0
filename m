From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Oct 2008 04:24:45 +0000
Subject: Re: [RFC][PATCH] sh: override DMA interrupt handler to dma-sh driver
Message-Id: <20081020042445.GC20044@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 29, 2008 at 06:26:45PM +0900, Nobuhiro Iwamatsu wrote:
> Dma-sh has fixed interrupt handler and cannot register
> an interrupt for exclusive use of the device with dma.
> 
> I added a handler to sh_dmac_request_dma and reviced it
> to be able to appoint a handler.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@nigauri.org>

While I don't have anything against the idea, I don't care for the
approach. It is not acceptable to break the API every time you wish to
extend soem basic functionality. The addition of request_dma_bycap()
itself should have been a good indicator of this, as we didn't simply
hack request_dma() in-place. Part of the reason for this is also because
request_dma()/free_dma() are legacy interfaces from the ISA DMA days, and
are virtually consistent across the entire tree.

Having said that, wanting to register data with a channel or set a
specific handler for it is perfectly reasonable, but this is something
you ought to model after the generic hardirq layer and driver model, have
special routines that set/get a private data pointer and one for setting
the IRQ handler. The other thing to note is that you do not want to blow
away the existing IRQ handler in the controller driver either, since that
contains logic relative to your channel anyways (ie, TEI handling). You
are likely better off introducing a new capability that takes priority
over TEI handling and requires a special handler, but note that CHCR
handling itself should only be done by the controller driver. If you wish
to make use of a DMA channel in a generic driver, that is perfectly fine,
but you should not be exposing _any_ dma-sh internals there, especially
for the IRQ top half.
