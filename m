From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 20 Jan 2014 16:10:32 +0000
Subject: [PATCH] [V2] MAINTAINERS: Add dts files for r8 series to SHMOBILE
Message-Id: <1390234232-943-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk
Cc: linux-sh@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>, Joe Perches <joe@perches.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, linux-kernel@vger.kernel.org

Add a number of files to the list of files covered by SHMOBILE
so any changes to these can be reported with get_maintailers.pl
for the current SHMOILE architectures.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v2:
  - add defconfigs and r7 configurations
  - fix path to dt-bindings

Cc: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c20792..f74d830 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1239,7 +1239,14 @@ Q:	http://patchwork.kernel.org/project/linux-sh/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 S:	Supported
 F:	arch/arm/mach-shmobile/
+F:	arch/arm/boot/dts/r8*
+F:	arch/arm/boot/dts/r7*
+F:	arch/arm/configs/bockw_defconfig
+F:	arch/arm/configs/genmai_defconfig
+F:	arch/arm/configs/lager_defconfig
+F:	arch/arm/configs/marzen_defconfig
 F:	drivers/sh/
+F:	include/dt-bindings/clock/r8a*
 
 ARM/SOCFPGA ARCHITECTURE
 M:	Dinh Nguyen <dinguyen@altera.com>
-- 
1.8.5.2

