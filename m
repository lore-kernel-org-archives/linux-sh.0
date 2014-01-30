From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Jan 2014 00:08:30 +0000
Subject: Re: About gpio-regulator setting on DT
Message-Id: <87mwieib5x.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r47r6v48.wl%kuninori.morimoto.gx@gmail.com>
	<20140129124516.GZ11841@sirena.org.uk>
In-Reply-To: <20140129124516.GZ11841@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org


Hi Mark

> The combination of the enable-active-high and enable-at-boot properties
> ought be able to cause the driver to do the right thing, the flags do
> this:
> 
> 	if (config->enabled_at_boot) {
> 		if (config->enable_high)
> 			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
> 		else
> 			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
> 	} else {
> 		if (config->enable_high)
> 			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
> 		else
> 			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
> 	}
> 
> of_get_named_gpio() just looks up the GPIO number, it doesn't request
> the GPIO.

Hmm...
I'm not sure detail,
but, I need config->gpios[ptr].flags instead of cfg.ena_gpio_flags.
Because it is used for drvdata->state.

static int gpio_regulator_probe(struct platform_device *pdev)
{
    if (np) {
        config = of_get_gpio_regulator_config(&pdev->dev, np);
        if (IS_ERR(config))
            return PTR_ERR(config);
    }
    ...

    /* build initial state from gpio init data. */
    state = 0;
    for (ptr = 0; ptr < drvdata->nr_gpios; ptr++) {
        if (config->gpios[ptr].flags & GPIOF_OUT_INIT_HIGH)     <= we need this
               state |= (1 << ptr);
    }
    drvdata->state = state;
    ...

    cfg.ena_gpio_invert = !config->enable_high;
    if (config->enabled_at_boot) {
        if (config->enable_high)
             cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
        else
             cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
    } else {
         if (config->enable_high)
             cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
         else
             cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
    }

)

Best regards
---
Kuninori Morimoto
