From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 25 May 2011 02:57:02 +0000
Subject: Re: [PATCH 2/2] ARM: mach-shmobile: mackerel: add renesas_usbhs support for USB1
Message-Id: <20110525025701.GI14329@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 25, 2011 at 11:49:25AM +0900, Kuninori Morimoto wrote:
> CN31 USB1 can be Host/Function, and it can use IRQ8 as USB-phy.
> This mean we can power off it if...
>  - while USB1 is disconnected.
>  - USB-Function is selected.
>  - driver is supporting it.
> 
> OTOH, CN22 USB0 which is only USB Function
> can not use USB-phy interrupt (IRQ7) on mackerel board.
> Because IRQ7 is already used by Touchscreen,
> and it is impossible to use cascaded IRQ7.
> 
Why is it impossible to have an IRQ7 demux?

> renesas_usbhs driver which is supporting USB-Function
> is supporting USB power off when disconnect.
> mackerel board will use renesas_usbhs driver as
> USB-Function on CN31 if it have CONFIG_USB_RENESAS_USBHS.
> And r8a66597_hcd will be used as USB Host if it have CONFIG_USB_R8A66597_HCD.
> 
> But you can not select both CONFIG_USB_R8A66597_HCD and
> CONFIG_USB_RENESAS_USBHS in same time for now.
> Because IRQ8 will be requested in different driver.
> 
Is there some particular reason why IRQF_SHARED isn't sufficient for
working around this? Since you're leveraging the IORESOURCE PnP IRQ bits
anyways, you could easily just or in IORESOURCE_IRQ_SHAREABLE and
translate that in to an IRQF_SHARED at request_irq() time for the cases
that need it.
