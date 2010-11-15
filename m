From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Nov 2010 03:11:09 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: add fsib 44100Hz rate
Message-Id: <w3peian2sdu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Tested-by: Tony SIM <chinyeow.sim.xt@renesas.com>
Tested-by: TAKEI Mitsuharu <takei.andr@gmail.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 63c2fca..5c14c73 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -582,7 +582,14 @@ static int fsi_set_rate(int is_porta, int rate)
 	if (IS_ERR(fsib_clk))
 		return -EINVAL;
 
+	while (fdiv_clk->usecount)
+		clk_disable(fdiv_clk);
+
 	switch (rate) {
+	case 44100:
+		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 11283000));
+		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
+		break;
 	case 48000:
 		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 85428000));
 		clk_set_rate(fdiv_clk, clk_round_rate(fdiv_clk, 12204000));
-- 
1.7.0.4

