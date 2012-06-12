From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2012 09:32:24 +0000
Subject: [PATCH 02/27 v2] ARM: shmobile: sh7372: bugfix: chclr_offset base
Message-Id: <874nqgyixn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

chclr_write() will use (chan_reg + chclr_offset).
In sh7372 case, DMA1CHCLR is started from 0xfe008220,
and chan_reg is started from 0xfe008020 (= sh7372_dmae0_resources).
Thus, chclr_offset should be (0x220 - 0x20) instead of 0x220.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

- no change

 arch/arm/mach-shmobile/setup-sh7372.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 6a4bd58..fafce9c 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -484,7 +484,7 @@ static const struct sh_dmae_slave_config sh7372_dmae_slaves[] = {
 	},
 };
 
-#define SH7372_CHCLR 0x220
+#define SH7372_CHCLR (0x220 - 0x20)
 
 static const struct sh_dmae_channel sh7372_dmae_channels[] = {
 	{
-- 
1.7.5.4

