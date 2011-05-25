From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 25 May 2011 05:40:18 +0000
Subject: Re: [PATCH 2/2] ARM: mach-shmobile: mackerel: add renesas_usbhs support for USB1
Message-Id: <20110525054017.GA7317@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 25, 2011 at 01:24:10PM +0900, Kuninori Morimoto wrote:
> > > OTOH, CN22 USB0 which is only USB Function
> > > can not use USB-phy interrupt (IRQ7) on mackerel board.
> > > Because IRQ7 is already used by Touchscreen,
> > > and it is impossible to use cascaded IRQ7.
> > > 
> > Why is it impossible to have an IRQ7 demux?
> 
> Sorry for insufficient explanation.
> 
> USB-phy needs IRQ7-PORT167, and Touchscreen needs IRQ7-PORT40.
> IRQ7 PORT 167/40 are controlled by GPIO.
> I think it is impossible to have IRQ7 demux.
> 
Ok, it would be nice to see this documented somewhere (or at least in the
changelog), as it's not immediately obvious to anyone that isn't staring
at the data sheet.

> > > But you can not select both CONFIG_USB_R8A66597_HCD and
> > > CONFIG_USB_RENESAS_USBHS in same time for now.
> > > Because IRQ8 will be requested in different driver.
> > > 
> > Is there some particular reason why IRQF_SHARED isn't sufficient for
> > working around this? Since you're leveraging the IORESOURCE PnP IRQ bits
> > anyways, you could easily just or in IORESOURCE_IRQ_SHAREABLE and
> > translate that in to an IRQF_SHARED at request_irq() time for the cases
> > that need it.
> 
> renesas_usbhs is new version of r8a66597_xxx driver.
> This means both will access to same register.
> So, we can not keep correct operation
> if these driver are probed in same time.
> 
> Does this become reason ?
> If yes, shall I send v2 patch ?
> 
That's ok, there are enough drivers like that in the kernel that it's
quite acceptable to fall back on a runtime error (ie, request_irq()
failing and the device simply never coming up). The situation we want to
avoid is build-time errors for run-time behavioural problems. In this
case you can simply kill off the #ifdef/#error mess and leave it to the
regular error paths if the user has both configured.
