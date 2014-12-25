From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 25 Dec 2014 09:29:22 +0000
Subject: [PATCH repost 13/16] sh/uaccess: fix sparse errors
Message-Id: <1419499661-8566-14-git-send-email-mst@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1419499661-8566-1-git-send-email-mst@redhat.com>
In-Reply-To: <1419499661-8566-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-sh@vger.kernel.org

virtio wants to read bitwise types from userspace using get_user.  At the
moment this triggers sparse errors, since the value is passed through an
integer.

Fix that up using __force.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sh/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index 9486376..484b1f9 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -60,7 +60,7 @@ struct __large_struct { unsigned long buf[100]; };
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
-	(x) = (__typeof__(*(ptr)))__gu_val;			\
+	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
 })
 
@@ -71,7 +71,7 @@ struct __large_struct { unsigned long buf[100]; };
 	const __typeof__(*(ptr)) *__gu_addr = (ptr);			\
 	if (likely(access_ok(VERIFY_READ, __gu_addr, (size))))		\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
-	(x) = (__typeof__(*(ptr)))__gu_val;				\
+	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 	__gu_err;							\
 })
 
-- 
MST

