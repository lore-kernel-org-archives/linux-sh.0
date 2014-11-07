From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Fri, 07 Nov 2014 11:31:53 +0000
Subject: Re: [PATCH] gpio: rcar: Add r8a7793 and r8a7794 support
Message-Id: <CAH1o70J2CSf-x_dqc425cFrENwKHx1HcXszKy0kXwQ5CPx59iw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415352219-26644-1-git-send-email-ykaneko0929@gmail.com>
	<CAMuHMdXdCgeQSc5efnZXOeawcy-iopNHMvVZiPwjoYVz_Zvfsw@mail.gmail.com>
	<CAH1o70KJJe58hYKfegVpMPgwZ6jaWSO83QuTyHvhhuKKoAdXYQ@mail.gmail.com>
	<CAMuHMdU-Caoosqew--wg1fWGuwByGoE5OKqvYQNDUg0fY5Om_A@mail.gmail.com>
	<CAH1o70LtOZj-voVmcwSZaar5f8W4oL4ikPXJ171G4p3PT6WT9Q@mail.gmail.com>
	<CAMuHMdWjZaJabho+wj_GFYbb+UwF8fnt6e3tg7Kf0t5uTY485g@mail.gmail.com>
In-Reply-To: <CAMuHMdWjZaJabho+wj_GFYbb+UwF8fnt6e3tg7Kf0t5uTY485g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert-san,

2014-11-07 20:24 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Kaneko-san,
>
> On Fri, Nov 7, 2014 at 12:17 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> 2014-11-07 19:51 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>>> On Fri, Nov 7, 2014 at 11:49 AM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>>>>> Given we now have 4 identical copies of the above struct gpio_rcar_info,
>>>>> I think it starts to make sense to create
>>>>>
>>>>>         static struct gpio_rcar_info gpio_rcar_info_gen2 = {
>>>>>                 .has_both_edge_trigger = true;
>>>>>         };
>>>>>
>>>>> and just reference that one from gpio_rcar_of_table[].
>>>>> While at it, you can do the same for R-Car Gen 1 for consistency.
>>>>
>>>> Is the following what you intended?
>>>
>>> Yes, thank you very much.
>>>
>>> Please add a similar struct for R-Car Gen1.
>>
>> I'm not sure about R-Car Gen1.
>> Is it the following things?
>>
>> +static const struct gpio_rcar_info gpio_rcar_info_gen1 = {
>> +       .has_both_edge_trigger = false,
>> +};
>> [...]
>>         }, {
>>                 .compatible = "renesas,gpio-rcar",
>> -               .data = (void *)&(const struct gpio_rcar_info) {
>> -                       .has_both_edge_trigger = false,
>> -               },
>> +               .data = &gpio_rcar_info_gen1,
>>         }, {
>
> Yes, that looks fine to me.

Many thanks!
I'll update this patch.

Thanks,
Kaneko


>
> Thanks.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
