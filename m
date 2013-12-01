From: takasi-y@ops.dti.ne.jp
Date: Sun, 01 Dec 2013 18:19:21 +0000
Subject: [PATCH 10/11] ARM: shmobile: koelsch: pinctrl map for MSIOF0
Message-Id: <1385921962-19843-10-git-send-email-takasi-y@ops.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
In-Reply-To: <1385921962-19843-1-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Enable msifo0_{clk,sync,rx,tx} pins for MSIOF driver.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
---
 arch/arm/mach-shmobile/board-koelsch.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 6e12914..b4add4c 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -86,6 +86,15 @@ static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* SCIF1 (CN20: DEBUG SERIAL1) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7791",
 				  "scif1_data_d", "scif1"),
+	/* MSIOF0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("spi_sh_msiof.1", "pfc-r8a7791",
+				  "msiof0_clk", "msiof0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("spi_sh_msiof.1", "pfc-r8a7791",
+				  "msiof0_sync", "msiof0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("spi_sh_msiof.1", "pfc-r8a7791",
+				  "msiof0_rx", "msiof0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("spi_sh_msiof.1", "pfc-r8a7791",
+				  "msiof0_tx", "msiof0"),
 };
 
 static void __init koelsch_add_standard_devices(void)
-- 
1.7.9.5

