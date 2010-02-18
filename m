From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 18 Feb 2010 08:58:19 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: Add tiny document
Message-Id: <uiq9ux68s.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   42 +++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 70277e0..bcd4456 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -35,6 +35,48 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+/*
+ * Address	Interface		BusWidth	note
+ * ------------------------------------------------------------------
+ * 0x0000_0000	NOR Flash ROM (MCP)	16bit		SW7 : bit1 = ON
+ * 0x0800_0000	user area		-
+ * 0x1000_0000	NOR Flash ROM (MCP)	16bit		SW7 : bit1 = OFF
+ * 0x1400_0000	Ether (LAN9220)		16bit
+ * 0x1600_0000	user area		-		cannot use with NAND
+ * 0x1800_0000	user area		-
+ * 0x1A00_0000	-
+ * 0x4000_0000	LPDDR2-SDRAM (POP)	32bit
+ */
+
+/*
+ * NOR Flash ROM
+ *
+ *  SW1  |     SW2    | SW7  | NOR Flash ROM
+ *  bit1 | bit1  bit2 | bit1 | Memory allocation
+ * ------+------------+------+------------------
+ *  OFF  | ON     OFF | ON   |    Area 0
+ *  OFF  | ON     OFF | OFF  |    Area 4
+ */
+
+/*
+ * NAND Flash ROM
+ *
+ *  SW1  |     SW2    | SW7  | NAND Flash ROM
+ *  bit1 | bit1  bit2 | bit2 | Memory allocation
+ * ------+------------+------+------------------
+ *  OFF  | ON     OFF | ON   |    FCE 0
+ *  OFF  | ON     OFF | OFF  |    FCE 1
+ */
+
+/*
+ * SMSC 9220
+ *
+ *  SW1		SMSC 9220
+ * -----------------------
+ *  ON		access disable
+ *  OFF		access enable
+ */
+
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
-- 
1.6.3.3

