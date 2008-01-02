From: "Andrew Murray" <amurray@mpc-data.co.uk>
Date: Wed, 02 Jan 2008 11:43:39 +0000
Subject: [PATCH] sh: sh7712 defconfig
Message-Id: <0C997DD87CC88A4F86C897F52650B52B820E95@MOLSON.mpc-data.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

From: Andrew Murray <amurray@mpc-data.co.uk>

This patch provides a correct value for CONFIG_SH_PCLK_FREQ for the SH7712 solution engine when used with the board's default factory settings. This results in the board running at its maximum CPU clock rate (200 MHz).

The board I have is a Japanese Solution Engine with a 66 MHz (extal) crystal. Is this the only variant of the Solution Engine for the SH7712?

Signed-off-by: Andrew Murray <amurray@mpc-data.co.uk>
---
diff -uprN -X sh-2.6/Documentation/dontdiff sh-2.6/arch/sh/configs/se7712_defconfig sh-2.6-devel/arch/sh/configs/se7712_defconfig
--- sh-2.6/arch/sh/configs/se7712_defconfig     2008-01-02 10:13:44.000000000 +0000
+++ sh-2.6-devel/arch/sh/configs/se7712_defconfig       2008-01-02 10:28:32.000000000 +0000
@@ -237,7 +237,7 @@ CONFIG_CPU_HAS_SR_RB=y
 CONFIG_SH_TMU=y
 CONFIG_SH_TIMER_IRQ
 # CONFIG_NO_IDLE_HZ is not set
-CONFIG_SH_PCLK_FREQ3333333
+CONFIG_SH_PCLK_FREQf666666

 #
 # CPU Frequency scaling

Internal Virus Database is out-of-date.
Checked by AVG Free Edition. 
Version: 7.5.516 / Virus Database: 269.17.8 - Release Date: 24/12/2007 00:00
 
