From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 03 Jan 2014 15:48:48 +0000
Subject: [PATCH 4/4] ARM: shmobile: lager: Make spi_flash_data const
Message-Id: <1388764128-27686-4-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/mach-shmobile/board-lager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f20c10a18543..40ace7195f84 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -263,7 +263,7 @@ static struct mtd_partition spi_flash_part[] = {
 	},
 };
 
-static struct flash_platform_data spi_flash_data = {
+static const struct flash_platform_data spi_flash_data = {
 	.name           = "m25p80",
 	.parts          = spi_flash_part,
 	.nr_parts       = ARRAY_SIZE(spi_flash_part),
-- 
1.7.9.5

