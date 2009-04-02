From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Apr 2009 03:32:27 +0000
Subject: Re: qemu-sh CF access perormance
Message-Id: <20090402033227.GA11327@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49D2185C.4050909@juno.dti.ne.jp>
In-Reply-To: <49D2185C.4050909@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 02, 2009 at 12:25:19AM +0900, Shin-ichiro KAWASAKI wrote:
> Hi, Magnus!  Thank you for your explanation.
> 
> Magnus Damm wrote:
> >2009/3/31 Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>:
> >>I'd like to ask following questions to linux-sh experts,
> >>
> >> - Why such io-traps are used to access CF?
> >> - Will this io-traps are used for SH7785LCR's SD card access?
> >>
> >>I guess these io-traps can be the reason why gcc takes so much time on 
> >>qemu-sh.
> >
> >The r2d hardware implements 16-bit only CF interface while driver
> >software requires 8-bit access. To work around this issue io_trapped
> >is used to convert 8-bit accesses to 16-bit accesses. This is quite
> >slow.
> >
> >For more information, please see the comment in 
> >arch/sh/boards/mach-r2d/setup.c
> >
> >To improve performance, consider adding a command line flag to the
> >kernel that disables io_trapped. This flag can then be set on the
> >kernel command line by the person running qemu.
> >
> >Hope this helps!
> 
> It really helps!
> 
> The attached patch is a rough implementation to add a command line
> flag 'avoid_trap', which Magnus suggested.  It is just a reference,
> but it reduces the gcc compile time from 40 seconds to around 4 seconds.
> 10 times faster!
> 
> Is it OK to add such qemu specific options to linux kernel mainline?
> 
Sure, why not. Try this:

---

commit eeee7853c4ffaf5b9eb58f39708e3c78f66cee15
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Thu Apr 2 12:31:16 2009 +0900

    sh: Add a command line option for disabling I/O trapping.
    
    This adds a 'noiotrap' kernel command line option to permit disabling of
    I/O trapping. This is mostly useful for running on emulators where the
    physical device limitations are not an issue.
    
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 240257d..8b2067c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1544,6 +1544,8 @@ and is between 256 and 4096 characters. It is defined in the file
 			Valid arguments: on, off
 			Default: on
 
+	noiotrap	[SH] Disables trapped I/O port accesses.
+
 	noirqdebug	[X86-32] Disables the code which attempts to detect and
 			disable unhandled interrupt sources.
 
diff --git a/arch/sh/kernel/io_trapped.c b/arch/sh/kernel/io_trapped.c
index 39cd7f3..c22853b 100644
--- a/arch/sh/kernel/io_trapped.c
+++ b/arch/sh/kernel/io_trapped.c
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
+#include <linux/init.h>
 #include <asm/system.h>
 #include <asm/mmu_context.h>
 #include <asm/uaccess.h>
@@ -32,6 +33,15 @@ EXPORT_SYMBOL_GPL(trapped_mem);
 #endif
 static DEFINE_SPINLOCK(trapped_lock);
 
+static int trapped_io_disable __read_mostly;
+
+static int __init trapped_io_setup(char *__unused)
+{
+	trapped_io_disable = 1;
+	return 1;
+}
+__setup("noiotrap", trapped_io_setup);
+
 int register_trapped_io(struct trapped_io *tiop)
 {
 	struct resource *res;
@@ -39,6 +49,9 @@ int register_trapped_io(struct trapped_io *tiop)
 	struct page *pages[TRAPPED_PAGES_MAX];
 	int k, n;
 
+	if (unlikely(trapped_io_disable))
+		return 0;
+
 	/* structure must be page aligned */
 	if ((unsigned long)tiop & (PAGE_SIZE - 1))
 		goto bad;
