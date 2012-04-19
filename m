From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Thu, 19 Apr 2012 10:06:30 +0000
Subject: [PATCH 3.4.0-rc3] sh:pfc: include sh_pfc.h header file.
Message-Id: <1334829990-9196-1-git-send-email-srinivas.kandagatla@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

This patch includes sh_pfc.h in pfc.c file, without this include kernel
build with CONFIG_GENERIC_GPIO will throw below errors.

drivers/sh/pfc.c:25:32: warning: ‘struct pinmux_info’ declared inside
parameter list [enabled by default]
drivers/sh/pfc.c:25:32: warning: its scope is only this definition or
declaration, which is probably not what you want [enabled by default]
drivers/sh/pfc.c: In function ‘pfc_iounmap’:
drivers/sh/pfc.c:29:21: error: dereferencing pointer to incomplete type
drivers/sh/pfc.c:30:10:error: dereferencing pointer to incomplete type
drivers/sh/pfc.c:31:15:error: dereferencing pointer to incomplete type
drivers/sh/pfc.c:33:11: error: dereferencing pointer to incomplete type

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
Hi All, 
This patch fixes a compilation error in the sh kernel build if CONFIG_GENERIC_GPIO is enabled.

--srini

 drivers/sh/pfc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/sh/pfc.c b/drivers/sh/pfc.c
index 522c6c4..505d7cf 100644
--- a/drivers/sh/pfc.c
+++ b/drivers/sh/pfc.c
@@ -21,6 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/sh_pfc.h>
 
 static void pfc_iounmap(struct pinmux_info *pip)
 {
-- 
1.7.0.4

