From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 16 Apr 2012 00:52:00 +0000
Subject: Re: [PATCH 0/2] ARM: mach-shmobile: r8a7740: USB Function support
Message-Id: <8762d07b2r.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjg82c56.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjg82c56.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > These are USB Function support patches for Armadillo board.
> > 
> > Kuninori Morimoto (2):
> >       ARM: mach-shmobile: r8a7740: add usb clock support
> >       ARM: mach-shmobile: armadillo800eva: add USB function support
> 
> Hi Morimoto-san,
> 
> could you give me some pointers on configuring the kernel to
> enable USB on the A1 board with these patches applied?

Thank you for tring this patch.

Please select

CONFIG_USB_RENESAS_USBHS=y
CONFIG_USB_RENESAS_USBHS_UDC=y

And select SW1.6 ON.

But I would like to update this patch set today.

Best regards
---
Kuninori Morimoto
