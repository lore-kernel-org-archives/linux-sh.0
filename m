From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Mar 2011 08:09:20 +0000
Subject: [GIT PULL] rmobile updates for 2.6.38-rc8
Message-Id: <20110304080920.GA13319@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110107033931.GK22477@linux-sh.org>
In-Reply-To: <20110107033931.GK22477@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git rmobile-fixes-for-linus

Which contains:

Kuninori Morimoto (4):
      ARM: mach-shmobile: ap4evb: fixup memory initialize for zboot
      ARM: mach-shmobile: mackerel: fixup memory initialize for zboot
      ARM: mach-shmobile: ap4evb: modify LCDC clock divider value
      ARM: mach-shmobile: mackerel: modify LCDC clock divider value

Magnus Damm (2):
      ARM: mach-shmobile: AG5EVM MIPI-DSI LCD reset delay fix
      ARM: mach-shmobile: Add sh73a0 MIPI-CSI and CEU clocks

 arch/arm/mach-shmobile/board-ag5evm.c              |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c              |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c            |    2 +-
 arch/arm/mach-shmobile/clock-sh73a0.c              |   17 ++++++++++++++---
 .../arm/mach-shmobile/include/mach/head-ap4evb.txt |   10 +++++-----
 .../mach-shmobile/include/mach/head-mackerel.txt   |   10 +++++-----
 6 files changed, 27 insertions(+), 15 deletions(-)
