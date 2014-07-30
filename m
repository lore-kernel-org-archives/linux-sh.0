From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 23:32:06 +0000
Subject: [PATCH 00/09] ARM: shmobile: Consistent use of shmobile_init_late()
Message-Id: <20140730233206.5969.26669.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Consistent use of shmobile_init_late()

[PATCH 01/09] ARM: shmobile: Add shmobile_init_late() to sh73a0
[PATCH 02/09] ARM: shmobile: Add shmobile_init_late() to KZM9G
[PATCH 03/09] ARM: shmobile: Fix shmobile_init_late() on r8a7779
[PATCH 04/09] ARM: shmobile: Add shmobile_init_late() to Marzen
[PATCH 05/09] ARM: shmobile: Fix shmobile_init_late() on r8a7778
[PATCH 06/09] ARM: shmobile: Add shmobile_init_late() to Bock-W
[PATCH 07/09] ARM: shmobile: Add shmobile_init_late() to r8a73a4
[PATCH 08/09] ARM: shmobile: Add shmobile_init_late() to APE6EVM
[PATCH 09/09] ARM: shmobile: Add shmobile_init_late() to r7s72100

Make sure all mach-shmobile SoCs and DT Reference board support code
call shmobile_init_late() so Suspend-to-RAM and CPUIdle get setup
in a consistent way. The SoC DT case for r8a7778 and r8a7779 are
also adjusted to not add any platform devices. DT shall be used instead.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.16-rc7-20140729

 arch/arm/mach-shmobile/board-ape6evm-reference.c |    1 +
 arch/arm/mach-shmobile/board-ape6evm.c           |    1 +
 arch/arm/mach-shmobile/board-bockw-reference.c   |    1 +
 arch/arm/mach-shmobile/board-kzm9g-reference.c   |    1 +
 arch/arm/mach-shmobile/board-marzen-reference.c  |    1 +
 arch/arm/mach-shmobile/setup-r7s72100.c          |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c           |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c           |    2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c           |    2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c            |    1 +
