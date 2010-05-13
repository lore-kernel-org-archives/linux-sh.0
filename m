From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Thu, 13 May 2010 00:06:23 +0000
Subject: [PATCH] lib/atomic64_test: Fix missing include of linux/kernel.h
Message-Id: <201005130206.24329.PeterHuewe@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-sh@vger.kernel.org, Luca Barbieri <luca@luca-barbieri.com>, linux-kernel@vger.kernel.org

From: Peter Huewe <peterhuewe@gmx.de>:

This patch fixes a build-failure[1] by adding the missing include file
(linux/kernel.h) for printk and KERN_INFO.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
KernelVersion: linux-next 20100512
References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2601239/

 lib/atomic64_test.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index 65e482c..9087d71 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -9,6 +9,7 @@
  * (at your option) any later version.
  */
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <asm/atomic.h>
 
 #define INIT(c) do { atomic64_set(&v, c); r = c; } while (0)
-- 
1.6.4.4

