From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Apr 2012 06:52:48 +0000
Subject: [PATCH 1/6] ARM: mach-shmobile: pfc-sh73a0: fixup MSEL2CR MSEL18 for I2C-3
Message-Id: <87aa239byb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

MSEL2CR MSEL18 should be 1 if I2C-3

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/pfc-sh73a0.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh73a0.c b/arch/arm/mach-shmobile/pfc-sh73a0.c
index e05634c..4a547b8 100644
--- a/arch/arm/mach-shmobile/pfc-sh73a0.c
+++ b/arch/arm/mach-shmobile/pfc-sh73a0.c
@@ -829,14 +829,14 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(PORT27_I2C_SCL2_MARK, PORT27_FN2, MSEL2CR_MSEL17_0,
 		MSEL2CR_MSEL16_1), \
 	PINMUX_DATA(PORT27_I2C_SCL3_MARK, PORT27_FN3, MSEL2CR_MSEL19_0,
-		MSEL2CR_MSEL18_0), \
+		MSEL2CR_MSEL18_1), \
 	PINMUX_DATA(MFG0_OUT1_MARK, PORT27_FN4), \
 	PINMUX_DATA(PORT27_IROUT_MARK, PORT27_FN7),
 	PINMUX_DATA(XDVFS2_MARK, PORT28_FN1), \
 	PINMUX_DATA(PORT28_I2C_SDA2_MARK, PORT28_FN2, MSEL2CR_MSEL17_0,
 		MSEL2CR_MSEL16_1), \
 	PINMUX_DATA(PORT28_I2C_SDA3_MARK, PORT28_FN3, MSEL2CR_MSEL19_0,
-		MSEL2CR_MSEL18_0), \
+		MSEL2CR_MSEL18_1), \
 	PINMUX_DATA(PORT28_TPU1TO1_MARK, PORT28_FN7),
 	PINMUX_DATA(SIM_RST_MARK, PORT29_FN1), \
 	PINMUX_DATA(PORT29_TPU1TO1_MARK, PORT29_FN4),
-- 
1.7.5.4

