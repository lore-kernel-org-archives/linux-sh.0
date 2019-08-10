From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Sat, 10 Aug 2019 04:59:44 +0000
Subject: [PATCH] sh: kernel: hw_breakpoint: Fix missing break in switch statement
Message-Id: <20190810045944.GA13815@embeddedor>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Guenter Roeck <linux@roeck-us.net>

Add missing break statement in order to prevent the code from
erroneously falling through to case SH_BREAKPOINT_WRITE.

Fixes: 09a072947791 ("sh: hw-breakpoints: Add preliminary support for SH-4A UBC.")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---

If no one cares, I'll apply this to my tree and queue it up for 5.3-rc4.

 arch/sh/kernel/hw_breakpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index 3bd010b4c55f..f10d64311127 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -157,6 +157,7 @@ int arch_bp_generic_fields(int sh_len, int sh_type,
 	switch (sh_type) {
 	case SH_BREAKPOINT_READ:
 		*gen_type = HW_BREAKPOINT_R;
+		break;
 	case SH_BREAKPOINT_WRITE:
 		*gen_type = HW_BREAKPOINT_W;
 		break;
-- 
2.22.0
