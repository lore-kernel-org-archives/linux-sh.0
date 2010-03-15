From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Mar 2010 03:35:37 +0000
Subject: [GIT PULL] genesis updates for 2.6.34-rc2
Message-Id: <20100315033537.GA14529@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100226071805.GA4435@linux-sh.org>
In-Reply-To: <20100226071805.GA4435@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/genesis-2.6.git

Which contains:

Magnus Damm (8):
      ARM: mach-shmobile: G3EVM KEYSC platform data
      ARM: mach-shmobile: G3EVM FLCTL platform data
      mtd: enable sh_flctl on SH-Mobile ARM
      ARM: mach-shmobile: sh7367 SDHI vector merge
      ARM: mach-shmobile: sh7377 SDHI vector merge
      ARM: mach-shmobile: sh7372 SDHI vector merge
      ARM: mach-shmobile: ap4evb SDHI0 platform data V2
      video: enable sh_mobile_lcdc on SH-Mobile ARM

NISHIMOTO Hiroki (1):
      ARM: mach-shmobile: G4EVM KEYSC platform data

 arch/arm/mach-shmobile/board-ap4evb.c |   32 +++++++++
 arch/arm/mach-shmobile/board-g3evm.c  |  122 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-g4evm.c  |   57 +++++++++++++++
 arch/arm/mach-shmobile/clock-sh7367.c |    7 ++
 arch/arm/mach-shmobile/intc-sh7367.c  |   46 ++++++------
 arch/arm/mach-shmobile/intc-sh7372.c  |   46 ++++++------
 arch/arm/mach-shmobile/intc-sh7377.c  |   36 +++++-----
 drivers/mtd/nand/Kconfig              |    2 +-
 drivers/video/Kconfig                 |    2 +-
 9 files changed, 285 insertions(+), 65 deletions(-)
