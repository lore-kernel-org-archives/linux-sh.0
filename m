From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 21 Jun 2015 08:52:31 +0000
Subject: Re: [PATCH] [RFC] gpio: Retry deferred GPIO hogging on pin range change
Message-Id: <CAMuHMdV0N0csFR7kT9GsaDddybg5pG2EdXqgJ2zjQ+AJW779bQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434458208-30600-1-git-send-email-geert+renesas@glider.be>
	<CAAVeFuLLs+zkzoeh1BinFyEZ96mV27nV8MNAbgmsd18jLbdfew@mail.gmail.com>
In-Reply-To: <CAAVeFuLLs+zkzoeh1BinFyEZ96mV27nV8MNAbgmsd18jLbdfew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Benoit Parrot <bparrot@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Alex,

On Sun, Jun 21, 2015 at 9:21 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Tue, Jun 16, 2015 at 9:36 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> If a GPIO driver uses gpiochip_add_pin_range() (which is usually the
>> case for GPIO/PFC combos), the GPIO hogging mechanism configured from DT
>> doesn't work:
>>
>>     requesting hog GPIO lcd0 (chip r8a7740_pfc, offset 176) failed
>>
>> The actual error code is -517 = -EPROBE_DEFER.
>>
>> The problem is that PFC+GPIO registration is handled in multiple steps:
>>   1. pinctrl_register(),
>>   2. gpiochip_add(),
>>   3. gpiochip_add_pin_range().
>>
>> Configuration of the hogs is handled in gpiochip_add():
>>
>>     gpiochip_add
>>         of_gpiochip_add
>>             of_gpiochip_scan_hogs
>>                 gpiod_hog
>>                     gpiochip_request_own_desc
>>                         __gpiod_request
>>                             chip->request
>>                                 pinctrl_request_gpio
>>                                     pinctrl_get_device_gpio_range
>>
>> However, at this point the GPIO controller hasn't been added to
>> pinctrldev_list yet, so the range can't be found, and the operation fails
>> with -EPROBE_DEFER.
>>
>>   - Exchanging the order of the calls to gpiochip_add() and
>>     gpiochip_add_pin_range() is not an option, as the latter depends on
>>     initialization done by the former.
>>   - Just moving the call of of_gpiochip_scan_hogs() from gpiochip_add()
>>     to gpiochip_add_pin_range() is also not an option, as the latter is
>>     optional, and thus not used by all drivers.
>>
>> Hence if of_gpiochip_scan_hogs() fails with -EPROBE_DEFER, call it
>> again every time the pin range is changed, until it succeeded.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Questions:
>>   - Is there a better solution to handle this?
>
> I do not understand the issue well enough to propose a better
> solution, but I really hope there is one. This turns GPIO into a
> slightly bigger yarn mess that what it already is and does not help
> understanding how probing is performed. Yielding in the middle of
> adding hogs and re-trying later sounds like a recipe for issues like
> hogs being added several times.
>
> So I am not really fond of this, to be honest. The GPIO hogging
> mechanism is still quite new, so there is certainly a way to fix such
> issues by addressing the fundamental cause instead of duct taping it?

Sure, I'm all for fixing this properly, hence the "RFC" and my questions.

I also don't understand how this interacts with non-PFC drivers calling
gpiochip_add_pin_range():
  - gpio-em, but only for legacy platform devices, which are no longer used
    (I will remove the legacy support),
  - gpio-rcar, but only for legacy platform devices, which is used on R-Car
    Gen1 only until -legacy is removed,
  - gpiolib-of, which handles this for the bulk of modern GPIO drivers using
    the "gpio-ranges" and "gpio-ranges-group-names" properties in DT.

When I noticed the failure on r8a7740/armadillo (sh-pfc provides both pfc
and gpio), I tried GPIO hogging on r8a7791/koelsch (sh-pfc provides pfc
only, gpio-rcar provides gpio, "gpio-ranges" is in DT), and there it worked
fine without my patch.

Thanks!

>>   - Should the pin ranges be configured by passing an array of data to
>>     gpiochip_add() instead of having calls to gpiochip_add_pin_range()?
>>     That would require changing all drivers.
>>
>>   - What happens if you have multiple hogs in multiple ranges?
>>     The first hog(s) may be configured multiple times.  Is that a problem?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
