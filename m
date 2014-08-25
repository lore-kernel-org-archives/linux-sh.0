From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Aug 2014 03:36:35 +0000
Subject: [PATCH v2 00/02] ARM: shmobile: r8a7740: Multiplatform support V2
Message-Id: <20140825033635.9284.9060.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7740: Multiplatform support V2

[PATCH v2 01/02] ARM: shmobile: Only select PM_RMOBILE for legacy case
[PATCH v2 02/02] ARM: shmobile: r8a7740: Multiplatform support

This patch series enables r8a7740 Multiplatform support. At this point
the Armadillo800EVA code is left as-is, but future updates will make
sure to consolidate the DTS and get rid of C board code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20140823-v3.17-rc1 and
 "[PATCH v2 00/05] ARM: shmobile: Kconfig and Makefile cleanups V2"

 Changes since V1:
 - Reworked dependencies

 arch/arm/mach-shmobile/Kconfig         |    7 ++++++-
 arch/arm/mach-shmobile/pm-r8a7740.c    |    5 ++---
 arch/arm/mach-shmobile/r8a7740.h       |    4 ++--
 arch/arm/mach-shmobile/setup-r8a7740.c |    8 +++++++-
 4 files changed, 17 insertions(+), 7 deletions(-)
