From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:07 +0000
Subject: [PATCH 00/22] SH MTU2 DT support
Message-Id: <1393955249-18736-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set implements DT support for the MTU2 driver.

The first 17 patches clean up the driver to get rid of its platform data.
Patches 18/22 and 19/22 then remove platform data from arch/ code. Patches
20/22 and 21/22 drop support for platform data completely from the driver,
and patch 22/22 finally add DT support.

The patches are compile-tested only as I lack test hardware. Wolfram, would
you be able to test this series with your CCF support patch set for RZ/A1H ?

Laurent Pinchart (22):
  clocksource: sh_mtu2: Use request_irq() instead of setup_irq()
  clocksource: sh_mtu2: Turn sh_mtu2_priv fields into local variables
  clocksource: sh_mtu2: Split channel fields from sh_mtu2_priv
  clocksource: sh_mtu2: Rename struct sh_mtu2_priv to sh_mtu2_device
  clocksource: sh_mtu2: Split channel setup to separate function
  clocksource: sh_mtu2: Constify name argument to sh_mtu2_register()
  clocksource: sh_mtu2: Add memory base to sh_mtu2_channel structure
  clocksource: sh_mtu2: Add index to struct sh_mtu2_channel
  clocksource: sh_mtu2: Replace kmalloc + memset with kzalloc
  clocksource: sh_mtu2: Allocate channels dynamically
  clocksource: sh_mtu2: Replace hardcoded register values with macros
  clocksource: sh_mtu2: Set cpumask to cpu_possible_mask
  clocksource: sh_mtu2: Hardcode MTU2 clock event rating to 200
  clocksource: sh_mtu2: Add support for multiple channels per device
  clocksource: sh_mtu2: Rename clock to "fck" in the non-legacy case
  clocksource: sh_mtu2: Remove FSF mail address from GPL notice
  clocksource: sh_mtu2: Sort headers alphabetically
  sh: Switch to new style MTU2 device
  ARM: shmobile: r7s72100: Switch to new style MTU2 device
  clocksource: sh_mtu2: Drop support for legacy platform data
  clocksource: sh_mtu2: Replace global spinlock with a per-device
    spinlock
  clocksource: sh_mtu2: Add DT support

 .../devicetree/bindings/timer/renesas,mtu2.txt     |  37 ++
 arch/arm/mach-shmobile/clock-r7s72100.c            |   2 +-
 arch/arm/mach-shmobile/setup-r7s72100.c            |  26 +-
 arch/sh/kernel/cpu/clock-cpg.c                     |   2 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c             |   2 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c             |   2 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c                |  98 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c             |  98 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c             |  67 +--
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c             |  98 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c             |  71 +---
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c             |  67 +--
 drivers/clocksource/sh_mtu2.c                      | 452 +++++++++++++--------
 13 files changed, 412 insertions(+), 610 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,mtu2.txt

-- 
Regards,

Laurent Pinchart

