From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 22 Jan 2014 20:56:16 +0000
Subject: [PATCH] sh: don't use module_init in non-modular psw.c code
Message-Id: <1390424176-5874-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

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

[patch will be added to init cleanup series:
   http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git/  ]

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
1.8.5.2

