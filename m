From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 15 Jun 2010 07:09:01 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.35-rc2
Message-Id: <201006150909.01958.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100604050007.GD31868@linux-sh.org>
In-Reply-To: <20100604050007.GD31868@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

I Paul,
I just finished my last application ald linux 2.6 jernel based.
I'd like to upgrade my structure to the latest kernel for giving my apport =

into the development of sh7203 target.
Can I have an account at=20

master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Thanks a lot


In data venerd=EC 04 giugno 2010 07:00:07, Paul Mundt ha scritto:
: > Please pull from:
>=20
> 	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git
>=20
> Which contains:
>=20
> Aurelien Jarno (1):
>       clocksource: sh_tmu: compute mult and shift before registration
>=20
> Guennadi Liakhovetski (1):
>       fbdev: fix erroneous index in drivers/video/sh_mobile_lcdcfb.c
>=20
> Huang Weiyi (1):
>       sh: remove duplicated #include
>=20
> Kuninori Morimoto (4):
>       sh: make sure static declaration on mach-ap325rxa
>       sh: make sure static declaration on mach-ecovec24
>       sh: make sure static declaration on mach-migor
>       sh: make sure static declaration on ms7724se
>=20
> Magnus Damm (4):
>       sh: allow romImage data between head.S and the zero page
>       sh: prepare MMCIF driver header file
>       sh: add boot code to MMCIF driver header
>       sh: add romImage MMCIF boot for sh7724 and Ecovec V2
>=20
> Paul Mundt (11):
>       serial: sh-sci: fix up serial DMA build.
>       sh: handle early calls to return_address() when using dwarf unwinde=
r.
>       input: serio: disable i8042 for non-cayman sh platforms.
>       usb: gadget: m66592-udc pio to mmio accessor conversion.
>       usb: gadget: r8a66597-udc pio to mmio accessor conversion.
>       usb: r8a66597-hcd pio to mmio accessor conversion.
>       sh: support for platforms without PIO.
>       sh: mach-sdk7786: conditionally disable PIO support.
>       sh: PIO disabling for x3proto and urquell.
>       clocksource: sh_cmt: compute mult and shift before registration
>       sh: Make intc messages consistent via pr_fmt.
>=20
> Yusuke Goda (1):
>       sh: Add support MMCIF for ecovec
>=20
>  arch/sh/Kconfig                               |   16 +++-
>  arch/sh/boards/Kconfig                        |    3 +
>  arch/sh/boards/mach-ap325rxa/setup.c          |    2 +-
>  arch/sh/boards/mach-ecovec24/setup.c          |  101 ++++++++++++++--
>  arch/sh/boards/mach-migor/setup.c             |    2 +-
>  arch/sh/boards/mach-se/7724/setup.c           |    8 +-
>  arch/sh/boot/romimage/Makefile                |   13 ++-
>  arch/sh/boot/romimage/head.S                  |   42 ++++++-
>  arch/sh/boot/romimage/mmcif-sh7724.c          |   72 +++++++++++
>  arch/sh/boot/romimage/vmlinux.scr             |    2 +
>  arch/sh/include/asm/io.h                      |    8 ++
>  arch/sh/include/asm/machvec.h                 |    9 +-
>  arch/sh/include/cpu-sh4/cpu/sh7724.h          |    1 +
>  arch/sh/include/mach-common/mach/romimage.h   |   10 ++
>  arch/sh/include/mach-ecovec24/mach/romimage.h |   27 ++++
>  arch/sh/include/mach-kfr2r09/mach/romimage.h  |   10 ++
>  arch/sh/kernel/Makefile                       |    3 +-
>  arch/sh/kernel/dwarf.c                        |   19 +++-
>  arch/sh/kernel/io.c                           |   22 ----
>  arch/sh/kernel/io_generic.c                   |   20 +++
>  arch/sh/kernel/io_trapped.c                   |    4 +
>  arch/sh/kernel/machvec.c                      |   17 ++-
>  arch/sh/kernel/return_address.c               |    2 +
>  drivers/clocksource/sh_cmt.c                  |   22 ++--
>  drivers/clocksource/sh_tmu.c                  |   20 ++--
>  drivers/input/serio/Kconfig                   |    3 +-
>  drivers/mmc/host/sh_mmcif.c                   |  125 ++++++++------------
>  drivers/sh/intc.c                             |   12 +-
>  drivers/usb/gadget/m66592-udc.h               |   22 ++--
>  drivers/usb/gadget/r8a66597-udc.c             |    4 +-
>  drivers/usb/gadget/r8a66597-udc.h             |   24 ++--
>  drivers/usb/host/r8a66597-hcd.c               |    4 +-
>  drivers/usb/host/r8a66597.h                   |   26 ++--
>  drivers/video/sh_mobile_lcdcfb.c              |    6 +-
>  include/linux/mmc/sh_mmcif.h                  |  161
>  +++++++++++++++++++++++++ include/linux/serial_sci.h                    =
|=20
>    4 +-
>  36 files changed, 642 insertions(+), 204 deletions(-)
>  create mode 100644 arch/sh/boot/romimage/mmcif-sh7724.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
www.aurion-tech.com
