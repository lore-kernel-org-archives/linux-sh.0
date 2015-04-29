From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 29 Apr 2015 20:46:40 +0000
Subject: [PATCH v3 1/3] of: WIP: make of_mutex public
Message-Id: <1430340402-21586-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

If OF maintainers don't like it, we maybe can create accessor functions
we can use.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/of/of_private.h | 1 -
 include/linux/of.h      | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 8e882e706cd8c6..f92ec41efb5dfd 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -31,7 +31,6 @@ struct alias_prop {
 	char stem[0];
 };
 
-extern struct mutex of_mutex;
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
 
diff --git a/include/linux/of.h b/include/linux/of.h
index ddeaae6d2083b2..13fd9b91d2ad6e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -32,6 +32,8 @@
 typedef u32 phandle;
 typedef u32 ihandle;
 
+extern struct mutex of_mutex;
+
 struct property {
 	char	*name;
 	int	length;
-- 
2.1.4

