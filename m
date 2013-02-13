From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Feb 2013 14:16:23 +0000
Subject: [PATCH 01/02] ARM: shmobile: Temporarily use C to setup EMEV2 clocks
Message-Id: <20130213141623.12474.22607.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

To use DT on EMEV2 we for now need to make use of the C
implementation of the clock code.

Instead of blindly applying this I believe we should spend
time converting EMEV2 into a mach-shmobile common clock
reference implementation where we also use DT for clocks.

So for now I prefer not to merge this. Anyone wanting
to use and/or develop code for KZM9D can instead make
use of the code in board-kzm9d.c.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-02-13 16:41:56.000000000 +0900
@@ -420,6 +420,8 @@ static const struct of_dev_auxdata emev2
 
 void __init emev2_add_standard_devices_dt(void)
 {
+	emev2_clock_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     emev2_auxdata_lookup, NULL);
 }
