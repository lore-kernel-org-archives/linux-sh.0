From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Jun 2011 07:11:25 +0000
Subject: Re: [PATCH] usb: renesas_usbhs: use dma handler
Message-Id: <20110624071125.GB26504@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3psjr3yauo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3psjr3yauo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 21, 2011 at 07:34:17PM +0900, Kuninori Morimoto wrote:
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > >  drivers/usb/renesas_usbhs/mod_gadget.c |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > Does this have any dependencies? What about platforms that don't support
> > dmaengine?
> 
> renesas_usbhs driver will use PIO mode if platforms doesn't have/support
> dmaengine
> 
> more explain or rename needed ?
> 
No, that's fine. It wasn't immediately obvious that the PIO fallback and
overriding of the handler was being done in the DMA routines. Looks good
to me, I'll let Greg pick it up for usb-next.
