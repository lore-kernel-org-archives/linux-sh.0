From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Apr 2013 02:08:44 +0000
Subject: [PATCH 01/02] ARM: shmobile: Add second I/O range for r8a7790 PFC
Message-Id: <20130408020844.29957.37243.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add the GPIO I/O memory range to the r8a7790 PFC device.

This extra I/O memory range is needed when using the PFC
tables to drive both pin functions (using PINCTRL or
function GPIO for old code) and actual GPIO. The goal is
however to use a separate GPIO driver in the long run
and when that happens this extra I/O memory range can
be removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7790.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-04-02 15:34:55.000000000 +0900
@@ -31,6 +31,7 @@
 
 static const struct resource pfc_resources[] = {
 	DEFINE_RES_MEM(0xe6060000, 0x250),
+	DEFINE_RES_MEM(0xe6050000, 0x5050),
 };
 
 void __init r8a7790_pinmux_init(void)
