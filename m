From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 14 Sep 2013 15:29:16 +0000
Subject: [PATCH 03/03] ARM: shmobile: Include CA7 cores in APMU table
Message-Id: <20130914152916.12327.39849.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add information to the shared APMU code regarding
the APMU instance used to control the CA7 cores.

This can be used on r8a7790 and r8a73a4, but should
most likely be converted to DT in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/platsmp-apmu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 0004/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2013-09-14 23:54:05.000000000 +0900
@@ -86,6 +86,10 @@ static struct {
 	{
 		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
 		.cpus = { 0, 1, 2, 3 },
+	},
+	{
+		.iomem = DEFINE_RES_MEM(0xe6151000, 0x88),
+		.cpus = { 0x100, 0x101, 0x102, 0x103 },
 	}
 };
 
