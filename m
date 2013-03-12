From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Mar 2013 08:25:40 +0000
Subject: [PATCH 0/3 v2] ARM: shmobile: add R8A7778 Bock-W board support
Message-Id: <87hakhrpmn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus, and all

These are v2 patch set of R8A7778 R-Car M1 SoC/board support
This SoC/board support have limited DT only.
In the future improved PINCTRL and clock framework support will be added
v2 patch set include DT as default

Bock-W board needs ${LINUX}/arch/arm/tools/mach-types

bockw                  MACH_BOCKW              BOCKW                   3386

ARM Web site already has Bock-W, mach-types will be updated
if upstream kernel has it.

These patches are based on simon/next branch

Kuninori Morimoto (3):
      [PATCH 1/3] ARM: shmobile: add R8A7778 setup support
      [PATCH 2/3] ARM: shmobile: r8a7778 SCIF support
      [PATCH 3/3] ARM: shmobile: add R-Car M1A Bock-W platform support

 arch/arm/boot/dts/Makefile                    |    1 +
 arch/arm/boot/dts/r8a7778-bockw.dts           |   32 +++
 arch/arm/boot/dts/r8a7778.dtsi                |   35 +++
 arch/arm/configs/bockw_defconfig              |   95 ++++++++
 arch/arm/mach-shmobile/Kconfig                |   11 +
 arch/arm/mach-shmobile/Makefile               |    2 +
 arch/arm/mach-shmobile/board-bockw.c          |   37 +++
 arch/arm/mach-shmobile/clock-r8a7778.c        |  104 +++++++++
 arch/arm/mach-shmobile/include/mach/r8a7778.h |   29 +++
 arch/arm/mach-shmobile/setup-r8a7778.c        |  311 +++++++++++++++++++++++++
 10 files changed, 657 insertions(+)

This is my command for DT uImage

PC> make bockw_defconfig
PC> make menuconfig
   [Boot options]
     - [Flattened Device Tree support]
     - [Use appended device tree blob to zImage (EXPERIMENTAL)]
   [System Type]
     - [BOCK-W platform - Reference Device Tree Implementation]

PC> make zImage
PC> make dtbs
PC> duImage r8a7778-bockw-reference
PC> cp arch/sh/boot/duImage ${PATH}

---- duImage --------------------------------
#! /bin/sh

# create zImage + dtb = dzImage
cat arch/arm/boot/zImage arch/arm/boot/dts/${1}.dtb > arch/arm/boot/dzImage

# create duImage
DUIMAGE=`cut -f 3- -d ' ' < arch/arm/boot/.uImage.cmd | sed -e "s/zImage/dzImage/" | sed -e "s/uImage/duImage/"`
${DUIMAGE}%
----------------------------------------------


Best regards
---
Kuninori Morimoto
