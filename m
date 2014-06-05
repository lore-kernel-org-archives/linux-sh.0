From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 06:47:30 +0000
Subject: [PATCH 00/03] ARM: shmobile: r7s72100 / Genmai init delay update
Message-Id: <20140605064730.14469.81219.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r7s72100 / Genmai init delay update

[PATCH 01/03] ARM: shmobile: Update r7s72100 DTS to include CPU frequency
[PATCH 02/03] ARM: shmobile: Use shmobile_init_delay() on Genmai boards
[PATCH 03/03] ARM: shmobile: Use shmobile_init_delay() on r7s72100

These patches clean up the r7s72100 SoC and Genmai board code. The CPU
Frequency is put into DTS followed by SoC and board code that gets
adjusted to read out the frequency from DTS.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written last week on top of renesas-devel-v3.15-rc7-20140528 but
 applies cleanly on top of renesas-devel-v3.15-rc8-20140605.

 arch/arm/boot/dts/r7s72100.dtsi                 |    1 +
 arch/arm/mach-shmobile/board-genmai-reference.c |    2 +-
 arch/arm/mach-shmobile/board-genmai.c           |    2 +-
 arch/arm/mach-shmobile/include/mach/r7s72100.h  |    1 -
 arch/arm/mach-shmobile/setup-r7s72100.c         |    7 +------
 5 files changed, 4 insertions(+), 9 deletions(-)
