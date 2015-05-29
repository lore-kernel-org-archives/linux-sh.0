From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 29 May 2015 00:48:11 +0000
Subject: [PATCH 13/15] sh: don't use module_init in non-modular psw.c code
Message-Id: <1432860493-23831-14-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432860493-23831-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1432860493-23831-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

The psw.o is built for obj-y -- and hence this code is always
present.  It will never be modular, so using module_init as an alias
for __initcall can be somewhat misleading.

Fix this up now, so that we can relocate module_init from
init.h into module.h in the future.  If we don't do this, we'd
have to add module.h to obviously non-modular code, and that
would be a worse thing.

Note that direct use of __initcall is discouraged, vs. one
of the priority categorized subgroups.  As __initcall gets
mapped onto device_initcall, our use of device_initcall
directly in this change means that the runtime impact is
zero -- it will remain at level 6 in initcall ordering.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sh/boards/mach-landisk/psw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-landisk/psw.c b/arch/sh/boards/mach-landisk/psw.c
index bef83522f958..5192b1f43ada 100644
--- a/arch/sh/boards/mach-landisk/psw.c
+++ b/arch/sh/boards/mach-landisk/psw.c
@@ -140,4 +140,4 @@ static int __init psw_init(void)
 {
 	return platform_add_devices(psw_devices, ARRAY_SIZE(psw_devices));
 }
-module_init(psw_init);
+device_initcall(psw_init);
-- 
2.2.1

