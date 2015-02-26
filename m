From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Thu, 26 Feb 2015 12:42:48 +0000
Subject: Re: [PATCH/RFC] gpio: rcar: Add clock support
Message-Id: <CAH1o70KrEur6uhz-0QWa9UP_x=XeGTvpVK-gLYHew5aLme950Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424015182-20447-1-git-send-email-ykaneko0929@gmail.com>
	<CAMuHMdXCAQTqD-UHB=uLgPNMc7RbDnOkLbLcXXyiM140EzsbxA@mail.gmail.com>
In-Reply-To: <CAMuHMdXCAQTqD-UHB=uLgPNMc7RbDnOkLbLcXXyiM140EzsbxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Koji Matsuoka <koji.matsuoka.xm@renesas.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert-san,

2015-02-16 17:48 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Kaneko-san, Matsuoka-san,
>
> On Sun, Feb 15, 2015 at 4:46 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>>
>> The clock of GPIO is an initial value of enable. However,
>> since correction which sets the clock to disable was added
>> by the boot loader, the clock control was added.
>
> Thanks for your patch!
>
> Are you sure you this is really needed to enable the GPIO module clocks?
>
> While I'm still using the original U-Boot that doesn't disable (almost) all
> MSTP clocks, I do use my own early startup code that disables (almost) all
> MSTP clocks to make sure I don't miss enabling any clocks, and the GPIO
> clocks are enabled by the call to pm_runtime_get_sync() in gpio_rcar_probe(),
> added in commit df0c6c80232f ("gpio: rcar: Add minimal runtime PM support").

Thanks, with that in mind I'd like to withdraw this patch.

Kaneko

>
>> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
>> index c49522e..6d4a0bc 100644
>> --- a/drivers/gpio/gpio-rcar.c
>> +++ b/drivers/gpio/gpio-rcar.c
>
>> @@ -367,6 +369,13 @@ static int gpio_rcar_probe(struct platform_device *pdev)
>>
>>         platform_set_drvdata(pdev, p);
>>
>> +       p->clk = devm_clk_get(&pdev->dev, NULL);
>> +       if (IS_ERR(p->clk)) {
>> +               dev_err(&pdev->dev, "failed to get access to GPIO clock\n");
>> +               return PTR_ERR(p->clk);
>> +       }
>> +       clk_prepare_enable(p->clk);
>> +
>>         pm_runtime_enable(dev);
>>         pm_runtime_get_sync(dev);
>
> With some extra debugging code on Koelsch:
>
>     gpio_rcar_probe:370
> --> MSTP gpio0 ON
>     gpio_rcar_probe:373
>     gpiochip_find_base: found new base at 992
>     GPIO chip e6050000.gpio: created GPIO range 0->31 => e6060000.pfc PIN 0->31
>     gpiochip_add: registered GPIOs 992 to 1023 on device: e6050000.gpio
>     gpio_rcar e6050000.gpio: driving 32 GPIOs
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
