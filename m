From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 22 Jun 2011 07:43:09 +0000
Subject: [PATCH] fbdev: sh_mobile_meram: Correct pointer check for YCbCr chroma plane
Message-Id: <1308728589-9547-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The check was intended to test if we have a valid pointer to write into,
but it mistakenly checks the pointer contents instead.

Since a valid pointer is mandatory for the chroma data if a YCbCr format
is used, the pointer check has been removed.
---
 drivers/video/sh_mobile_meram.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 7afd77a..6700140 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -246,7 +246,7 @@ static inline void meram_get_next_icb_addr(struct sh_mobile_meram_info *pdata,
 		icb_offset = 0xc0000000 | (cfg->current_reg << 23);
 
 	*icb_addr_y = icb_offset | (cfg->icb[0].marker_icb << 24);
-	if ((*icb_addr_c) && is_nvcolor(cfg->pixelformat))
+	if (is_nvcolor(cfg->pixelformat))
 		*icb_addr_c = icb_offset | (cfg->icb[1].marker_icb << 24);
 }
 
-- 
1.7.1

