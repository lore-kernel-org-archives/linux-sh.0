From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Apr 2016 06:59:54 +0000
Subject: Re: [PATCH 0/7] J-core J2 cpu and SoC peripherals support
Message-Id: <CAMuHMdUk3seQCyum+s1_yU-aT-nePgtxSK_YHy2qYToJMzwejw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1461880061.git.dalias@libc.org>
In-Reply-To: <cover.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich,

On Thu, Apr 28, 2016 at 11:47 PM, Rich Felker <dalias@libc.org> wrote:
> The following patchset adds support for the J-core J2, an open-source
> VHDL reimplementation of the SH-2 ISA, and drivers for the associated
> SoC devices (interrupt controller, clocksource, and SPI).

Thanks for your series!

> This version is posted for review, discussion, and testing. Before
> merge it needs at least official assignment (and documentation) of
> device tree bindings. Feedback on other improvements that could be
> made is welcome too, especially if there are places where the
> motivation is not clear and better commit messages or comments could
> clarify.

For clocksource, irqchip, and spi drivers, other mailing lists should be CCed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
