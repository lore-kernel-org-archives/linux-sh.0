From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 May 2015 17:37:03 +0000
Subject: [PATCH/RFC 00/12] ARM: shmobile: dts: Add overlays for various serial ports
Message-Id: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

	Hi all,

This patch series adds device tree overlays to use various serial ports
on expansion ports on the r8a7740/armadillo and r8a7791/koelsch
development boards.

This is an RFC for various reasons:
  - Do we want to store device tree overlay sources in the kernel source
    tree (see also the patch mentioned under dependencies)?
  - The first two patches add aliases for all serial ports to the main
    dts files, as of_alias_add() is not called yet when loading a device
    tree overlay that adds an alias.
  - The overlay sources use full paths to refer to the device nodes for
    creating aliases, as path references (unlike phandle references) are
    not yet supported by overlays.
  - The "ctsrts" DT property is not yet documented.
  - On Koelsch, SCIFB1 works for TX only. As SCIFB works on armadillo,
    and the same pins work for HSCIF1 on koelsch, this may be a silly
    pinctrl issue. Or not.
  - As the EXIO connectors on koelsch carry i2c signals, we can go wild
    and add i2c EEPROMs for identification, and implement a capemgr,
    like on BeagleBone ;-)

How to use it, using overlay configfs:
  - Copy your dtsos to /lib/firmware
  - mkdir /sys/kernel/config/device-tree/overlays/scif3
  - echo r8a7791-koelsch-exio-c-scif3.dtso >
    /sys/kernel/config/device-tree/overlays/scif3/path
  - Play with your new serial port
  - rmdir /sys/kernel/config/device-tree/overlays/scif3

This depends on:
  - https://github.com/pantoniou/linux-beagle-track-mainline.git#bbb-overlays
    for overlay configfs.
  - "[PATCH/RFC] kbuild: Create a rule for building device tree overlay
    objects" (https://lkml.org/lkml/2015/5/12/343), for building the dtsos.

Thanks for your comments!

Geert Uytterhoeven (12):
  ARM: shmobile: armadillo dts: Add aliases for all serial ports
  ARM: shmobile: koelsch dts: Add aliases for all serial ports
  ARM: shmobile: armadillo dts: Add overlay for SCIFA0 on CON15
  ARM: shmobile: armadillo dts: Add overlay for SCIFB on CON15
  ARM: shmobile: koelsch dts: Add overlay for HSCIF1 on EXIO A
  ARM: shmobile: koelsch dts: Add overlay for HSCIF2 on EXIO A
  ARM: shmobile: koelsch dts: Add overlay for SCIFB0 on EXIO A
  ARM: shmobile: koelsch dts: Add overlay for SCIFB1 on EXIO A
  ARM: shmobile: koelsch dts: Add overlay for SCIF3 on EXIO C
  ARM: shmobile: koelsch dts: Add overlay for SCIF5 on EXIO C
  ARM: shmobile: koelsch dts: Add overlay for SCIFA5(b) on EXIO C
  ARM: shmobile: koelsch dts: Add overlay for SCIFA5(c) on EXIO C

 arch/arm/boot/dts/Makefile                         | 14 +++++
 .../dts/r8a7740-armadillo800eva-con15-scifa0.dtso  | 53 +++++++++++++++++++
 .../dts/r8a7740-armadillo800eva-con15-scifb.dtso   | 52 +++++++++++++++++++
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |  8 +++
 .../boot/dts/r8a7791-koelsch-exio-a-hscif1.dtso    | 49 ++++++++++++++++++
 .../boot/dts/r8a7791-koelsch-exio-a-hscif2.dtso    | 53 +++++++++++++++++++
 .../boot/dts/r8a7791-koelsch-exio-a-scifb0.dtso    | 53 +++++++++++++++++++
 .../boot/dts/r8a7791-koelsch-exio-a-scifb1.dtso    | 51 ++++++++++++++++++
 .../arm/boot/dts/r8a7791-koelsch-exio-c-scif3.dtso | 60 ++++++++++++++++++++++
 .../arm/boot/dts/r8a7791-koelsch-exio-c-scif5.dtso | 60 ++++++++++++++++++++++
 .../boot/dts/r8a7791-koelsch-exio-c-scifa5-b.dtso  | 60 ++++++++++++++++++++++
 .../boot/dts/r8a7791-koelsch-exio-c-scifa5-c.dtso  | 60 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts              | 16 ++++++
 13 files changed, 589 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifa0.dtso
 create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifb.dtso
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif1.dtso
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif2.dtso
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb0.dtso
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb1.dtso
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-c-scif3.dtso
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-c-scif5.dtso
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-c-scifa5-b.dtso
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-c-scifa5-c.dtso

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
