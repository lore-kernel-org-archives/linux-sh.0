From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Jan 2012 09:14:29 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: both USB DMAC instances on sh7372 are slave-only
Message-Id: <Pine.LNX.4.64.1201181013540.28782@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201181012130.28782@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201181012130.28782@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/setup-sh7372.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 45a3418..9aa22395 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -662,6 +662,7 @@ static struct sh_dmae_pdata usb_dma0_platform_data = {
 	.dmaor_is_32bit	= 1,
 	.needs_tend_set	= 1,
 	.no_dmars	= 1,
+	.slave_only	= 1,
 };
 
 static struct resource sh7372_usb_dmae0_resources[] = {
@@ -723,6 +724,7 @@ static struct sh_dmae_pdata usb_dma1_platform_data = {
 	.dmaor_is_32bit	= 1,
 	.needs_tend_set	= 1,
 	.no_dmars	= 1,
+	.slave_only	= 1,
 };
 
 static struct resource sh7372_usb_dmae1_resources[] = {
-- 
1.7.2.5

