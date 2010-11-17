From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Nov 2010 06:44:35 +0000
Subject: [PATCH 03/05] ARM: mach-shmobile: Extend AP4EVB MIPI-DSI resources
Message-Id: <20101117064435.18139.41134.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20101117064405.18139.57035.sendpatchset@t400s>
In-Reply-To: <20101117064405.18139.57035.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, g.liakhovetski@gmx.de, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the AP4EVB board code to go from a single I/O
resource to two I/O resources for the MIPI-DSI driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ap4evb.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2010-11-16 17:19:30.000000000 +0900
@@ -501,7 +501,12 @@ static struct platform_device keysc_devi
 static struct resource mipidsi0_resources[] = {
 	[0] = {
 		.start  = 0xffc60000,
-		.end    = 0xffc68fff,
+		.end    = 0xffc63073,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 0xffc68000,
+		.end    = 0xffc680ef,
 		.flags  = IORESOURCE_MEM,
 	},
 };
