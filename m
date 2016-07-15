From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 15 Jul 2016 15:35:55 +0000
Subject: Re: [PATCH v3 08/12] irqchip: add J-Core AIC driver
Message-Id: <CAP=VYLpWZmLHvTa0=bb9i4J5U=OMpNOM33Nx6C1zSMKzNCrf9g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org> <05a5be0a4f1471272dcdd2259e4d97642ee43759.1464148904.git.dalias@libc.org>
In-Reply-To: <05a5be0a4f1471272dcdd2259e4d97642ee43759.1464148904.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, May 25, 2016 at 1:43 AM, Rich Felker <dalias@libc.org> wrote:
> There are two versions of the J-Core interrupt controller in use, aic1
> which generates interrupts with programmable priorities, but only
> supports 8 irq lines and maps them to cpu traps in the range 17 to 24,
> and aic2 which uses traps in the range 64-127 and supports up to 128
> irqs, with priorities dependent on the interrupt number. The Linux
> driver does not make use of priorities anyway.
>
> For simplicity, there is no aic1-specific logic in the driver beyond
> setting the priority register, which is necessary for interrupts to
> work at all. Eventually aic1 will likely be phased out, but it's
> currently in use in deployments and all released bitstream binaries.
>
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>
> This version fixes a missing "static" reported in the previous
> version of the patch. I missed Marc Zyngier's reply to the v2 when
> preparing the v3 patch series, but I'm still not sure exactly what, if
> any, changes should come out of that discussion, and they'll probably
> mostly in the area of comments or changelog.
>
>  drivers/irqchip/Kconfig         |  6 +++
>  drivers/irqchip/Makefile        |  1 +
>  drivers/irqchip/irq-jcore-aic.c | 95 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 drivers/irqchip/irq-jcore-aic.c
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 3e12479..3cb37d6 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -149,6 +149,12 @@ config PIC32_EVIC
>         select GENERIC_IRQ_CHIP
>         select IRQ_DOMAIN
>
> +config JCORE_AIC
> +       bool "J-Core integrated AIC"
> +       select IRQ_DOMAIN
> +       help
> +         Support for the J-Core integrated AIC.
> +
>  config RENESAS_INTC_IRQPIN
>         bool
>         select IRQ_DOMAIN
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index b03cfcb..5a1f1bf 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_I8259)                   += irq-i8259.o
>  obj-$(CONFIG_IMGPDC_IRQ)               += irq-imgpdc.o
>  obj-$(CONFIG_IRQ_MIPS_CPU)             += irq-mips-cpu.o
>  obj-$(CONFIG_SIRF_IRQ)                 += irq-sirfsoc.o
> +obj-$(CONFIG_JCORE_AIC)                        += irq-jcore-aic.o
>  obj-$(CONFIG_RENESAS_INTC_IRQPIN)      += irq-renesas-intc-irqpin.o
>  obj-$(CONFIG_RENESAS_IRQC)             += irq-renesas-irqc.o
>  obj-$(CONFIG_VERSATILE_FPGA_IRQ)       += irq-versatile-fpga.o
> diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
> new file mode 100644
> index 0000000..1348cdb
> --- /dev/null
> +++ b/drivers/irqchip/irq-jcore-aic.c
> @@ -0,0 +1,95 @@
> +/*
> + * J-Core SoC AIC driver
> + *
> + * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>

Please don't use module.h or MODULE_* in code that is controlled by
a bool Kconfig.

Thanks,
Paul.
