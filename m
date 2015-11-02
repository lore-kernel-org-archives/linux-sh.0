From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 02 Nov 2015 17:31:37 +0000
Subject: [PATCH 1/3] clk: shmobile: r8a7795: Add PCIe clocks
Message-Id: <1446485499-26733-2-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c b/drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c
index d9edded..1e67f32 100644
--- a/drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c
+++ b/drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c
@@ -120,6 +120,8 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	{ "sys-dmac1",		218,	R8A7795_CLK_S3D1	},
 	{ "sys-dmac0",		219,	R8A7795_CLK_S3D1	},
 	{ "scif2",		310,	R8A7795_CLK_S3D4	},
+	{ "pcie0",		318,	R8A7795_CLK_S3D1	},
+	{ "pcie1",		319,	R8A7795_CLK_S3D1	},
 	{ "intc-ap",		408,	R8A7795_CLK_S3D1	},
 	{ "audmac0",		502,	R8A7795_CLK_S3D4	},
 	{ "audmac1",		501,	R8A7795_CLK_S3D4	},
-- 
1.9.1

