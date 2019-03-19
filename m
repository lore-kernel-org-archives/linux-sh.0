From: Colin King <colin.king@canonical.com>
Date: Tue, 19 Mar 2019 14:27:58 +0000
Subject: [PATCH] hw-breakpoints: fix missing break for SH_BREAKPOINT_READ
Message-Id: <20190319142758.24856-1-colin.king@canonical.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Frederic Weisbecker <frederic@kernel.org>, linux-sh@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The SH_BREAKPOINT_READ case is missing a break and
falling through to SH_BREAKPOINT_WRITE. Fix this.

Fixes: 09a072947791 ("sh: hw-breakpoints: Add preliminary support for SH-4A UBC.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/sh/kernel/hw_breakpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index bc96b16288c1..af6a65ac04cf 100644
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
2.20.1
