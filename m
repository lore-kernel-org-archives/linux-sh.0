From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 26 Jan 2012 08:44:05 +0000
Subject: [PATCH 1/2] sh: modify resource for SPI0 in setup-sh7757
Message-Id: <4F211255.9090300@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The new spi-sh driver decodes the IORESOURCE_MEM_TYPE_MASK. So, the
resource needs the IORESOURCE_MEM_32BIT.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index a7b2da6..226d809 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -133,7 +133,7 @@ static struct resource spi0_resources[] = {
 	[0] = {
 		.start	= 0xfe002000,
 		.end	= 0xfe0020ff,
-		.flags	= IORESOURCE_MEM,
+		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
 	},
 	[1] = {
 		.start	= 86,
-- 
1.7.1
