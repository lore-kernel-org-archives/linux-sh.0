From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Mar 2016 09:48:29 +0000
Subject: Re: [RFC v4 1/4] watchdog: renesas-rwdt: add driver
Message-Id: <CAMuHMdUX4BzfPf32nZ5wZVkEBtUtoBtGhG6P=Rdm0ry+V8Ag9Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Thu, Mar 17, 2016 at 10:34 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > +Required properties:
>> > +- compatible : Should be "renesas,rwdt-r8a7795";
>>
>> "renesas,r8a7795-rwdt", and "renesas,rcar-gen3-rwdt" as a fallback, to match
>> current best practices?
>
> What about "renesas,rcar-gen2-rwdt" since Gen2 and Gen3 are identical?

Are they? :-) Yes, at the datasheet level, FWIW...

> But why "r8a7795-rwdt" with SoC first? Looking at the r8a7795.dtsi,
> "<ip_core>-<soc_type>" seems to be more dominant than
> "<soc_type>-<ip_core>"? Ah, confusing again...

For new bindings, we follow practices set by the rest of the DT crowd.

>> > +       if (!rate)
>> > +               return -ENOENT;
>>
>> -EINVAL?
>
> Too generic.

A clock with a zero rate doesn't mean that the clock doesn't exist.

>> > +       for (i = ARRAY_SIZE(clk_divs); i >= 0; i--) {
>> > +               clks_per_sec = rate / clk_divs[i];
>> > +               if (clks_per_sec) {
>> > +                       priv->clks_per_sec = clks_per_sec;
>> > +                       priv->cks = i;
>> > +                       break;
>> > +               }
>> > +       }
>> > +
>> > +       if (!clks_per_sec) {
>> > +               dev_err(&pdev->dev, "Can't find suitable clock divider!\n");
>> > +               return -ERANGE;
>>
>> -EINVAL?
>
> Ditto.

#define ERANGE          34      /* Math result not representable */

Hmmm...

>> > + * to work there, one also needs a RESET (RST) driver which does not exist yet
>> > + * due to HW issues. This needs to be solved before adding compatibles here.
>>
>> Isn't there some setup needed on R-Car Gen3, too?
>
> Good news. The latest bootloader update made the Watchdog work on Gen3!
> It sets WDTRSTCR (chapter 11.2.4) to 0x8002. Clearing bit 0 unmasks the
> reset signal from the RWDT watchdog. Setting bit 15 enforces
> initializing BARs on WDT reset. This is the bit we are missing badly on
> Gen2 for proper WDT reset AFAICT.
>
> This register can only be changed in secure mode. I recall that those
> register are left to the firmware to be setup, or am I wrong? At least
> this explains why the BSP team could test my driver without changing
> kernel code. They had early access to the new bootloader ;)

Cool...

> However, while testing I found a glitch to be fixed. I hope to have this
> tackled today, so I can resend the series.

Thanks, looking forward to it!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
