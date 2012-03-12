From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 12 Mar 2012 06:34:33 +0000
Subject: [GIT PULL] rmobile fixes for 3.3-rc8
Message-Id: <20120312063433.GA5573@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit 55062d061790b43aee01ab3f9ac57b8596254f19:

  x86: fix typo in recent find_vma_prev purge (2012-03-06 18:48:13 -0800)

are available in the git repository at:
  git://github.com/pmundt/linux-sh.git rmobile-for-linus

Kuninori Morimoto (1):
      ARM: mach-shmobile: ap4evb: fixup fsi2_ak4643_info typo

Laurent Pinchart (2):
      ARM: mach-shmobile: Fix ag5evm compilation by including linux/videodev2.h
      ARM: mach-shmobile: mackerel: Reserve DMA memory for the frame buffer

Phil Edworthy (1):
      ARM: mach-shmobile: Fix bonito compile breakage

 arch/arm/mach-shmobile/board-ag5evm.c   |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c   |    2 +-
 arch/arm/mach-shmobile/board-bonito.c   |    3 ++-
 arch/arm/mach-shmobile/board-mackerel.c |    4 ++++
 4 files changed, 8 insertions(+), 2 deletions(-)
