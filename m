From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 31 Aug 2013 23:24:49 +0000
Subject: [PATCH 4/4] ARM: shmobile: BOCK-W reference: add Ether PFC settings
Message-Id: <201309010324.50159.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add the Ether pin group to bockw_pinctrl_map[].

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-bockw-reference.c |    3 +++
 1 file changed, 3 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-bockw-reference.c
=================================--- renesas.orig/arch/arm/mach-shmobile/board-bockw-reference.c
+++ renesas/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -29,6 +29,9 @@
  */
 
 static const struct pinctrl_map bockw_pinctrl_map[] = {
+	/* Ether */
+	PIN_MAP_MUX_GROUP_DEFAULT("fde00000.ethernet", "pfc-r8a7778",
+				  "ether_rmii", "ether"),
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_data_a", "scif0"),
