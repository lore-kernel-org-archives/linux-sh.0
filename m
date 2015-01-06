From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 06 Jan 2015 15:45:42 +0000
Subject: [PATCH v2 39/40] sh: macro whitespace fixes
Message-Id: <1420558883-10131-40-git-send-email-mst@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-sh@vger.kernel.org

While working on arch/sh/include/asm/uaccess.h, I noticed
that one macro within this header is made harder to read because it
violates a coding style rule: space is missing after comma.

Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sh/include/asm/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/segment.h b/arch/sh/include/asm/segment.h
index 5e2725f..ff795d3 100644
--- a/arch/sh/include/asm/segment.h
+++ b/arch/sh/include/asm/segment.h
@@ -23,7 +23,7 @@ typedef struct {
 #define USER_DS		KERNEL_DS
 #endif
 
-#define segment_eq(a,b)	((a).seg = (b).seg)
+#define segment_eq(a, b) ((a).seg = (b).seg)
 
 #define get_ds()	(KERNEL_DS)
 
-- 
MST

