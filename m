From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 30 Apr 2014 00:31:40 +0000
Subject: [RFC/PATCH 0/6] Enable SCIF[01] serial ports in DT for Lager and Koelsch board
Message-Id: <1398817906-6023-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set enables the two SCIF ports on the Lager and Koelsch board in
DT, removing the manual instantiation of platform devices from platform code.

The series starts with cleanup patches that drop the unneeded interface clock
from the SCI driver (2/6) and rename the SH (1/6) and ARM (3/6 and 4/6) clocks
appropriately. If then enables serial ports in DT for Lager (5/6) and Koelsch
(6/6).

The patches have been compile-tested only (hence the RFC status) as I'm
travelling this week and don't have access to the hardware. Simon, could you
please give them a try with your r8a7779 SCI DT series ?

Laurent Pinchart (6):
  sh: Rename sci_ick clock to sci_fck
  serial: sh-sci: Drop the interface clock
  ARM: shmobile: r8a7790: Rename the serial port clock to fck
  ARM: shmobile: r8a7791: Rename the serial port clock to fck
  ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
  ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT

 .../bindings/serial/renesas,sci-serial.txt         |  4 +-
 arch/arm/boot/dts/r8a7790-lager.dts                | 21 ++++++++-
 arch/arm/boot/dts/r8a7790.dtsi                     | 20 ++++-----
 arch/arm/boot/dts/r8a7791-koelsch.dts              | 16 ++++++-
 arch/arm/boot/dts/r8a7791.dtsi                     | 36 +++++++--------
 arch/arm/mach-shmobile/board-koelsch-reference.c   | 15 -------
 arch/arm/mach-shmobile/board-lager-reference.c     | 10 -----
 arch/arm/mach-shmobile/setup-r8a7790.c             | 10 ++---
 arch/arm/mach-shmobile/setup-r8a7791.c             | 10 ++---
 arch/sh/kernel/cpu/clock-cpg.c                     |  2 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c             |  2 +-
 drivers/tty/serial/sh-sci.c                        | 52 ++++++++++++----------
 12 files changed, 106 insertions(+), 92 deletions(-)

-- 
Regards,

Laurent Pinchart

