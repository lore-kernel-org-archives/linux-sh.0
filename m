From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 21 Jan 2008 07:05:53 +0000
Subject: Re: [PATCH] sh: add resource of USB for SH7720
Message-Id: <20080121070552.GA19803@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <47860ABA.7000407@renesas.com>
In-Reply-To: <47860ABA.7000407@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 21, 2008 at 08:00:33AM +0100, Manuel Lauss wrote:
> On Sun, Jan 20, 2008 at 01:15:16AM -0800, Kristoffer Ericson wrote:
> > Greetings,
> > 
> > Without looking to heavily in the hd64465 datasheet, you think this
> > would work for hd64465+SH7729 platform? It contains an OHCI based usb
> > host.
> 
> Not without some additional changes to the OHCI stack.
> The HD64465 OHCI (and the SH7760 OHCI too) can only do transfers
> from/to its internal SRAM; the Linux OHCI stack simply assumes
> that the HC can read all Transfer Descriptors (TD) and data
> from main memory.
> Also, SRAM is rather small (8kB IIRC) so you can forget about 
> USB mass storage outright (and bluetooth dongles too), only
> keyboards and mice work right.
> Finally, the SRAM has different addresses, depending on who's
> accessing it (HC or CPU), making it necessary to go over the
> TDs and adjust the data pointers to 'HC-view' before transfer
> and 'CPU-view' after they're done.
> 
> In short: the hardware sucks... ;-)
> 
http://marc.info/?l=linux-usb-devel&m0027668329758&w=2
http://marc.info/?l=linux-usb-devel&m0055283608988&w=2
