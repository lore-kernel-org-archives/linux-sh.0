From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 21 Jun 2011 10:34:17 +0000
Subject: Re: [PATCH] usb: renesas_usbhs: use dma handler
Message-Id: <w3pliwvxyl2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3psjr3yauo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3psjr3yauo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

Thank you for your check


> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/usb/renesas_usbhs/mod_gadget.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> Does this have any dependencies? What about platforms that don't support
> dmaengine?

renesas_usbhs driver will use PIO mode if platforms doesn't have/support
dmaengine

more explain or rename needed ?

Best regards
--
Kuninori Morimoto
 
