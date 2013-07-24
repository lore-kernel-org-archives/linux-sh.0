From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 24 Jul 2013 07:02:05 +0000
Subject: Re: [PATCH v2 0/3] ARM: shmobile: sh73a0: fix spurious irqpin interrupts
Message-Id: <Pine.LNX.4.64.1307240854240.30777@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1374510105-21896-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374510105-21896-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus

On Wed, 24 Jul 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Tue, Jul 23, 2013 at 1:21 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On sh73a0 irqpin interrupts have to be masked on the parent GIC controller.
> > This can only be done if interrupts are mapped when the first spurious IRQ
> > occurs. Patch 2 in this series maps all irqpin interrupts at probe time to
> > fix the problem. The third patch adds support for an irqpin IRQ to
> > kzm9g-reference.
> >
> > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> >
> > Guennadi Liakhovetski (3):
> >   ARM: shmobile: sh73a0: fix spurious irqpin interrupts in the DT case
> >   irqchip: intc-irqpin: pre-map all interrupts in the DT case
> >   ARM: shmobile: kzm9g-reference: use GPIO for card detection on SDHI2
> >
> >  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    2 +-
> >  arch/arm/boot/dts/sh73a0.dtsi                |    2 ++
> >  drivers/irqchip/irq-renesas-intc-irqpin.c    |   10 +++++++++-
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> Thanks for bringing this up again.
> 
> Question: Would it be possible to use the following DT style for sh73a0 INTC?
> 
> In sh73a0.dsti:
> status = "disabled"
> 
> In board dt:
> status = "okay"

Sure, that's possible, if we don't just want to enable all of them on all 
boards like we do with all other common devices like interrupt, DMA 
controllers, pinctrl, even I2C controllers for some reason.

> In the DT case, if we could enable only used interrupt controllers
> then perhaps patch 1/3 and 2/3 are not needed?

We then could avoid 1/3 and only add the "control-parent" property to the 
enabled instances in the board code together with the 'status = "okay"' 
property, that's true. But how do you want to remove 2/3? How do you fix 
the problem then?

> If "irqchip: intc-irqpin: pre-map all interrupts in the DT case"
> really is needed, then perhaps some comments in the code describing
> this would be useful?

Can do, sure.

> Regarding patch 3/3, I understand that DT doesn't work with GPIO IRQ.
> But I don't understand how it is related to this series?

Well, you're right, the connection is pretty loose, I can re-submit the 
patch separately.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
