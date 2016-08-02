From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 10:35:26 +0000
Subject: [PATCH 0027/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802103526.15569-1-baolex.ni@intel.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, phacht@linux.vnet.ibm.com, keescook@chromium.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/sh/mm/alignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/alignment.c b/arch/sh/mm/alignment.c
index ec2b253..6cb05b2 100644
--- a/arch/sh/mm/alignment.c
+++ b/arch/sh/mm/alignment.c
@@ -29,7 +29,7 @@ static int se_usermode = UM_WARN | UM_FIXUP;
 /* 0: no warning 1: print a warning message, disabled by default */
 static int se_kernmode_warn;
 
-core_param(alignment, se_usermode, int, 0600);
+core_param(alignment, se_usermode, int, S_IRUSR | S_IWUSR);
 
 void inc_unaligned_byte_access(void)
 {
-- 
2.9.2

