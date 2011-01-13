From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 09:42:45 +0000
Subject: [GIT PULL] rmobile updates for 2.6.38-rc1, part 2.
Message-Id: <20110113094245.GA20807@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110107033931.GK22477@linux-sh.org>
In-Reply-To: <20110107033931.GK22477@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git rmobile-latest

Which contains:

Arnd Hannemann (1):
      ARM: mach-shmobile: sh7372 Enable SDIO IRQs

Magnus Damm (4):
      ARM: mach-shmobile: sh7367 Enable SDIO IRQs
      ARM: mach-shmobile: sh7377 Enable SDIO IRQs
      ARM: mach-shmobile: sh7372 Enable SDIO IRQs for Mackerel
      ARM: mach-shmobile: Kill off unused !gpio_is_valid() case

Simon Horman (2):
      ARM: mach-shmobile: mackerel: SCIF port for earlyprintk when using zboot
      ARM: mach-shmobile: ap4eb: SCIF port for earlyprintk when using zboot

Tony SIM (1):
      ARM: mach-shmobile: mackerel: Add touchscreen ST1232 support

Yusuke Goda (1):
      ARM: mach-shmobile: mackerel: Add support get_cd in CN23

 arch/arm/mach-shmobile/board-ap4evb.c              |    8 ++---
 arch/arm/mach-shmobile/board-g4evm.c               |   15 ++++++++
 arch/arm/mach-shmobile/board-mackerel.c            |   35 ++++++++++++++++----
 .../arm/mach-shmobile/include/mach/head-ap4evb.txt |    7 ++++
 .../mach-shmobile/include/mach/head-mackerel.txt   |    7 ++++
 arch/arm/mach-shmobile/intc-sh7367.c               |    6 ++--
 arch/arm/mach-shmobile/intc-sh7372.c               |    4 +-
 arch/arm/mach-shmobile/intc-sh7377.c               |    4 +-
 8 files changed, 67 insertions(+), 19 deletions(-)
