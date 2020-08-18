From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Aug 2020 15:11:46 +0000
Subject: SCI on R2D+ (was: Re: [PATCH] serial: sh-sci: Make sure status register SCxSR is read in correct seq
Message-Id: <CAMuHMdXH03ec-F8JC7L7mobLddhoUEbdEuOtdDHvMDsR+WJWPg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1585333048-31828-1-git-send-email-kazuhiro.fujita.jg@renesas.com>
 <CAMuHMdW+u5r6zyxFJsVzj21BYDrKCr=Q6Ojk5VeN+mkhvXX9Jw@mail.gmail.com>
 <OSBPR01MB3590E3D12546BC6711CEB542AAC80@OSBPR01MB3590.jpnprd01.prod.outlook.com>
 <CAMuHMdXmfQ0x7mCZ-E7OPQFv2z-=mFDT20hJ2_JKax=OePB8eA@mail.gmail.com>
 <CA+V-a8vPn_z_j1Vwr_1F=dCw8H=g5UMWvWxgRqBeVR7dzHPz8Q@mail.gmail.com>
 <CAMuHMdWc9q9NjQuAuy5M=v_x=i8XxVg5JZHswjvPsgNzhHfO0w@mail.gmail.com>
 <CAMuHMdUyV58t3eihBJv2xex5gW1Oef37Jo3FHoJstU=SspmpHA@mail.gmail.com>
 <CAMuHMdU0EiQuk_bWx1yrmbBTXg8mL-PeN2=P61xQ5Ucb5QmYYg@mail.gmail.com>
 <OSBPR01MB50485F5DA2F82E455DCA6B56AA5E0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
 <b384543f-c80d-aa63-63a6-1b5dbc47885d@landley.net>
In-Reply-To: <b384543f-c80d-aa63-63a6-1b5dbc47885d@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Rob,

On Mon, Aug 17, 2020 at 5:09 AM Rob Landley <rob@landley.net> wrote:
> On 8/16/20 11:22 AM, Prabhakar Mahadev Lad wrote:
> >> FTR, I gave it a try on the SH7751R-based I-O DATA USL-5P aka Landisk:
> >> SCIF is affected, and fixed by commit 3dc4db3662366306 ("serial: sh-sci:
> >> Make sure status register SCxSR is read in correct sequence").
> >>
> > Thank you Geert.
> >
> > Cheers,
> > Prabhakar
>
> Did we ever figure out how to get linux to talk to the _first_ serial port on
> the qemu-system-sh4 r2d board? I'm still doing:
>
>   qemu-system-sh4 -M r2d -serial null -serial mon:stdio
>
> Because I can only get a working console on the _second_ serial port. (SCI vs
> SCIF I think?)

Because the SCI is wired to an SPI bus?
See:
    arch/sh/boards/mach-r2d/setup.c:spi_sh_sci_device()
    arch/sh/kernel/cpu/sh4/setup-sh7750.c:plat_early_device_setup()

To enable support for that:
    CONFIG_SPI=y
    CONFIG_SPI_SH_SCI=y
    CONFIG_RTC_CLASS=y
    CONFIG_RTC_DRV_R9701=y

However, QEMU doesn't support that mode:

    rtc-r9701 spi0.0: cannot read RTC register

Couldn't try on the remote physical R2D+. Will try when it becomes available
again...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
