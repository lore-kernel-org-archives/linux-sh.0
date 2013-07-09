From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Jul 2013 10:39:44 +0000
Subject: [PATCH 00/04] ARM: shmobile: Random header and makefile cleanups
Message-Id: <20130709103944.1891.67462.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ARM: shmobile: Random header and makefile cleanups

[PATCH 01/04] ARM: shmobile: No need to use INTC header on r8a7779
[PATCH 02/04] ARM: shmobile: Use pm-rmobile on sh7372 and r8a7740 only
[PATCH 03/04] ARM: shmobile: No need to use INTC demux on r8a7740
[PATCH 04/04] ARM: shmobile: Remove unused mach/dma.h

Remove pointless header files and unnecessary use of header files,
and only link in bits that are actually needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Built on top of renesas-next-20130704v2

 arch/arm/mach-shmobile/Makefile           |    8 +++-----
 arch/arm/mach-shmobile/include/mach/dma.h |    1 -
 arch/arm/mach-shmobile/intc-r8a7779.c     |    1 -
 arch/arm/mach-shmobile/setup-r8a7779.c    |    1 -
 4 files changed, 3 insertions(+), 8 deletions(-)
