From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Aug 2013 05:33:11 +0000
Subject: Re: [PATCH] EMMA: Add em i2c driver
Message-Id: <CANqRtoRK+Ur=87-me7CpP+s9SO5g0ZVZSEOrqwDf4HFfjZZmZA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377688911-10911-1-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1377688911-10911-1-git-send-email-ian.molton@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian.molton@codethink.co.uk>
Cc: linux-i2c@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, SH-Linux <linux-sh@vger.kernel.org>

Hi Ian,

Thanks for submitting this patch. I have one comment only, please see below.

On Wed, Aug 28, 2013 at 8:21 PM, Ian Molton <ian.molton@codethink.co.uk> wrote:
> Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
>  drivers/i2c/busses/Kconfig  |   10 +
>  drivers/i2c/busses/Makefile |    1 +
>  drivers/i2c/busses/i2c-em.c |  536 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 547 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-em.c
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index dc6dea6..e5cda34 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -777,6 +777,16 @@ config I2C_RCAR
>           This driver can also be built as a module.  If so, the module
>           will be called i2c-rcar.
>
> +config I2C_EM
> +       tristate "EMMA Mobile series I2C adapter"
> +       depends on I2C && HAVE_CLK
> +       help
> +         If you say yes to this option, support will be included for the
> +         I2C interface on the Renesas Electronics EM/EV of processors.
> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called i2c-em
> +
>  comment "External I2C/SMBus adapter drivers"
>
>  config I2C_DIOLAN_U2C
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index d00997f..f7022ab 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_I2C_OCTEON)      += i2c-octeon.o
>  obj-$(CONFIG_I2C_XILINX)       += i2c-xiic.o
>  obj-$(CONFIG_I2C_XLR)          += i2c-xlr.o
>  obj-$(CONFIG_I2C_RCAR)         += i2c-rcar.o
> +obj-$(CONFIG_I2C_EM)            += i2c-em.o
>
>  # External I2C/SMBus adapter drivers
>  obj-$(CONFIG_I2C_DIOLAN_U2C)   += i2c-diolan-u2c.o
> diff --git a/drivers/i2c/busses/i2c-em.c b/drivers/i2c/busses/i2c-em.c
> new file mode 100644
> index 0000000..b54a983
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-em.c

> +static int em_i2c_probe(struct platform_device *pdev)
> +{
> +       struct em_i2c_device *i2c_dev;
> +       struct resource *r;
> +       int ret;
> +
> +       i2c_dev = devm_kzalloc(&pdev->dev, sizeof(struct em_i2c_device),
> +                               GFP_KERNEL);
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       i2c_dev->membase = devm_ioremap_resource(&pdev->dev, r);
> +       if (IS_ERR(i2c_dev->membase))
> +               return PTR_ERR(i2c_dev->membase);
> +
> +       strlcpy(i2c_dev->adap.name, "em_i2c", sizeof(i2c_dev->adap.name));
> +
> +       i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (!IS_ERR(i2c_dev->clk))
> +               clk_prepare(i2c_dev->clk);
> +
> +       i2c_dev->sclk = devm_clk_get(&pdev->dev, "sclk");
> +       if (!IS_ERR(i2c_dev->sclk))
> +               clk_prepare(i2c_dev->sclk);
> +
> +       i2c_dev->irq = platform_get_irq(pdev, 0);
> +       i2c_dev->adap.timeout = msecs_to_jiffies(100);
> +       i2c_dev->adap.dev.parent = &pdev->dev;
> +       i2c_dev->adap.algo = &em_i2c_algo;
> +       i2c_dev->adap.owner = THIS_MODULE;
> +       i2c_dev->adap.nr = pdev->id;
> +       i2c_dev->adap.dev.of_node = pdev->dev.of_node;
> +
> +       init_waitqueue_head(&i2c_dev->i2c_wait);
> +
> +       spin_lock_init(&i2c_dev->irq_lock);
> +
> +       i2c_dev->flags = I2C_BIT_DFC0;
> +#ifdef CONFIG_I2C_EMXX_SMC
> +       i2c_dev->flags |= I2C_BIT_SMC0;
> +#endif

I think CONFIG_I2C_EMXX_SMC probably want to be reworked somehow. I
assume it's an old left over in this particular case. But if you need
to have some special configuration method then please consider some
other way than CONFIG_ variables that are not very compatible with
future multi-platform kernel images.

Cheers,

/ magnus
