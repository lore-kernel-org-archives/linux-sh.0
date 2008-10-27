From: "Nobuhiro Iwamatsu" <iwamatsu@nigauri.org>
Date: Mon, 27 Oct 2008 02:32:27 +0000
Subject: [PATCH] gdrom: Fix compile error
Message-Id: <29ab51dc0810261932n7580e87aua85103f8b1dcc5a5@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linux-sh <linux-sh@vger.kernel.org>

Return value and argument of block_device_operations.release of gdrom
was changed.
This patch fix this problem.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsunigauri.org>
---
 drivers/cdrom/gdrom.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 9aaa86b..2eecb77 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -495,9 +495,10 @@ static int gdrom_bdops_open(struct block_device
*bdev, fmode_t mode)
 	return cdrom_open(gd.cd_info, bdev, mode);
 }

-static int gdrom_bdops_release(struct block_device *bdev, fmode_t mode)
+static int gdrom_bdops_release(struct gendisk *disk, fmode_t mode)
 {
-	return cdrom_release(gd.cd_info, mode);
+	cdrom_release(gd.cd_info, mode);
+	return 0;
 }

 static int gdrom_bdops_mediachanged(struct gendisk *disk)
-- 
1.5.6.5
