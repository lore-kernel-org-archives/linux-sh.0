From: Bastian Hecht <hechtb@gmail.com>
Date: Thu, 11 Apr 2013 11:24:02 +0000
Subject: [PATCH v4 6/7] ARM: shmobile: r8a7740: Add DT name to clock list for CMT10
Message-Id: <1365679443-25456-6-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This adds temporarily the alternative device name to the clock list
that is used when booting via Device Tree setup.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v4: same. only patch 2 and 3 changed

 arch/arm/mach-shmobile/clock-r8a7740.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 5bd8da0..8fc396a 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -582,6 +582,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6cc0000.sci",		&mstp_clks[MSTP230]),
 
 	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
+	CLKDEV_DEV_ID("e6138010.timer",		&mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
 	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
-- 
1.7.9.5

