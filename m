From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 Mar 2012 05:53:40 +0000
Subject: [PATCH 00/03] mach-shmobile device tree support for sh7372 and sh73a0
Message-Id: <20120307055340.20126.41096.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

mach-shmobile device tree support for sh7372 and sh73a0

[PATCH 01/03] ARM: mach-shmobile: introduce shmobile_setup_delay()
[PATCH 02/03] ARM: mach-shmobile: sh7372 generic board support via DT
[PATCH 03/03] ARM: mach-shmobile: sh73a0 generic board support via DT

This series adds generic DT board support for the sh7372 and sh73a0
SoCs. SCIF serial ports and timers are still setup via regular
platform devices, but other devices should in the future be added
via the device tree.

The DT kernel for sh7372 and sh73a0 is known to be booting on target
hardware via kexec and zImage with appended dtb.

At this point the hardware support is very limited. Mainly because of
lacking IRQ domain support in the INTC support code. This results in
difficulties to tie in interrupt driven board specific devices.

In the future drivers will be adjusted to support the device tree
and IRQ domain support will be added as well. All those things can
be added independently of this mach-shmobile patch set.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 This series depends on recently posted patches and series including:
 [PATCH 00/06] ARM: mach-shmobile: map_io and init_early update
 [PATCH 00/17] sh and mach-shmobile struct sh_clk_ops rename
 [PATCH] ARM: mach-shmobile: rename clk_init() to shmobile_clk_init()
 [PATCH] ARM: mach-shmobile: Move sh7372 Mackerel external clk setup
 [PATCH] ARM: mach-shmobile: Move sh7372 AP4EVB external clk setup
 [PATCH 00/08] mach-shmobile timer consolidation

 arch/arm/mach-shmobile/include/mach/common.h |    2 +
 arch/arm/mach-shmobile/setup-sh7372.c        |   39 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c        |   41 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/timer.c               |   17 ++++++++++
 4 files changed, 99 insertions(+)
