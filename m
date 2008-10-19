From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sun, 19 Oct 2008 19:29:29 +0000
Subject: [PATCH] sh64: rescue get_user/put_user
Message-Id: <20081019192929.GA22064@x200.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	(void *)&__pu_val, __pu_addr

is what original include/asm-sh64/uaccess.h did.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/sh/include/asm/uaccess_64.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/sh/include/asm/uaccess_64.h
+++ b/arch/sh/include/asm/uaccess_64.h
@@ -26,16 +26,16 @@ do {								\
 	retval = 0;						\
 	switch (size) {						\
 	case 1:							\
-		retval = __get_user_asm_b(x, ptr);		\
+		retval = __get_user_asm_b((void *)&(x), (long)ptr);\
 		break;						\
 	case 2:							\
-		retval = __get_user_asm_w(x, ptr);		\
+		retval = __get_user_asm_w((void *)&(x), (long)ptr);\
 		break;						\
 	case 4:							\
-		retval = __get_user_asm_l(x, ptr);		\
+		retval = __get_user_asm_l((void *)&(x), (long)ptr);\
 		break;						\
 	case 8:							\
-		retval = __get_user_asm_q(x, ptr);		\
+		retval = __get_user_asm_q((void *)&(x), (long)ptr);\
 		break;						\
 	default:						\
 		__get_user_unknown();				\
@@ -54,16 +54,16 @@ do {								\
 	retval = 0;						\
 	switch (size) {						\
 	case 1:							\
-		retval = __put_user_asm_b(x, ptr);		\
+		retval = __put_user_asm_b((void *)&(x), (long)(ptr));\
 		break;						\
 	case 2:							\
-		retval = __put_user_asm_w(x, ptr);		\
+		retval = __put_user_asm_w((void *)&(x), (long)(ptr));\
 		break;						\
 	case 4:							\
-		retval = __put_user_asm_l(x, ptr);		\
+		retval = __put_user_asm_l((void *)&(x), (long)(ptr));\
 		break;						\
 	case 8:							\
-		retval = __put_user_asm_q(x, ptr);		\
+		retval = __put_user_asm_q((void *)&(x), (long)(ptr));\
 		break;						\
 	default:						\
 		__put_user_unknown();				\
