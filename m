From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 30 Jan 2012 02:25:07 +0000
Subject: [PATCH] ARM: mach-shmobile: r8a7779 PFC IPSR4 fix
Message-Id: <20120130022507.14954.36776.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix the bit field width information for the IPSR4 register
in the r8a7779 pin function controller (PFC).

Without this fix the Marzen board fails to receive data
over the serial console due to misconfigured pin function
for the RX pin.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pfc-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/pfc-r8a7779.c
+++ work/arch/arm/mach-shmobile/pfc-r8a7779.c	2012-01-27 16:04:07.000000000 +0900
@@ -2120,7 +2120,7 @@ static struct pinmux_cfg_reg pinmux_conf
 	    FN_AUDATA3, 0, 0, 0 }
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR4", 0xfffc0030, 32,
-			     3, 1, 1, 1, 1, 1, 1, 3, 3, 1,
+			     3, 1, 1, 1, 1, 1, 1, 3, 3,
 			     1, 1, 1, 1, 1, 1, 3, 3, 3, 2) {
 	    /* IP4_31_29 [3] */
 	    FN_DU1_DB0, FN_VI2_DATA4_VI2_B4, FN_SCL2_B, FN_SD3_DAT0,
