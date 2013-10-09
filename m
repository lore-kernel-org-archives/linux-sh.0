From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 09 Oct 2013 06:51:02 +0000
Subject: [PATCH 10/14] ARM: shmobile: Let KZM9D multiplatform boot with KZM9D DTB
Message-Id: <91f6c56152c7d8ab874dbbf8146a6727d4dff426.1381299817.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Let the multiplatform KZM9D support boot with the
legacy DTS for KZM9D as well as the KZM9D reference DTS.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9d-reference.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
index 8f8bb2f..054d8d5 100644
--- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
@@ -33,6 +33,7 @@ static void __init kzm9d_add_standard_devices(void)
 }
 
 static const char *kzm9d_boards_compat_dt[] __initdata = {
+	"renesas,kzm9d",
 	"renesas,kzm9d-reference",
 	NULL,
 };
-- 
1.8.4

