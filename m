From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 03 Feb 2010 23:39:55 +0000
Subject: Re: [PATCH] sh: added PWM driver for SH7723 using the TPU
Message-Id: <20100203233955.GC21857@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F0171E8D499FD@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0171E8D499FD@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 03, 2010 at 03:35:45PM +0100, Pietrek, Markus wrote:
> diff --git a/arch/sh/drivers/Kconfig b/arch/sh/drivers/Kconfig
> index 420c6b2..83c8794 100644
> --- a/arch/sh/drivers/Kconfig
> +++ b/arch/sh/drivers/Kconfig
> @@ -16,4 +16,11 @@ config PUSH_SWITCH
>           This enables support for the push switch framework, a simple
>           framework that allows for sysfs driven switch status reporting.
> 
> +config SH_PWM_TPU
> +       bool "PWM with Timer Pulse Unit (TPU) Driver"
> +       depends on CPU_SUBTYPE_SH7723
> +       select HAVE_PWM
> +        help
> +          Provides a PWM driver using the Timer Pulse Unit of the SH7723
> +
The cleaner way to do this would be to have something like:

config SYS_SUPPORTS_TPU
	bool

in arch/sh/Kconfig, followed by having SH7723 select that. Then your
SH_PMW_TPU config option can just depend on SYS_SUPPORTS_TPU, and it will
be automatically visible for any future CPU that indicates block support.

> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +#include <linux/pwm.h>
> +
> +#ifdef CONFIG_CPU_SUBTYPE_SH7723
> +# include <cpu/sh7723.h>
> +#endif
> +
Presumably you wanted this header for ..

> +static const int gpios[CHANNELS] = {
> +#ifdef CONFIG_CPU_SUBTYPE_SH7723
> +       GPIO_PTG0,
> +       GPIO_PTG1,
> +       GPIO_PTG2,
> +       GPIO_PTG3,
> +#else
> +# error no GPIO configuration for cpu
> +#endif
> +};
> +
this. However, you should simply construct the GPIO map through platform
data and pass it along when registering the device from the CPU code.

> +EXPORT_SYMBOL(pwm_disable);
> +
Is EXPORT_SYMBOL() intentional? By convention we primarily use
EXPORT_SYMBOL_GPL() for new exports.

> +/* driver registering functions */
> +
> +static int __devinit pwm_tpu_probe(struct platform_device *pdev)
> +{
[snip]

> +       priv->base = ioremap(res->start, (res->end-res->start)+1);

Although you didn't succumb to the off-by-1 bug that most people do, you
should still use resource_size() here to avoid ambiguity. :-)

> +MODULE_AUTHOR("Markus Pietrek");
> +MODULE_DESCRIPTION("PWM/Timer Pulse Unit TPU control");
> +MODULE_LICENSE("GPL");
> +
> +arch_initcall(pwm_tpu_init);
> +module_exit(pwm_tpu_exit);

arch_initcall() is a bit early, presumably you have some users of this
code that actually needs to have this initialized that early on?

Looks good otherwise.
