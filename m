From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 20 Dec 2011 08:24:16 +0000
Subject: [GIT PULL] rmobile fixes for 3.2-rc7
Message-Id: <20111220082416.GA21727@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

        git://github.com/pmundt/linux-sh.git rmobile-fixes-for-linus

Which contains:

Magnus Damm (5):
      ARM: mach-shmobile: Kota2 PINT fix
      ARM: mach-shmobile: Kota2 GIC Sparse IRQ fix
      ARM: mach-shmobile: Kota2 TPU LED platform data
      ARM: mach-shmobile: AG5EVM GIC Sparse IRQ fix
      ARM: mach-shmobile: SH73A0 external Ethernet fix

 arch/arm/mach-shmobile/board-ag5evm.c |    1 +
 arch/arm/mach-shmobile/board-kota2.c  |  139 ++++++++++++++++++++++++++++----
 arch/arm/mach-shmobile/clock-sh73a0.c |   18 ++++-
 3 files changed, 139 insertions(+), 19 deletions(-)
