From: Bastian Hecht <hechtb@gmail.com>
Date: Fri, 08 Mar 2013 11:29:40 +0000
Subject: [PATCH v2 6/7] ARM: shmobile: r8a7740: Add DT name to clock list for CMT10
Message-Id: <1362742181-19111-7-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362742181-19111-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1362742181-19111-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This adds temporarily the alternative device name to the clock list
that is used when booting via Device Tree setup.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2: new

I can rebase this on topic/intc-of if wanted.

 arch/arm/mach-shmobile/clock-r8a7740.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 1feb9a2..b0b5d3c 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -616,6 +616,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6cc0000.sci",		&mstp_clks[MSTP230]),
 
 	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
+	CLKDEV_DEV_ID("e6138010.timer",		&mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
 	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
-- 
1.7.9.5

