From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 30 Jun 2011 07:10:59 +0000
Subject: [GIT PULL] rmobile fixes for 3.0-rc6
Message-Id: <20110630071058.GE22023@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-3.x.git rmobile-fixes-for-linus

Which contains:

Guennadi Liakhovetski (1):
      ARM: mach-shmobile: make a struct in board-ap4evb.c static

Kuninori Morimoto (1):
      ARM: mach-shmobile: mackerel: change usbhs devices order

Simon Horman (1):
      ARM: mach-shmobile: ag5evm: consistently name sdhi info structures

 arch/arm/mach-shmobile/board-ag5evm.c   |    4 ++--
 arch/arm/mach-shmobile/board-ap4evb.c   |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
