From: Nicolas Kaiser <nikai@nikai.net>
Date: Mon, 04 Oct 2010 10:39:29 +0000
Subject: [PATCH 3/5] arm/shmobile: remove duplicated include
Message-Id: <20101004123929.094848ba@absol.kitzblitz>
List-Id: <linux-sh.vger.kernel.org>
References: <20101004122436.7092868f@absol.kitzblitz>
In-Reply-To: <20101004122436.7092868f@absol.kitzblitz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Remove duplicated include.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 95935c8..3ebb5be 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -30,7 +30,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
-- 
1.7.2.2
