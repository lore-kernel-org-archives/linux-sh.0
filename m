From: Bastian Hecht <hechtb@gmail.com>
Date: Thu, 04 Apr 2013 15:58:40 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: Armadillo800EVA: Reference DT implementation
Message-Id: <CABYn4sx6ynqNUx0MVx9CwxW2s_pcT7-AQTdMOC6byz7crparaA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txxzk77s.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txxzk77s.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

thanks for the review.

2013/4/4 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Bastian,
>
> Thanks for the patch.
>
[snip]
>> +     /* Touchscreen */
>> +     gpio_request(GPIO_FN_IRQ10,     NULL); /* TP_INT */
>
> Please, no function GPIO in reference DT implementations.

As far as I understood the pinctrl framework, we choose preconfigured
settings (in pfc-r8a7740.c) for each device we want to run. We
identify these devices by their names, like sh-sci.1. How does that
work with devices connected to busses like the I2C controller for
which we can't know which GPIOs we need in advance as it is board
dependent?

>> +     gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
>
> The GPIO should be passed to the touchscreen driver through DT. As we have no
> GPIO DT bindings for the r8a7740 yet, an option would be to pass it through
> platform data (using OF_DEV_AUXDATA).

I don't see who would use that data. Does your suggestion include to
expand the st1232 driver?
So far I see only that the IRQ number is used to set up the IRQ
handler. I don't see the connection where the muxing would be done.

Thanks,

 Bastian


>> +#ifdef CONFIG_CACHE_L2X0
>> +     /* Early BRESP enable, Shared attribute override enable, 32K*8way */
>> +     l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
>> +#endif
>> +
>> +     r8a7740_add_standard_devices_dt();
>> +     r8a7740_pm_init();
>> +}
>> +
>> +#define RESCNT2 IOMEM(0xe6188020)
>> +static void eva_restart(char mode, const char *cmd)
>> +{
>> +     /* Do soft power on reset */
>> +     writel((1 << 31), RESCNT2);
>> +}
>> +
>> +static const char *eva_boards_compat_dt[] __initdata = {
>> +     "renesas,armadillo800eva-reference",
>> +     NULL,
>> +};
>> +
>> +DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
>> +     .map_io         = r8a7740_map_io,
>> +     .init_early     = r8a7740_init_delay,
>> +     .init_irq       = r8a7740_init_irq_of,
>> +     .init_machine   = eva_init,
>> +     .init_time      = shmobile_timer_init,
>> +     .init_late      = shmobile_init_late,
>> +     .dt_compat      = eva_boards_compat_dt,
>> +     .restart        = eva_restart,
>> +MACHINE_END
> --
> Regards,
>
> Laurent Pinchart
>
