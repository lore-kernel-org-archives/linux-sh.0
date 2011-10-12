From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Oct 2011 07:20:52 +0000
Subject: [PATCH 00/07] ARM: mach-shmobile: External IRQ pin update
Message-Id: <20111012072052.25511.44444.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: External IRQ pin update

[PATCH 01/07] ARM: mach-shmobile: Break out INTC IRQ code
[PATCH 02/07] sh: intc: Allow triggering on both edges for ARM SoCs
[PATCH 03/07] ARM: mach-shmobile: Use common INTC IRQ code on sh7367
[PATCH 04/07] ARM: mach-shmobile: Use common INTC IRQ code on sh7377
[PATCH 05/07] ARM: mach-shmobile: Use common INTC IRQ code on sh7372
[PATCH 06/07] ARM: mach-shmobile: Use common INTC IRQ code on sh73a0
[PATCH 07/07] ARM: mach-shmobile: SDHI0 GPIO hotplug for AG5EVM

These patches update the per-SoC IRQ pin handling code. Common code
is broken out into a head file macro, the INTC IRQ triggering gets
updated to include both edge triggering. INTCA-based SoCs such as
sh7367, sh7377 and sh7372 are all converted to make use of the new
INTC macros. sh73a0 gets external IRQ support through INTCA instead
of relying on the GIC which only has limited triggering support.
As a final test case the SDHI0 hardware block on AG5EVM is converted
to use GPIO IRQ for hotplug - allowing power down of the SD controller
while waiting for card insert or eject events.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ag5evm.c      |   19 ++
 arch/arm/mach-shmobile/include/mach/intc.h |  195 ++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/intc-sh7367.c       |   40 -----
 arch/arm/mach-shmobile/intc-sh7372.c       |   72 +---------
 arch/arm/mach-shmobile/intc-sh7377.c       |   67 ---------
 arch/arm/mach-shmobile/intc-sh73a0.c       |  122 +++++++++++++++++
 arch/arm/mach-shmobile/pfc-sh73a0.c        |   68 +++++----
 drivers/sh/intc/chip.c                     |    2 
 8 files changed, 392 insertions(+), 193 deletions(-)
damm@w520 ~/patches/20111012 $ 
