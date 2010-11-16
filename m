From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Nov 2010 04:12:43 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: add fsib 44100Hz rate fixup
Message-Id: <w3pd3q5rjno.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch disable fdiv_clk when 44.1kHz

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index d326054..355e3cf 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -585,6 +585,7 @@ static int fsi_set_rate(int is_porta, int rate)
 	switch (rate) {
 	case 44100:
 		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 11283000));
+		clk_set_rate(fdiv_clk, clk_round_rate(fsib_clk, 11283000));
 		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
 		break;
 	case 48000:
-- 
1.7.0.4

