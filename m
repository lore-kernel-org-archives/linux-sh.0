From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 May 2011 04:24:10 +0000
Subject: Re: [PATCH 2/2] ARM: mach-shmobile: mackerel: add renesas_usbhs
Message-Id: <w3p7h9fv251.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

Thank you for checking

> > OTOH, CN22 USB0 which is only USB Function
> > can not use USB-phy interrupt (IRQ7) on mackerel board.
> > Because IRQ7 is already used by Touchscreen,
> > and it is impossible to use cascaded IRQ7.
> > 
> Why is it impossible to have an IRQ7 demux?

Sorry for insufficient explanation.

USB-phy needs IRQ7-PORT167, and Touchscreen needs IRQ7-PORT40.
IRQ7 PORT 167/40 are controlled by GPIO.
I think it is impossible to have IRQ7 demux.

> > But you can not select both CONFIG_USB_R8A66597_HCD and
> > CONFIG_USB_RENESAS_USBHS in same time for now.
> > Because IRQ8 will be requested in different driver.
> > 
> Is there some particular reason why IRQF_SHARED isn't sufficient for
> working around this? Since you're leveraging the IORESOURCE PnP IRQ bits
> anyways, you could easily just or in IORESOURCE_IRQ_SHAREABLE and
> translate that in to an IRQF_SHARED at request_irq() time for the cases
> that need it.

renesas_usbhs is new version of r8a66597_xxx driver.
This means both will access to same register.
So, we can not keep correct operation
if these driver are probed in same time.

Does this become reason ?
If yes, shall I send v2 patch ?

Best regards
--
Kuninori Morimoto
 
