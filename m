From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 02 Jul 2012 07:07:19 +0000
Subject: Re: [PATCH/RFC] ARM: mach-shmobile: enable power switching on SDHI0 and SDHI2 on kzm9g
Message-Id: <Pine.LNX.4.64.1207020853500.15365@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207010101280.24651@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207010101280.24651@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello 

On Mon, 2 Jul 2012, Tetsuyuki Kobayashi wrote:

> Hello, Guennadi
> 
> This is Tetsuyuki Kobayashi.  I have a KZM-A9-GT board (kzm9g).
> According to the board specification (written in Japanese),
> GPIOs 15 and 14 are connected to VDD of connector through PowerSW,
> resptctively.

Great, thanks for confirming!

> I tried this patch with CONFIG_REGULATOR_FIXED_VOLTAGE=y, But
> both SD card and micro SD card are not recognized (as if they are
> not inserted).
> I guess something missing. Please tell me how to test this patch
> so that I will try again.

Thanks for testing. Yes, these ARM patches are preparatory, they cannot 
work without respective counterparts in the mmc driver subsystem. At the 
very least you also need these patches:

http://www.spinics.net/lists/linux-sh/msg12007.html
http://www.spinics.net/lists/linux-sh/msg12160.html

but at least the latter of them might not apply cleanly to your tree. It 
might be easier to test if you pull in the mmc-next branch of

git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git

Thanks
Guennadi

> 
> 
> (2012/07/01 8:12), Guennadi Liakhovetski wrote:
> > On the kzm9g board power for SDHI0 and SDHI2 interfaces is controlled by
> > GPIOs. Use a switchable fixed regulator for them.
> > 
> > Signed-off-by: Guennadi Liakhovetski<g.liakhovetski@gmx.de>
> > ---
> > 
> > This is NOT for immediate application. It doesn't have to go to 3.6. If we
> > manage to confirm my guess and test this - we _could_ take it to 3.6. If
> > not - it can absolutely wait for 3.7. This patch is a _guess_ - in the
> > kzm9g init function GPIOs 15 and 14 are configured as output fixed high in
> > SDHI0 and SDHI2 sections respectively with a comment "power." So, my guess
> > was, that these GPIOs can also actually switch card power on those slots.
> > Since I have no datasheet or schematics for that board or the board
> > itself, I cannot confirm that my guess. Since Morimoto-san has worked
> > pretty intensively with this board, maybe he could verify that, but again
> > - nothing urgent.
> > 
> >   arch/arm/mach-shmobile/board-kzm9g.c |   69
> > +++++++++++++++++++++++++++++-----
> >   1 files changed, 59 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-kzm9g.c
> > b/arch/arm/mach-shmobile/board-kzm9g.c
> > index 53b7ea9..2230706 100644
> > --- a/arch/arm/mach-shmobile/board-kzm9g.c
> > +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> > @@ -373,13 +373,35 @@ static struct platform_device mmc_device = {
> >   	.resource	= sh_mmcif_resources,
> >   };
> > 
> > -/* Fixed 2.8V regulators to be used by SDHI0 and SDHI2 */
> > -static struct regulator_consumer_supply fixed2v8_power_consumers[] > > +/* Fixed 2.8V regulators to be used by SDHI0 */
> > +static struct regulator_consumer_supply sdhi0_power_consumers[] > >   {
> >   	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
> >   	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
> > -	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.2"),
> > -	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.2"),
> > +};
> > +
> > +static struct regulator_init_data sdhi0_power_init_data = {
> > +	.constraints = {
> > +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> > +	},
> > +	.num_consumer_supplies  = ARRAY_SIZE(sdhi0_power_consumers),
> > +	.consumer_supplies      = sdhi0_power_consumers,
> > +};
> > +
> > +static struct fixed_voltage_config sdhi0_power_info = {
> > +	.supply_name = "SDHI0 SD/MMC Vdd",
> > +	.microvolts = 2800000,
> > +	.gpio = GPIO_PORT15,
> > +	.enable_high = 1,
> > +	.init_data =&sdhi0_power_init_data,
> > +};
> > +
> > +static struct platform_device sdhi0_power = {
> > +	.name = "reg-fixed-voltage",
> > +	.id   = 1,
> > +	.dev  = {
> > +		.platform_data =&sdhi0_power_info,
> > +	},
> >   };
> > 
> >   /* SDHI */
> > @@ -422,6 +444,37 @@ static struct platform_device sdhi0_device = {
> >   	},
> >   };
> > 
> > +/* Fixed 2.8V regulators to be used by SDHI2 */
> > +static struct regulator_consumer_supply sdhi2_power_consumers[] > > +{
> > +	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.2"),
> > +	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.2"),
> > +};
> > +
> > +static struct regulator_init_data sdhi2_power_init_data = {
> > +	.constraints = {
> > +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> > +	},
> > +	.num_consumer_supplies  = ARRAY_SIZE(sdhi2_power_consumers),
> > +	.consumer_supplies      = sdhi2_power_consumers,
> > +};
> > +
> > +static struct fixed_voltage_config sdhi2_power_info = {
> > +	.supply_name = "SDHI2 SD/MMC Vdd",
> > +	.microvolts = 2800000,
> > +	.gpio = GPIO_PORT14,
> > +	.enable_high = 1,
> > +	.init_data =&sdhi2_power_init_data,
> > +};
> > +
> > +static struct platform_device sdhi2_power = {
> > +	.name = "reg-fixed-voltage",
> > +	.id   = 3,
> > +	.dev  = {
> > +		.platform_data =&sdhi2_power_info,
> > +	},
> > +};
> > +
> >   /* Micro SD */
> >   static struct sh_mobile_sdhi_info sdhi2_info = {
> >   	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
> > @@ -576,6 +629,8 @@ static struct i2c_board_info i2c3_devices[] = {
> >   };
> > 
> >   static struct platform_device *kzm_devices[] __initdata = {
> > +	&sdhi0_power,
> > +	&sdhi2_power,
> >   	&smsc_device,
> >   	&usb_host_device,
> >   	&usbhs_device,
> > @@ -645,8 +700,6 @@ static void __init kzm_init(void)
> >   {
> >   	regulator_register_always_on(0, "fixed-1.8V",
> > fixed1v8_power_consumers,
> >   				     ARRAY_SIZE(fixed1v8_power_consumers),
> > 1800000);
> > -	regulator_register_always_on(1, "fixed-2.8V",
> > fixed2v8_power_consumers,
> > -				     ARRAY_SIZE(fixed2v8_power_consumers),
> > 2800000);
> >   	regulator_register_fixed(2, dummy_supplies,
> > ARRAY_SIZE(dummy_supplies));
> > 
> >   	sh73a0_pinmux_init();
> > @@ -723,8 +776,6 @@ static void __init kzm_init(void)
> >   	gpio_request(GPIO_FN_SDHID0_1,		NULL);
> >   	gpio_request(GPIO_FN_SDHID0_0,		NULL);
> >   	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
> > -	gpio_request(GPIO_PORT15, NULL);
> > -	gpio_direction_output(GPIO_PORT15, 1); /* power */
> > 
> >   	/* enable Micro SD */
> >   	gpio_request(GPIO_FN_SDHID2_0,		NULL);
> > @@ -733,8 +784,6 @@ static void __init kzm_init(void)
> >   	gpio_request(GPIO_FN_SDHID2_3,		NULL);
> >   	gpio_request(GPIO_FN_SDHICMD2,		NULL);
> >   	gpio_request(GPIO_FN_SDHICLK2,		NULL);
> > -	gpio_request(GPIO_PORT14, NULL);
> > -	gpio_direction_output(GPIO_PORT14, 1); /* power */
> > 
> >   	/* I2C 3 */
> >   	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
