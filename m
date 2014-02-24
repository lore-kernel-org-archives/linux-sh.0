From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 24 Feb 2014 05:41:07 +0000
Subject: [PATCH 01/12] ARM: shmobile: Add temporary include workaround
Message-Id: <20140224054107.1143.71718.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140224054058.1143.14096.sendpatchset@w520>
In-Reply-To: <20140224054058.1143.14096.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add temporary include path in the mach-shmobile Makefile to
aid coversion from using <mach/something.h> to "something.h"
in the source files.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-02-24 13:03:32.000000000 +0900
@@ -4,6 +4,8 @@
 
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
 
+ccflags-y := -I$(srctree)/arch/arm/mach-shmobile/include/mach
+
 # Common objects
 obj-y				:= timer.o console.o
 
