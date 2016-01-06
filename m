From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 06 Jan 2016 13:51:22 +0000
Subject: [RFC v2 1/4] of: make of_mutex public
Message-Id: <1452088285-6427-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

If we want to use OF_DYNAMIC features outside the of framework, we need
to access this lock.

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
index dd10626a615fb1..acac979063f067 100644
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

