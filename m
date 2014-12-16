From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 16 Dec 2014 16:25:56 +0000
Subject: [PATCH v2 0/7] ARM: shmobile: ape6evm: multiplatform support
Message-Id: <1418747163-21729-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This series implements multiplatform support for the APE6EVM board, and
eliminates both legacy platforms.

This version incorporates the "ARM: shmobile: ape6evm-reference: add missing
devices" series.  As suggested by Magnus, it synchronizes the ape6evm and
ape6evm-reference dts files first, eliminating the big renaming at the end.

It is split in such a way that the first five patches can be merged without
breaking either of the two legacy platforms.  Simon, please pick those up. 
(Or the first three, if adding a multiplatform target that does not build is
a problem.) Thank you.

CU
Uli


Changes since v1:
- merged with "ARM: shmobile: ape6evm-reference: add missing devices"
- resequenced for merging without CCF support
- removed a few leftover Kconfig and Makefile targets
- added Acked-Bys


Ulrich Hecht (7):
  ARM: shmobile: ape6evm: synchronize dts with reference platform
  ARM: shmobile: ape6evm: Add LEDs to the device tree
  ARM: shmobile: ape6evm: Add keypad to the device tree
  ARM: shmobile: r8a73a4: Multiplatform support
  ARM: shmobile: r8a73a4: Add r8a73a4-ape6evm.dtb to ARCH_SHMOBILE_MULTI
  ARM: shmobile: ape6evm-reference: Remove board C code and DT file
  ARM: shmobile: r8a73a4: ape6evm: remove legacy platform

 arch/arm/boot/dts/Makefile                       |   3 +-
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  | 156 -------------
 arch/arm/boot/dts/r8a73a4-ape6evm.dts            | 163 ++++++++++++-
 arch/arm/mach-shmobile/Kconfig                   |  30 +--
 arch/arm/mach-shmobile/Makefile                  |   2 -
 arch/arm/mach-shmobile/Makefile.boot             |   2 -
 arch/arm/mach-shmobile/board-ape6evm-reference.c |  61 -----
 arch/arm/mach-shmobile/board-ape6evm.c           | 286 -----------------------
 8 files changed, 166 insertions(+), 537 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c

-- 
1.8.4.5

