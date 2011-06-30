From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 30 Jun 2011 09:46:53 +0000
Subject: [PATCH 00/03] ARM: mach-shmobile: sh7372 A3SP prototype
Message-Id: <20110630094653.10442.68817.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: sh7372 A3SP prototype

[PATCH 01/03] serial: sh-sci: console Runtime PM prototype
[PATCH 02/03] ARM: mach-shmobile: sh7372 A3SP prototype support
[PATCH 03/03] ARM: mach-shmobile: sh7372 power domain LED hack

These patches update the partial hardware power domain support
included in the pm-domains branch of the suspend-2.6 git tree.

With these patches applied the A3SP power domain can be powered
down while inactive. If serial console is enabled then during
boot the A3SP power domain will be powered down between the
"printk" messages on the console. When user space is started
and the serial console is opened then the SCIF driver will use
pm_runtime_get_sync() to keep the A3SP power domain on.

The sh7372 A3SP hardware power domain contains devices such as:
 SCIFA, SCIFB, USBHS, IIC, MMCIF, SDHI and DMAC.

To test the devices above one by one, consider modifying your
user space to not use serial console and instead for instance
launch a telnet daemon on startup.

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to the suspend-2.6 git pm-domains branch together with
 the following patches:
 "[PATCH] clocksource: sh_cmt: wait for CMCNT on init"
 "[PATCH] ARM: mach-shmobile: Use CMT2 for timer on sh7372"

 arch/arm/mach-shmobile/board-mackerel.c      |    8 ++
 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 
 arch/arm/mach-shmobile/pm-sh7372.c           |   72 +++++++++++++++++++++++---
 arch/arm/mach-shmobile/setup-sh7372.c        |   13 ++++
 drivers/tty/serial/sh-sci.c                  |   70 +++++++++++++++++++++----
 5 files changed, 148 insertions(+), 16 deletions(-)
