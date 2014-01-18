From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sat, 18 Jan 2014 14:57:51 +0000
Subject: [PATCH] MAINTAINERS: Add dts files for r8 series to SHMOBILE
Message-Id: <1390057071-12455-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add arch/arm/boot/dts/r8* to the list of files covered by SHMOBILE
so any changes to these can be reported with get_maintailers.pl

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Joe Perches <joe@perches.com> (commit_signer:26/328=8%)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:27/328=8%)
Cc: Andrew Morton <akpm@linux-foundation.org> (commit_signer:41/328%)
Cc: Magnus Damm <magnus.damm@gmail.com> (supporter:ARM/SHMOBILE ARM...)
Cc: Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM...)
Cc: linux-sh@vger.kernel.org
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c20792..30fb6dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1239,6 +1239,8 @@ Q:	http://patchwork.kernel.org/project/linux-sh/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm/mach-shmobile/
+F:	arch/arm/boot/dts/r8*
+F:	arch/arm/boot/dts/include/dt-bindings/clock/r8a*
 F:	drivers/sh/
 
 ARM/SOCFPGA ARCHITECTURE
-- 
1.8.5.2

