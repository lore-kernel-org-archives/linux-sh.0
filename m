From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Date: Wed, 13 May 2015 08:16:53 +0000
Subject: Re: [PATCH/RFC 00/12] ARM: shmobile: dts: Add overlays for various serial ports
Message-Id: <D9B202C5-6460-4217-9F58-67078C3DB9B1@konsulko.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

Hi Geert,

In general it looks just fine to me. 

> On May 12, 2015, at 20:37 , Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> 	Hi all,
> 
> This patch series adds device tree overlays to use various serial ports
> on expansion ports on the r8a7740/armadillo and r8a7791/koelsch
> development boards.
> 
> This is an RFC for various reasons:
>  - Do we want to store device tree overlay sources in the kernel source
>    tree (see also the patch mentioned under dependencies)?
>  - The first two patches add aliases for all serial ports to the main
>    dts files, as of_alias_add() is not called yet when loading a device
>    tree overlay that adds an alias.
>  - The overlay sources use full paths to refer to the device nodes for
>    creating aliases, as path references (unlike phandle references) are
>    not yet supported by overlays.

Hmm, phandle references are completely supported. You just have to remember
to build your base tree with the -@ option to generate the fixups :)

>  - The "ctsrts" DT property is not yet documented.
>  - On Koelsch, SCIFB1 works for TX only. As SCIFB works on armadillo,
>    and the same pins work for HSCIF1 on koelsch, this may be a silly
>    pinctrl issue. Or not.
>  - As the EXIO connectors on koelsch carry i2c signals, we can go wild
>    and add i2c EEPROMs for identification, and implement a capemgr,
>    like on BeagleBone ;-)
> 

FWIW you’ve been CCed in the submission of the beaglebone cape-manager.
Most of the code is dealing with bone’s EEPROM format but I am sure you’ll
find stuff to cannibalize if you go to that path :)

Some people have expressed some amount of interest for basic compatibility
among extension boards that do simple low-speed I/O.

For example an expansion board that provides a few I2C peripherals should
in theory be portable between any number of boards that provide a physically
identical i2c bus.

Now how to go about doing this is a different matter altogether.

> How to use it, using overlay configfs:
>  - Copy your dtsos to /lib/firmware
>  - mkdir /sys/kernel/config/device-tree/overlays/scif3
>  - echo r8a7791-koelsch-exio-c-scif3.dtso >
>    /sys/kernel/config/device-tree/overlays/scif3/path
>  - Play with your new serial port
>  - rmdir /sys/kernel/config/device-tree/overlays/scif3
> 
> This depends on:
>  - https://github.com/pantoniou/linux-beagle-track-mainline.git#bbb-overlays
>    for overlay configfs.
>  - "[PATCH/RFC] kbuild: Create a rule for building device tree overlay
>    objects" (https://lkml.org/lkml/2015/5/12/343), for building the dtsos.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (12):
>  ARM: shmobile: armadillo dts: Add aliases for all serial ports
>  ARM: shmobile: koelsch dts: Add aliases for all serial ports
>  ARM: shmobile: armadillo dts: Add overlay for SCIFA0 on CON15
>  ARM: shmobile: armadillo dts: Add overlay for SCIFB on CON15
>  ARM: shmobile: koelsch dts: Add overlay for HSCIF1 on EXIO A
>  ARM: shmobile: koelsch dts: Add overlay for HSCIF2 on EXIO A
>  ARM: shmobile: koelsch dts: Add overlay for SCIFB0 on EXIO A
>  ARM: shmobile: koelsch dts: Add overlay for SCIFB1 on EXIO A
>  ARM: shmobile: koelsch dts: Add overlay for SCIF3 on EXIO C
>  ARM: shmobile: koelsch dts: Add overlay for SCIF5 on EXIO C
>  ARM: shmobile: koelsch dts: Add overlay for SCIFA5(b) on EXIO C
>  ARM: shmobile: koelsch dts: Add overlay for SCIFA5(c) on EXIO C
> 
> arch/arm/boot/dts/Makefile                         | 14 +++++
> .../dts/r8a7740-armadillo800eva-con15-scifa0.dtso  | 53 +++++++++++++++++++
> .../dts/r8a7740-armadillo800eva-con15-scifb.dtso   | 52 +++++++++++++++++++
> arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |  8 +++
> .../boot/dts/r8a7791-koelsch-exio-a-hscif1.dtso    | 49 ++++++++++++++++++
> .../boot/dts/r8a7791-koelsch-exio-a-hscif2.dtso    | 53 +++++++++++++++++++
> .../boot/dts/r8a7791-koelsch-exio-a-scifb0.dtso    | 53 +++++++++++++++++++
> .../boot/dts/r8a7791-koelsch-exio-a-scifb1.dtso    | 51 ++++++++++++++++++
> .../arm/boot/dts/r8a7791-koelsch-exio-c-scif3.dtso | 60 ++++++++++++++++++++++
> .../arm/boot/dts/r8a7791-koelsch-exio-c-scif5.dtso | 60 ++++++++++++++++++++++
> .../boot/dts/r8a7791-koelsch-exio-c-scifa5-b.dtso  | 60 ++++++++++++++++++++++
> .../boot/dts/r8a7791-koelsch-exio-c-scifa5-c.dtso  | 60 ++++++++++++++++++++++
> arch/arm/boot/dts/r8a7791-koelsch.dts              | 16 ++++++
> 13 files changed, 589 insertions(+)
> create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifa0.dtso
> create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifb.dtso
> create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif1.dtso
> create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif2.dtso
> create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb0.dtso
> create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb1.dtso
> create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-c-scif3.dtso
> create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-c-scif5.dtso
> create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-c-scifa5-b.dtso
> create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-c-scifa5-c.dtso
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 

All in all, I’m happy that someone else is using this stuff, I could use the company ;)

> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

Regards

— Pantelis

