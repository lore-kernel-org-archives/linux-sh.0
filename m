From: Brian Norris <computersforpeace@gmail.com>
Date: Mon, 18 May 2015 23:24:30 +0000
Subject: [PATCH] sh: mach-rsk: remove unnecessary MTD partition probe specification
Message-Id: <1431991470-22388-1-git-send-email-computersforpeace@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org

The cmdlinepart parser is already supported in the default probe.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 arch/sh/boards/mach-rsk/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/boards/mach-rsk/setup.c b/arch/sh/boards/mach-rsk/setup.c
index 2685ea03b064..6bc134bd7ec2 100644
--- a/arch/sh/boards/mach-rsk/setup.c
+++ b/arch/sh/boards/mach-rsk/setup.c
@@ -27,8 +27,6 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
 };
 
-static const char *part_probes[] = { "cmdlinepart", NULL };
-
 static struct mtd_partition rsk_partitions[] = {
 	{
 		.name		= "Bootloader",
@@ -50,7 +48,6 @@ static struct physmap_flash_data flash_data = {
 	.parts			= rsk_partitions,
 	.nr_parts		= ARRAY_SIZE(rsk_partitions),
 	.width			= 2,
-	.part_probe_types	= part_probes,
 };
 
 static struct resource flash_resource = {
-- 
1.9.1

