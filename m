From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Nov 2010 07:34:34 +0000
Subject: [PATCH v2] ARM: mach-shmobile: ap4evb: add fsib 44100Hz rate fixup
Message-Id: <w3p62vxraba.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pd3wmt65q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pd3wmt65q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

FSIDIVB is used when HDMI sound is 48kHz,
but it should be disabled when 44.1kHz.
And fsidiv_set_rate do that if selected rate is same as parent rate.
This patch select parent rate to fdiv_clk when 44.1kHz

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2
- add new_rate
- add long explan

 arch/arm/mach-shmobile/board-ap4evb.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index b63010f..09a9481 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -569,6 +569,7 @@ static int fsi_set_rate(int is_porta, int rate)
 {
 	struct clk *fsib_clk;
 	struct clk *fdiv_clk = &sh7372_fsidivb_clk;
+	unsigned long new_rate;
 	int ret;
 
 	/* set_rate is not needed if port A */
@@ -581,7 +582,9 @@ static int fsi_set_rate(int is_porta, int rate)
 
 	switch (rate) {
 	case 44100:
-		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 11283000));
+		new_rate = clk_round_rate(fsib_clk, 11283000);
+		clk_set_rate(fsib_clk, new_rate);
+		clk_set_rate(fdiv_clk, new_rate);
 		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
 		break;
 	case 48000:
-- 
1.7.0.4

