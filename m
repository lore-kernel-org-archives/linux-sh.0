From: Simon Horman <horms@verge.net.au>
Date: Tue, 23 Jul 2013 01:47:01 +0000
Subject: Re: [PATCH v2 0/3] ARM: shmobile: sh73a0: fix spurious irqpin interrupts
Message-Id: <20130723014701.GH16481@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1374510105-21896-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374510105-21896-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 22, 2013 at 06:21:42PM +0200, Guennadi Liakhovetski wrote:
> On sh73a0 irqpin interrupts have to be masked on the parent GIC controller.
> This can only be done if interrupts are mapped when the first spurious IRQ
> occurs. Patch 2 in this series maps all irqpin interrupts at probe time to
> fix the problem. The third patch adds support for an irqpin IRQ to
> kzm9g-reference.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Magnus, could you review this?

> 
> Guennadi Liakhovetski (3):
>   ARM: shmobile: sh73a0: fix spurious irqpin interrupts in the DT case
>   irqchip: intc-irqpin: pre-map all interrupts in the DT case
>   ARM: shmobile: kzm9g-reference: use GPIO for card detection on SDHI2
> 
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    2 +-
>  arch/arm/boot/dts/sh73a0.dtsi                |    2 ++
>  drivers/irqchip/irq-renesas-intc-irqpin.c    |   10 +++++++++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> -- 
> 1.7.2.5
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 
