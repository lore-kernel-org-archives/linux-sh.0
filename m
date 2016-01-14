From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Jan 2016 17:30:40 +0000
Subject: Re: [RFC v4 1/4] watchdog: renesas-rwdt: add driver
Message-Id: <CAMuHMdUfnY+iUZn-Ay2KZzXWUDGYVjVaBJcayuVAqwocOLQ7xg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Fri, Jan 8, 2016 at 10:12 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Add support for an RCLK watchdog found on RCar Gen3 based SoCs from
> Renesas. A restart handler is in place, too.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/watchdog/renesas-rwdt.txt  |  18 ++
>  drivers/watchdog/Kconfig                           |   8 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/renesas_rwdt.c                    | 224 +++++++++++++++++++++
>  4 files changed, 251 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/renesas-rwdt.txt
>  create mode 100644 drivers/watchdog/renesas_rwdt.c
>
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-rwdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-rwdt.txt
> new file mode 100644
> index 00000000000000..fd050d5e5e0002
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-rwdt.txt
> @@ -0,0 +1,18 @@
> +Renesas RCLK Watchdog Timer (RWDT) Controller
> +
> +Required properties:
> +- compatible : Should be "renesas,rwdt-r8a7795";

"renesas,r8a7795-rwdt", and "renesas,rcar-gen3-rwdt" as a fallback, to match
current best practices?

> +- reg : Should contain WDT registers location and length
> +- clocks : the clock feeding the watchdog timer.
> +
> +Optional properties:
> +- timeout-sec : Contains the watchdog timeout in seconds

Isn't this a software configuration thingy? I.e. does it belong it DT?

> +Examples:
> +
> +       wdt0: wdt@e6020000 {
> +               compatible = "renesas,rwdt-r8a7795";
> +               reg = <0 0xe6020000 0 0x0c>;
> +               clocks = <&cpg CPG_MOD 402>;

Missing "power-domains = <&cpg>;"

> +               timeout-sec = <60>;
> +       };

> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -636,6 +636,14 @@ config ATLAS7_WATCHDOG
>           To compile this driver as a module, choose M here: the
>           module will be called atlas7_wdt.
>
> +config RENESAS_RWDT
> +       tristate "Renesas RWDT Watchdog"
> +       depends on ARCH_SHMOBILE || COMPILE_TEST
> +       select WATCHDOG_CORE
> +       help
> +         This driver adds watchdog support for the integrated watchdog in the
> +         Renesas RCar and other SH Mobile SoCs.

"R-Car", "SH-Mobile"

> --- /dev/null
> +++ b/drivers/watchdog/renesas_rwdt.c
> @@ -0,0 +1,224 @@
> +/*
> + * Watchdog driver for Renesas RWDT watchdog
> + *
> + * Copyright (C) 2015-16 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
> + * Copyright (C) 2015-16 Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/watchdog.h>
> +
> +#define RWTCNT         0
> +#define RWTCSRA                4
> +#define RWTCSRA_WOVF   BIT(4)
> +#define RWTCSRA_WRFLG  BIT(5)
> +#define RWTCSRA_TME    BIT(7)
> +
> +#define RWDT_DEFAULT_TIMEOUT 60

"60U", so no more (hidden) casts needed.

> +static const unsigned clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024 };
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, S_IRUGO);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +struct rwdt_priv {
> +       void __iomem *base;
> +       struct watchdog_device wdev;
> +       struct clk *clk;
> +       struct notifier_block restart_handler;
> +       unsigned clks_per_sec;
> +       u8 cks;
> +};
> +
> +static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned reg)
> +{
> +       if (reg = RWTCNT)
> +               val |= 0x5a5a0000;
> +       else
> +               val |= 0xa5a5a500;
> +
> +       writel_relaxed(val, priv->base + reg);
> +}
> +
> +static int rwdt_init_timeout(struct watchdog_device *wdev)
> +{
> +       struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +       rwdt_write(priv, 65536 - wdev->timeout * priv->clks_per_sec, RWTCNT);
> +
> +       return 0;
> +}
> +
> +static int rwdt_set_timeout(struct watchdog_device *wdev, unsigned new_timeout)
> +{
> +       wdev->timeout = new_timeout;
> +       rwdt_init_timeout(wdev);
> +
> +       return 0;
> +}
> +
> +static int rwdt_start(struct watchdog_device *wdev)
> +{
> +       struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +       clk_prepare_enable(priv->clk);

pm_runtime_get_sync()?

You also have to call pm_runtime_enable() etc. in probe()/remove().

> +
> +       rwdt_write(priv, priv->cks, RWTCSRA);
> +       rwdt_init_timeout(wdev);
> +
> +       while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
> +               cpu_relax();
> +
> +       rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
> +
> +       return 0;
> +}
> +
> +static int rwdt_stop(struct watchdog_device *wdev)
> +{
> +       struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +       rwdt_write(priv, priv->cks, RWTCSRA);
> +       clk_disable_unprepare(priv->clk);

pm_runtime_put()?

> +       return 0;
> +}
> +
> +static const struct watchdog_info rwdt_ident = {
> +       .options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
> +       .identity = "Renesas RWDT Watchdog",
> +};

> +static int rwdt_probe(struct platform_device *pdev)
> +{
> +       struct rwdt_priv *priv;
> +       struct resource *res;
> +       unsigned long rate;
> +       unsigned clks_per_sec;
> +       int ret, i;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       priv->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       priv->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(priv->clk))
> +               return PTR_ERR(priv->clk);
> +
> +       clk_prepare_enable(priv->clk);
> +       rate = clk_get_rate(priv->clk);
> +       clk_disable_unprepare(priv->clk);

I think the clk enablement was needed in v2, because you wanted to read the
RWTCSRA register, but that was already removed in v3?

> +       if (!rate)
> +               return -ENOENT;

-EINVAL?

> +       for (i = ARRAY_SIZE(clk_divs); i >= 0; i--) {
> +               clks_per_sec = rate / clk_divs[i];
> +               if (clks_per_sec) {
> +                       priv->clks_per_sec = clks_per_sec;
> +                       priv->cks = i;
> +                       break;
> +               }
> +       }
> +
> +       if (!clks_per_sec) {
> +               dev_err(&pdev->dev, "Can't find suitable clock divider!\n");
> +               return -ERANGE;

-EINVAL?

> +       }
>
> +       priv->wdev.info = &rwdt_ident,
> +       priv->wdev.ops = &rwdt_ops,
> +       priv->wdev.parent = &pdev->dev;
> +       priv->wdev.min_timeout = 1;
> +       priv->wdev.max_timeout = 65536 / clks_per_sec;
> +       priv->wdev.timeout = min_t(unsigned, priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOUT);

If RWDT_DEFAULT_TIMEOUT would be unsigned, you could use min() instead
of min_t().

> +/*
> + * This driver does also fit for RCar Gen2 (r8a779[0-4]) RWDT. However, for SMP

R-Car

> + * to work there, one also needs a RESET (RST) driver which does not exist yet
> + * due to HW issues. This needs to be solved before adding compatibles here.

Isn't there some setup needed on R-Car Gen3, too?

That can be done either outside, or inside this driver.
I think it should be done inside this driver, as doing the setup must be
performed while the watchdog is not armed, else it may trigger immediately.
Or is there some other way to coordinate?

See also my comments for v2 and v1
(http://www.spinics.net/lists/linux-sh/msg46221.html)
(http://www.spinics.net/lists/linux-sh/msg39799.html)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
