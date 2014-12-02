From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Dec 2014 08:37:14 +0000
Subject: [PATCH 0/5] ARM: shmobile: ape6evm: multiplatform support
Message-Id: <1417509439-31739-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This series implements multiplatform support for the APE6EVM board, and
eliminates both legacy platforms.  Suggestions on how to sequence these
changes in a more attractive fashion are welcome.

This depends on the patch sets "r8a73a4 common clock framework
implementation" and "ARM: shmobile: ape6evm-reference: add missing devices".

CU
Uli


Ulrich Hecht (5):
  ARM: shmobile: r8a73a4: Multiplatform support
  ARM: shmobile: r8a73a4: Add r8a73a4-ape6evm-reference.dtb to
    ARCH_SHMOBILE_MULTI
  ARM: shmobile: ape6evm reference: Remove C board code
  ARM: shmobile: r8a73a4: Remove r8a73a4-ape6evm-reference.dtb from
    ARCH_SHMOBILE_LEGACY
  ARM: shmobile: r8a73a4: ape6evm: replace legacy with multiplatform

 arch/arm/boot/dts/Makefile                       |   3 +-
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  | 240 -------------------
 arch/arm/boot/dts/r8a73a4-ape6evm.dts            | 169 +++++++++++++-
 arch/arm/mach-shmobile/Kconfig                   |  17 +-
 arch/arm/mach-shmobile/Makefile                  |   1 -
 arch/arm/mach-shmobile/Makefile.boot             |   1 -
 arch/arm/mach-shmobile/board-ape6evm-reference.c |  61 -----
 arch/arm/mach-shmobile/board-ape6evm.c           | 286 -----------------------
 8 files changed, 170 insertions(+), 608 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c

-- 
1.8.4.5

