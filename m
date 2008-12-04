From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 13:45:20 +0000
Subject: [PATCH 03/03] sh: allow CONFIG_CPU_IDLE
Message-Id: <20081204134520.21168.6576.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Allow users to select CONFIG_CPU_IDLE regardless of processor type or board.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- 0009/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-12-04 21:55:52.000000000 +0900
@@ -762,7 +762,9 @@ endmenu
 menu "Power management options (EXPERIMENTAL)"
 depends on EXPERIMENTAL
 
-source kernel/power/Kconfig
+source "kernel/power/Kconfig"
+
+source "drivers/cpuidle/Kconfig"
 
 endmenu
 
