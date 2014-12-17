From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Dec 2014 15:44:24 +0000
Subject: Re: [PATCH] clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <CAMuHMdUxcHNQfVFqe48qQs8LMYbX9va6JY80vEZoB=z5QKXTXw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141216094854.22639.69181.sendpatchset@w520>
In-Reply-To: <20141216094854.22639.69181.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Dec 17, 2014 at 4:34 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> > >>> - Accelerometer and RTC have no DT bindings, but they should work with
>> > >>> the I2C core OF match support.
>> > >>
>> > >> I have RTC in my DTS, and it works.
>
> I'll test compass, touch screen and accelerometer.

Thanks!

Getting the accelerometer to work probably needs some changes to the
driver. On both legacy and multi-platform, reading from /dev/input/event1
causes an interrupt storm, which can only be stopped by power-cycling
the board (the adxl345 doesn't have a reset line).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
