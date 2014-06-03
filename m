From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 03 Jun 2014 22:32:55 +0000
Subject: [PATCH 00/03] ARM: shmobile: Lager SYS-DMAC and MMCIF prototype
Message-Id: <20140603223255.2193.42153.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Lager SYS-DMAC and MMCIF prototype

[PATCH 01/03] ARM: shmobile: r8a7790: SYS-DMAC prototype
[PATCH 02/03] ARM: shmobile: r8a7790: SYS-DMAC and MMCIF prototype
[PATCH 03/03] ARM: shmobile: Lager DT reference MMCIF DMAC prototype

These patches add DMAC prototype support for the MMCIF on Lager.
Written to show how to make use of platform devices for DMA support
until the DT bindings for the DMA hardware have been stabilized.

Not for upstream merge. More-than-32-bit physical addresses are not
handled by this code - LPAE is not supported.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.15-rc7-20140530

 arch/arm/mach-shmobile/board-lager-reference.c |   20 +++++
 arch/arm/mach-shmobile/include/mach/r8a7790.h  |    4 +
 arch/arm/mach-shmobile/setup-r8a7790.c         |   91 +++++++++++++++++++++---
 3 files changed, 105 insertions(+), 10 deletions(-)
