From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 05 Apr 2015 09:00:56 +0000
Subject: Re: [PATCH/RFC 5/6] staging: board: Add support for devices with complex dependencies
Message-Id: <CAMuHMdWsc=2QvKfpYmN=M6As_KWENW2nhSqa8ajkZrQFe+dCPw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
 <34835209.cQQp4PEGGk@avalon>
In-Reply-To: <34835209.cQQp4PEGGk@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Laurent,

On Sat, Apr 4, 2015 at 2:46 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +     for (i = 0; i < dev->ngpios; i++)
>> +             gpio_request_one(dev->gpios[i].gpio, dev->gpios[i].flags,
>> +                              pdev->name);
>
> Aren't GPIO numbers dynamic too in DT-based systems ? Beside, shouldn't it be

Apparently not, as the old legacy number still works, and it doesn't work
without.

> the responsibility of the drievr to request the GPIOs it needs ?

As far as I understand it, on Armadillo this is used more for platform
configuration than for device configuration, as it affects multiple devices
(the comment says DBGMD/LCDC0/FSIA MUX).

I guess I could use a "gpio-hog" subnode in DT instead, but then we're already
implementing the conversion to DT ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
