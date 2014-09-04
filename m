From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Sep 2014 07:19:59 +0000
Subject: Re: [PATCH v2 03/10] ARM: shmobile: sh73a0: common clock framework board support
Message-Id: <CAMuHMdXCVU7rLDxkBNgM3As9FD8EHcu8KPh9DU5Q3scdLq8x_Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 4, 2014 at 9:10 AM, Simon Horman <horms@verge.net.au> wrote:
>> +#ifdef CONFIG_COMMON_CLK
>> +static const struct clk_name clk_names[] __initconst = {
>> +     { "cmt1", NULL, "sh_cmt.10" },
>> +     { "scifa0", NULL, "sh-sci.0" },
>> +     { "scifa1", NULL, "sh-sci.1" },
>> +     { "scifa2", NULL, "sh-sci.2" },
>> +     { "scifa3", NULL, "sh-sci.3" },
>> +     { "scifa4", NULL, "sh-sci.4" },
>> +     { "scifa5", NULL, "sh-sci.5" },
>> +     { "scifa6", NULL, "sh-sci.6" },
>> +     { "scifa7", NULL, "sh-sci.7" },
>> +     { "scifb", NULL, "sh-sci.8" },
>> +     { "sdhi0", NULL, "ee100000.sd" },
>> +     { "sdhi1", NULL, "ee120000.sd" },
>> +     { "sdhi2", NULL, "ee140000.sd" },
>> +     { "mmcif0", NULL, "e6bd0000.mmc" },
>> +     { "iic0", NULL, "e6820000.i2c" },
>> +     { "iic3", NULL, "e6826000.i2c" },
>> +};
>> +#endif
>> +
>>  static void __init kzm_init(void)
>>  {
>> +#ifdef CONFIG_COMMON_CLK
>> +     shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
>> +#endif
>>       sh73a0_add_standard_devices_dt();
>>
>
> I believe that the above work-around no longer needed since
> 3c90c55dcde745bed81f6447f24ba96bda43d984 ("drivers: sh: compile
> drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI").

That commit applies to the "shmobile_clk_workaround(..., true)" calls.

The "shmobile_clk_workaround(..., false)" calls are still needed for devices
not instantiated from DT.

From the device names' formats, that applies to the cmt1 and scif* devices?
However, I thought scif* was instantiated from DT?
And cmt1 is being moved?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
