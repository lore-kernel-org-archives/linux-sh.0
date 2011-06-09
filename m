From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Jun 2011 06:49:13 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 divide-by-zero FSIDIV fix
Message-Id: <20110609064913.2219.62039.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7372 FSIDIV clock code to bail out
with -EINVAL in case of rate is zero.

Without this fix divide-by-zero is triggering
on sh7372 platforms during system wide resume
of Suspend-to-RAM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh7372.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0001/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2011-06-09 15:45:41.000000000 +0900
@@ -460,6 +460,9 @@ static int fsidiv_set_rate(struct clk *c
 {
 	int idx;
 
+	if (!rate)
+		return -EINVAL;
+
 	idx = (clk->parent->rate / rate) & 0xffff;
 	if (idx < 2)
 		return -EINVAL;
