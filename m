From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Feb 2015 08:56:41 +0000
Subject: Re: [PATCH v4] ARM: multi_v7_defconfig: Enable shmobile platforms
Message-Id: <CAMuHMdWbkUH5R+RyhhtsYxa+XWecGqOr2Q2vtuLWMUqydfzTPg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424787285-31177-1-git-send-email-geert+renesas@glider.be>
 <2701175.enxAKM7Ysp@wuerfel>
In-Reply-To: <2701175.enxAKM7Ysp@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Wed, Feb 25, 2015 at 5:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 24 February 2015 15:14:45 Geert Uytterhoeven wrote:
>> Enable support for shmobile platforms that became multi-platform aware.
>> Several non-critical drivers and subsystems are built as modules, to keep
>> kernel size reasonable.
>
> Should we take this for 4.0, or 4.1?

I'd say: the sooner it arrives in arm-soc, the better, I'm getting a bit
tired of respinning, as it causes lots of conflicts ;-)

Note that the r8a73a4/sh73a0 multiplatform work itself has been postponed
to v4.1 due to the simple-pm-bus dependency. It doesn't hurt to have it in
the defconfig now though, as "make multi_v7_defconfig" will drop unsupported
options.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
