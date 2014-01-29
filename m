From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 29 Jan 2014 16:16:03 +0000
Subject: Re: About gpio-regulator setting on DT
Message-Id: <52E92943.8010401@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <87r47r6v48.wl%kuninori.morimoto.gx@gmail.com> <20140129124516.GZ11841@sirena.org.uk>
In-Reply-To: <20140129124516.GZ11841@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org

On 29/01/14 12:45, Mark Brown wrote:
> On Wed, Jan 29, 2014 at 12:38:19AM -0800, Kuninori Morimoto wrote:
>
>> How to set GPIOF_OUT_INIT_HIGH via DT ?
>> Or, am I misunderstanding ?
>
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

I think you've just run in to the same problem that we've found
with the GPIO regulator code for the vmmcq on the lager where the
DT probed version is getting 1800mV for MMC whereas the platform
probed version gets 3300mV for MMC (and thus works better).

My view is that we should really add an initialisation voltage
setting to the regulators so that if there is >2 states we can
select the state it starts in.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
