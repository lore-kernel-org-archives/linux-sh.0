From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 14 Sep 2015 12:14:22 +0000
Subject: [PATCH 00/14] SCI clocks cleanup
Message-Id: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

The SCI driver currently handles two clocks, an interface clock named sci_ick
and a functional clock named sci_fck. Studying the datasheets of the SH and
ARM SoCs that incorportate (H)SCI(F)([AB]) instances showed (un)surprisingly
that the hardware doesn't have a separate controllable interface clock.

All the platforms that declare an interface clock for the SCI set it to the
clock used as the SCI functional clock. The two clocks can thus be merged on
the driver side, which is what this patch series does. The resulting clock is
called "fck", and all SH and ARM users (both DT and non-DT) are fixed to name
their SCI clocks appropriately.

Support for the "sci_ick" name is kept in the sh-sci driver to ensure DT
backward compatibility, and support for the "peripheral_clk" clock to not
break SH platforms that don't declare device-specific SCI clocks. The later
can be removed when all SH platforms will declare their SCI clocks properly.

The patches have been developed for an ancien (v3.x for those who were born)
kernel and rebased on top of Simon's master branch. I've only compile-tested
them after the rebase. Geert, I believe this series is a good preliminary
cleanup for the SCI baud rate generator clock support. Could you give it a try
as part of your work on that ?

Laurent Pinchart (14):
  serial: sh-sci: Drop the interface clock
  sh: Rename sci_ick and sci_fck clock to fck
  sh: Remove sci_ick clock alias
  ARM: shmobile: sh73a0: Rename the serial port clock to fck
  ARM: shmobile: r7s72100: Rename the serial port clock to fck
  ARM: shmobile: r8a73a4: Rename the serial port clock to fck
  ARM: shmobile: r8a7740: Rename the serial port clock to fck
  ARM: shmobile: r8a7778: Rename the serial port clock to fck
  ARM: shmobile: r8a7779: Rename the serial port clock to fck
  ARM: shmobile: r8a7790: Rename the serial port clock to fck
  ARM: shmobile: r8a7791: Rename the serial port clock to fck
  ARM: shmobile: r8a7793: Rename the serial port clock to fck
  ARM: shmobile: r8a7794: Rename the serial port clock to fck
  serial: sh-sci: Drop the sci_fck clock fallback

 .../bindings/serial/renesas,sci-serial.txt         |  4 +-
 arch/arm/boot/dts/r7s72100.dtsi                    | 16 +++----
 arch/arm/boot/dts/r8a73a4.dtsi                     | 12 ++---
 arch/arm/boot/dts/r8a7740.dtsi                     | 18 +++----
 arch/arm/boot/dts/r8a7778.dtsi                     | 12 ++---
 arch/arm/boot/dts/r8a7779.dtsi                     | 12 ++---
 arch/arm/boot/dts/r8a7790.dtsi                     | 20 ++++----
 arch/arm/boot/dts/r8a7791.dtsi                     | 36 +++++++-------
 arch/arm/boot/dts/r8a7793.dtsi                     |  4 +-
 arch/arm/boot/dts/r8a7794.dtsi                     | 36 +++++++-------
 arch/arm/boot/dts/sh73a0.dtsi                      | 18 +++----
 arch/sh/kernel/cpu/clock-cpg.c                     |  1 -
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c             |  9 +++-
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c             | 16 +++----
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c             |  8 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c             |  6 +--
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c             | 12 ++---
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c             | 12 ++---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c             |  6 +--
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c             | 12 ++---
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c             | 12 ++---
 arch/sh/kernel/cpu/sh4a/clock-shx3.c               |  8 ++--
 drivers/tty/serial/sh-sci.c                        | 55 +++++++++++++---------
 23 files changed, 180 insertions(+), 165 deletions(-)

-- 
Regards,

Laurent Pinchart

