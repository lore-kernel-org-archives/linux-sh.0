From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 14 Oct 2009 10:18:21 +0000
Subject: [PATCH 00/07] sh: SuperH Mobile R-Standby Prototype
Message-Id: <20091014101821.21842.40286.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: SuperH Mobile R-Standby Prototype

[PATCH 01/07] sh: Restore all INTC registers on resume
[PATCH 02/07] sh: Use RSMEM for sh7724 sleep modes
[PATCH 03/07] sh: Add save/restore sleep code for MMU/cache
[PATCH 04/07] sh: Use immediate data for sh7724 DBSC
[PATCH 05/07] sh: Add save/restore sleep code for BSC/DBSC
[PATCH 06/07] sh: Add R-Standby support
[PATCH 07/07] sh: R-Standby CMT timer resume order workaround 

These patches implement experimental R-standby support for sh7724.

Use CONFIG_SUSPEND together with "echo mem > /sys/power/state"
to test this feature on a kfr2r09 board.

R-Standby suspend and resume on other boards with sh7724 and Mobile
DDR2-SDRAM may work as well, but the self-refresh resume code most
likely needs more attention. Boards with sh7724 and DDR2-SDRAM
(non-Mobile DDR2-SDRAM) are not supported at this point. Also,
only CS0 memory area settings are kept during R-standby, so make
sure to minimize your kernel config if you want to try this out.

On top of all that, there is an issue with the suspend code. This
code today assumes that timer drivers are sysdev devices. This is
not true on SuperH so [PATCH 07/07] simply disables clocksource
support to avoid a read-before-resume clocksource crash on resume.

The code is far from pretty and quite a bit of future glue code
is needed to mix processor-specific stuff with board-specific
configuration.

Far-from-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/suspend.h          |    2 
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    2 
 arch/sh/kernel/cpu/shmobile/pm.c       |   30 +-
 arch/sh/kernel/cpu/shmobile/sleep.S    |  460 ++++++++++++++++++++++++++++++--
 drivers/sh/intc.c                      |   25 +
 5 files changed, 481 insertions(+), 38 deletions(-)
