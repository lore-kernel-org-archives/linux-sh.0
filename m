From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 29 Jan 2014 08:38:19 +0000
Subject: About gpio-regulator setting on DT
Message-Id: <87r47r6v48.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org


Hi Lee, Mark, Liam

I would like to use ${LINUX}/drivers/gpio-regulator.c
via DT.
My board needs "GPIOF_OUT_INIT_HIGH" on
struct gpio :: flags

But, current of_get_gpio_regulator_config()
seems doesn't have such setting method.
This means it will be "GPIOF_OUT_INIT_LOW"

	for (i = 0; i < config->nr_gpios; i++) {
		gpio = of_get_named_gpio(np, "gpios", i);
		if (gpio < 0)
			break;
		config->gpios[i].gpio = gpio;
	}

How to set GPIOF_OUT_INIT_HIGH via DT ?
Or, am I misunderstanding ?

Best regards
---
Kuninori Morimoto
