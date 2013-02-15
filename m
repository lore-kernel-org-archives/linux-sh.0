From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 15 Feb 2013 13:48:36 +0000
Subject: [PATCH 1/2] ARM: shmobile: kzm9g: correct smsc regulator registration
Message-Id: <1360936117-21765-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360936117-21765-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1360936117-21765-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Correct the name of smsc devices used for regulator registration
allowing the regulators to be found and used.

This eliminates the need for CONFIG_REGULATOR_DUMMY
when CONFIG_REGULATOR is set.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 1a26077..3cf5898 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -61,8 +61,8 @@
 
 /* Dummy supplies, where voltage doesn't matter */
 static struct regulator_consumer_supply dummy_supplies[] = {
-	REGULATOR_SUPPLY("vddvario", "smsc911x"),
-	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
 };
 
 /*
-- 
1.7.10.4

