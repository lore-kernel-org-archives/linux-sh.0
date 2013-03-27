From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Mar 2013 19:07:32 +0000
Subject: [PATCH 2/3] ARM: shmobile: r8a7779: Add GP_PIN macro
Message-Id: <1364411253-12170-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Pins are numbered in the r8a7779 documentation using a bank number and a
pin number in the bank. As the pinctrl pin number space is linear, this
is flattened by multiplying the bank number by 32 and adding the pin
number. The resulting pin number has no direct relationship with the
documentation, making it error-prone.

Add a GP_PIN macro for board code to convert from the documentation pin
number space to the linear pinctrl space.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 5896922..53db188 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -6,6 +6,8 @@
 
 struct platform_device;
 
+#define GP_PIN(bank, pin)	(((bank) * 32) + (pin))
+
 struct r8a7779_pm_ch {
 	unsigned long chan_offs;
 	unsigned int chan_bit;
-- 
1.8.1.5

