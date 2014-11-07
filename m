From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Fri, 07 Nov 2014 10:49:38 +0000
Subject: Re: [PATCH] gpio: rcar: Add r8a7793 and r8a7794 support
Message-Id: <CAH1o70KJJe58hYKfegVpMPgwZ6jaWSO83QuTyHvhhuKKoAdXYQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415352219-26644-1-git-send-email-ykaneko0929@gmail.com>
	<CAMuHMdXdCgeQSc5efnZXOeawcy-iopNHMvVZiPwjoYVz_Zvfsw@mail.gmail.com>
In-Reply-To: <CAMuHMdXdCgeQSc5efnZXOeawcy-iopNHMvVZiPwjoYVz_Zvfsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert-san,

2014-11-07 18:43 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Kaneko-san,
>
> On Fri, Nov 7, 2014 at 10:23 AM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> --- a/drivers/gpio/gpio-rcar.c
>> +++ b/drivers/gpio/gpio-rcar.c
>> @@ -1,6 +1,7 @@
>>  /*
>>   * Renesas R-Car GPIO Support
>>   *
>> + *  Copyright (C) 2014 Renesas Electronics Corporation
>>   *  Copyright (C) 2013 Magnus Damm
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>> @@ -327,6 +328,16 @@ static const struct of_device_id gpio_rcar_of_table[] = {
>>                         .has_both_edge_trigger = true,
>>                 },
>>         }, {
>> +               .compatible = "renesas,gpio-r8a7793",
>> +               .data = (void *)&(const struct gpio_rcar_info) {
>> +                       .has_both_edge_trigger = true,
>> +               },
>> +       }, {
>> +               .compatible = "renesas,gpio-r8a7794",
>> +               .data = (void *)&(const struct gpio_rcar_info) {
>> +                       .has_both_edge_trigger = true,
>> +               },
>
> Given we now have 4 identical copies of the above struct gpio_rcar_info,
> I think it starts to make sense to create
>
>         static struct gpio_rcar_info gpio_rcar_info_gen2 = {
>                 .has_both_edge_trigger = true;
>         };
>
> and just reference that one from gpio_rcar_of_table[].
> While at it, you can do the same for R-Car Gen 1 for consistency.

Is the following what you intended?

+static const struct gpio_rcar_info gpio_rcar_info_gen2 = {
+       .has_both_edge_trigger = true,
+};
+
 static const struct of_device_id gpio_rcar_of_table[] = {
        {
                .compatible = "renesas,gpio-r8a7790",
-               .data = (void *)&(const struct gpio_rcar_info) {
-                       .has_both_edge_trigger = true,
-               },
+               .data = &gpio_rcar_info_gen2,
        }, {
                .compatible = "renesas,gpio-r8a7791",
-               .data = (void *)&(const struct gpio_rcar_info) {
-                       .has_both_edge_trigger = true,
-               },
+               .data = &gpio_rcar_info_gen2,
+       }, {
+               .compatible = "renesas,gpio-r8a7793",
+               .data = &gpio_rcar_info_gen2,
+       }, {
+               .compatible = "renesas,gpio-r8a7794",
+               .data = &gpio_rcar_info_gen2,
        }, {
                .compatible = "renesas,gpio-rcar",
                .data = (void *)&(const struct gpio_rcar_info) {
                        .has_both_edge_trigger = false,
                },


Thanks,
Kaneko

>
>> +       }, {
>
> Otherwise:
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
