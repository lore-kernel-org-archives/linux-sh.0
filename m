From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jun 2015 10:25:31 +0000
Subject: Re: [PATCH] [RFC] gpio: Retry deferred GPIO hogging on pin range change
Message-Id: <CAMuHMdWYpxiWvmo+ER5L6853COsx9OQzkz=uwmhDjtM6_F8+Aw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434458208-30600-1-git-send-email-geert+renesas@glider.be>
	<CAAVeFuLLs+zkzoeh1BinFyEZ96mV27nV8MNAbgmsd18jLbdfew@mail.gmail.com>
	<CAMuHMdV0N0csFR7kT9GsaDddybg5pG2EdXqgJ2zjQ+AJW779bQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV0N0csFR7kT9GsaDddybg5pG2EdXqgJ2zjQ+AJW779bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Benoit Parrot <bparrot@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

On Sun, Jun 21, 2015 at 10:52 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Jun 21, 2015 at 9:21 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
>> On Tue, Jun 16, 2015 at 9:36 PM, Geert Uytterhoeven
>> <geert+renesas@glider.be> wrote:
>>> If a GPIO driver uses gpiochip_add_pin_range() (which is usually the
>>> case for GPIO/PFC combos), the GPIO hogging mechanism configured from DT
>>> doesn't work:
>>>
>>>     requesting hog GPIO lcd0 (chip r8a7740_pfc, offset 176) failed
>>>
>>> The actual error code is -517 = -EPROBE_DEFER.
>>>
>>> The problem is that PFC+GPIO registration is handled in multiple steps:
>>>   1. pinctrl_register(),
>>>   2. gpiochip_add(),
>>>   3. gpiochip_add_pin_range().
>>>
>>> Configuration of the hogs is handled in gpiochip_add():
>>>
>>>     gpiochip_add
>>>         of_gpiochip_add
>>>             of_gpiochip_scan_hogs
>>>                 gpiod_hog
>>>                     gpiochip_request_own_desc
>>>                         __gpiod_request
>>>                             chip->request
>>>                                 pinctrl_request_gpio
>>>                                     pinctrl_get_device_gpio_range
>>>
>>> However, at this point the GPIO controller hasn't been added to
>>> pinctrldev_list yet, so the range can't be found, and the operation fails
>>> with -EPROBE_DEFER.
>>>
>>>   - Exchanging the order of the calls to gpiochip_add() and
>>>     gpiochip_add_pin_range() is not an option, as the latter depends on
>>>     initialization done by the former.
>>>   - Just moving the call of of_gpiochip_scan_hogs() from gpiochip_add()
>>>     to gpiochip_add_pin_range() is also not an option, as the latter is
>>>     optional, and thus not used by all drivers.
>>>
>>> Hence if of_gpiochip_scan_hogs() fails with -EPROBE_DEFER, call it
>>> again every time the pin range is changed, until it succeeded.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> Questions:
>>>   - Is there a better solution to handle this?
>>
>> I do not understand the issue well enough to propose a better
>> solution, but I really hope there is one. This turns GPIO into a
>> slightly bigger yarn mess that what it already is and does not help
>> understanding how probing is performed. Yielding in the middle of
>> adding hogs and re-trying later sounds like a recipe for issues like
>> hogs being added several times.
>>
>> So I am not really fond of this, to be honest. The GPIO hogging
>> mechanism is still quite new, so there is certainly a way to fix such
>> issues by addressing the fundamental cause instead of duct taping it?
>
> Sure, I'm all for fixing this properly, hence the "RFC" and my questions.
>
> I also don't understand how this interacts with non-PFC drivers calling
> gpiochip_add_pin_range():
>   - gpio-em, but only for legacy platform devices, which are no longer used
>     (I will remove the legacy support),
>   - gpio-rcar, but only for legacy platform devices, which is used on R-Car
>     Gen1 only until -legacy is removed,
>   - gpiolib-of, which handles this for the bulk of modern GPIO drivers using
>     the "gpio-ranges" and "gpio-ranges-group-names" properties in DT.
>
> When I noticed the failure on r8a7740/armadillo (sh-pfc provides both pfc
> and gpio), I tried GPIO hogging on r8a7791/koelsch (sh-pfc provides pfc
> only, gpio-rcar provides gpio, "gpio-ranges" is in DT), and there it worked
> fine without my patch.

"gpio-ranges" and gpiochip_add_pin_range() turned out to be the solution
to the problem: on DT platforms, parsing "gpio-ranges" is doing from
of_gpiochip_add(), which is called from gpiochip_add().
Hence the ranges are set up from DT just before the hogs are handled:

void of_gpiochip_add(struct gpio_chip *chip)
{
        ...
        of_gpiochip_add_pin_range(chip);
        ...
        of_gpiochip_scan_hogs(chip);
}

Sticking a "gpio-ranges" in arch/arm/boot/dts/r8a7740.dtsi:

@@ -288,12 +288,13 @@
        pfc: pfc@e6050000 {
                compatible = "renesas,pfc-r8a7740";
                reg = <0xe6050000 0x8000>,
                      <0xe605800c 0x20>;
                gpio-controller;
                #gpio-cells = <2>;
+               gpio-ranges = <&pfc 0 0 212>;
                interrupts-extended                         <&irqpin0 0 0>, <&irqpin0 1 0>, <&irqpin0 2
0>, <&irqpin0 3 0>,
                        <&irqpin0 4 0>, <&irqpin0 5 0>, <&irqpin0 6
0>, <&irqpin0 7 0>,
                        <&irqpin1 0 0>, <&irqpin1 1 0>, <&irqpin1 2
0>, <&irqpin1 3 0>,
                        <&irqpin1 4 0>, <&irqpin1 5 0>, <&irqpin1 6
0>, <&irqpin1 7 0>,
                        <&irqpin2 0 0>, <&irqpin2 1 0>, <&irqpin2 2
0>, <&irqpin2 3 0>,

solved the problem for me.

Note that "&pfc" is a reference to the gpio device node itself, as it provides
both GPIO and PFC functionalities.

After that, the calls to gpiochip_add_pin_range() in
drivers/pinctrl/sh-pfc/gpio.c
can be removed, at least for the ARM multi-platform case where GPIO is
instantiated from DT (_and_ "gpio-ranges" is present --- I don't think we have
to care about DT backwards compatibility for sh73a0/r8a73a4/r8a7740).

Does this makes sense?

I couldn't find any other in-tree DTS that has a gpio-controller with a
gpio-ranges pointing to itself. All other GPIO+PFC combos lack such properties,
and thus probably won't work with DT gpio-hogs.

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
