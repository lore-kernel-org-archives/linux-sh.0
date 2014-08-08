From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 08 Aug 2014 13:02:27 +0000
Subject: Re: Armadillo800EVA legacy defconfig seems busted on my board
Message-Id: <CAMuHMdX+gxOfeagywVWaayM=MwHrgJ7M=qaOYxKFZr_h_S-sng@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CANqRtoQ2Epyhtu2yKCHJMG5VXjiOo6eWNFDTNtzwPEEtNnw8qg@mail.gmail.com>
In-Reply-To: <CANqRtoQ2Epyhtu2yKCHJMG5VXjiOo6eWNFDTNtzwPEEtNnw8qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Fri, Aug 8, 2014 at 1:26 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On my r8a7740 Armadillo board I've been playing with multiplatform and
> CCF recently. While doing that I noticed that the defconfig doesn't
> seem to work.
>
> Maybe this is just my board - the boot loader seems unstable in

When starting the kernel, it indeed sometimes hangs after

        Doing init=/init

Usually this happens after cold boot, so remote controlled power switches
don't help here.

> general and my entire setup requires an additional switch for the
> Ethernet PHY to even get link up - autonegotiation seems busted with
> the boot loader...

Working fine here with both a 100 Mbps or a Gbps switch.
Gether is supposed to be gigabit, but I only get 100 Mbps.
Ethtool tells me only 10 or 100 Mbps are available?

What kind of switch do you need? What doesn't work?

> Anyway, if I try to boot the zImage generated from
> armadillo800eva_defconfig I get zero console output. I managed to
> track it down to the FB bits being busted.

Strange, armadillo800eva_defconfig is working fine for me on
renesas-devel-v3.16-20140808, after I added the appropriate nfsrootkernel command line parameter.

> If this is happening on other boards as well then perhaps we shall
> adjust the defconfig? Or even better - fix the LCDC driver or whatever
> is keeping the board from booting.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
