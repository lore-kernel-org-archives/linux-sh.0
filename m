From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Jan 2011 09:52:01 +0000
Subject: [GIT PULL] rmobile updates for 2.6.38-rc3
Message-Id: <20110125095201.GA18669@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110107033931.GK22477@linux-sh.org>
In-Reply-To: <20110107033931.GK22477@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This is a fairly straightforward set of fixes. The bulk of the additions
here are simply plugging in some platform data for AG5.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git rmobile-fixes-for-linus

Which contains:

Kuninori Morimoto (2):
      ARM: mach-shmobile: clock-sh7372: fixup pllc2 set_rate
      ARM: mach-shmobile: ag5evm: Add IrDA support

Magnus Damm (6):
      ARM: mach-shmobile: sh7372 INTCS MFIS2 interrupt update
      ARM: mach-shmobile: remove sh7367 on-chip set_irq_type()
      ARM: mach-shmobile: sh73a0 CPGA fix for FRQCRA M3
      ARM: mach-shmobile: sh73a0 CPGA fix for IrDA MSTP
      ARM: mach-shmobile: sh73a0 CPGA fix for PLL CFG bit
      ARM: mach-shmobile: AG5EVM LCDC / MIPI-DSI platform data

Paul Mundt (1):
      mmc: sh_mmcif: Convert to __raw_xxx() I/O accessors.

Simon Horman (1):
      ARM: mach-shmobile: mackerel: clarify shdi/mmcif switch settings

Takashi YOSHII (2):
      ARM: mach-shmobile: fix cpu_base of gic_init() on sh73a0
      ARM: mach-shmobile: ag5evm requires GPIOLIB

 arch/arm/mach-shmobile/Kconfig          |    2 +
 arch/arm/mach-shmobile/board-ag5evm.c   |  180 ++++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/board-g3evm.c    |    1 -
 arch/arm/mach-shmobile/board-mackerel.c |    5 +-
 arch/arm/mach-shmobile/clock-sh7372.c   |    4 +-
 arch/arm/mach-shmobile/clock-sh73a0.c   |   29 +++++-
 arch/arm/mach-shmobile/intc-sh7372.c    |   11 ++-
 arch/arm/mach-shmobile/intc-sh73a0.c    |    5 +-
 include/linux/mmc/sh_mmcif.h            |    4 +-
 9 files changed, 222 insertions(+), 19 deletions(-)
