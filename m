From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 23 Oct 2014 11:18:51 +0000
Subject: [PATCH v3 01/11] ARM: shmobile: r8a7740: Add missing A3SP pm domain devices
Message-Id: <1414063141-8856-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Commit 802a5639aa7041b2 ("ARM: shmobile: r8a7740: add A3SP pm domain
support") added the A3SP power domain, but forgot to hook up the IPPMU,
DMAC0/1/2, and USBDMAC hardware blocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,
v2:
  - No changes.
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8894e1b7ab0e65bb..6992d4013ef013da 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -756,6 +756,11 @@ void __init r8a7740_add_standard_devices(void)
 		{ "A3SP", &scif7_device },
 		{ "A3SP", &scif8_device },
 		{ "A3SP", &i2c1_device },
+		{ "A3SP", &ipmmu_device },
+		{ "A3SP", &dma0_device },
+		{ "A3SP", &dma1_device },
+		{ "A3SP", &dma2_device },
+		{ "A3SP", &usb_dma_device },
 	};
 
 	/* I2C work-around */
-- 
1.9.1

