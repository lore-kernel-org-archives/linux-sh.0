From: Dirk Behme <dirk.behme@gmail.com>
Date: Sat, 16 Jan 2016 14:23:29 +0000
Subject: [PATCH v3] clk: shmobile: r8a7795: Add SDHI clocks
Message-Id: <1452954209-5282-1-git-send-email-dirk.behme@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Add R8A7795 SDHI clocks.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---
Changes in v3: Drop the DEF_FIXED as these clocks are not fixed. I'll
have a look to

https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/commit/d=
rivers/clk/shmobile/clk-rcar-gen3.c?h=3Dv4.2/rcar-3.0.x&id=CD10385afc15cef6=
bfbaea4aa5da41193b24fe82

and see how this could be ported.

 drivers/clk/shmobile/r8a7795-cpg-mssr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile=
/r8a7795-cpg-mssr.c
index 23e98fe..c66645f 100644
--- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
+++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
@@ -120,6 +120,10 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __=
initconst =3D {
 	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S3D1),
 	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S3D1),
 	DEF_MOD("scif2",		 310,	R8A7795_CLK_S3D4),
+	DEF_MOD("sdif3",	       	 311,	R8A7795_CLK_SD3),
+	DEF_MOD("sdif2",	       	 312,	R8A7795_CLK_SD2),
+	DEF_MOD("sdif1",	      	 313,	R8A7795_CLK_SD1),
+	DEF_MOD("sdif0",	     	 314,	R8A7795_CLK_SD0),
 	DEF_MOD("pcie1",		 318,	R8A7795_CLK_S3D1),
 	DEF_MOD("pcie0",		 319,	R8A7795_CLK_S3D1),
 	DEF_MOD("intc-ap",		 408,	R8A7795_CLK_S3D1),
--=20
2.7.0

