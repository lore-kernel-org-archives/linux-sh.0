From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 30 May 2012 05:17:26 +0000
Subject: [PATCH][RFC] ARM: mach-shmobile: setup-sh7372: fixup chclr_offset base
Message-Id: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In shdma.c, chclr_write() will use (chan_reg + chclr_offset).
In sh7372 case, for example DMA0 case,
DMA1CHCLR_0 is located on 0xfe008220,
and chan_reg is started from 0xfe008020 (= sh7372_dmae0_resources).
Thus, chclr_offset should be (0x220 - 0x20) instead of 0x220.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Guennadi

I guess this is bugfix patch for sh7372 dmaengine chclr_offset.
But I'm not sure detail of it.
Please check this patch, and please give this patch your acked-by
if you agree this.

 arch/arm/mach-shmobile/setup-sh7372.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 35a3a9c..dfddad8 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -460,7 +460,7 @@ static const struct sh_dmae_slave_config sh7372_dmae_slaves[] = {
 	},
 };
 
-#define SH7372_CHCLR 0x220
+#define SH7372_CHCLR (0x220 - 0x20)
 
 static const struct sh_dmae_channel sh7372_dmae_channels[] = {
 	{
-- 
1.7.5.4

