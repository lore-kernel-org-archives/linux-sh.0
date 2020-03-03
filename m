From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 03 Mar 2020 13:59:22 +0000
Subject: [PATCH v3 15/18] docs: sh: convert new-machine.txt to ReST
Message-Id: <504eee30e551469d3475bf1bc080abeb21fa7871.1583243826.git.mchehab+huawei@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1583243826.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1583243826.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, linux-doc@vger.kernel.org

- Add a SPDX header;
- Adjust document title to follow ReST style;
- Mark literal blocks as such;
- Mark a table as such;
- Add it to sh/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sh/index.rst                    |   5 +
 .../sh/{new-machine.txt => new-machine.rst}   | 195 +++++++++---------
 2 files changed, 106 insertions(+), 94 deletions(-)
 rename Documentation/sh/{new-machine.txt => new-machine.rst} (73%)

diff --git a/Documentation/sh/index.rst b/Documentation/sh/index.rst
index bc8db7ba894a..56c08790265d 100644
--- a/Documentation/sh/index.rst
+++ b/Documentation/sh/index.rst
@@ -4,6 +4,11 @@ SuperH Interfaces Guide
 
 :Author: Paul Mundt
 
+.. toctree::
+    :maxdepth: 1
+
+    new-machine
+
 Memory Management
 ======== 
diff --git a/Documentation/sh/new-machine.txt b/Documentation/sh/new-machine.rst
similarity index 73%
rename from Documentation/sh/new-machine.txt
rename to Documentation/sh/new-machine.rst
index e0961a66130b..e501c52b3b30 100644
--- a/Documentation/sh/new-machine.txt
+++ b/Documentation/sh/new-machine.rst
@@ -1,6 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-                Adding a new board to LinuxSH
-               ================
+==============+Adding a new board to LinuxSH
+============== 
                Paul Mundt <lethal@linux-sh.org>
 
@@ -19,65 +21,67 @@ include/asm-sh/. For the new kernel, things are broken out by board type,
 companion chip type, and CPU type. Looking at a tree view of this directory
 hierarchy looks like the following:
 
-Board-specific code:
+Board-specific code::
 
-.
-|-- arch
-|   `-- sh
-|       `-- boards
-|           |-- adx
-|           |   `-- board-specific files
-|           |-- bigsur
-|           |   `-- board-specific files
-|           |
-|           ... more boards here ...
-|
-`-- include
-    `-- asm-sh
-        |-- adx
-        |   `-- board-specific headers
-        |-- bigsur
-        |   `-- board-specific headers
-        |
-	.. more boards here ...
+    .
+    |-- arch
+    |   `-- sh
+    |       `-- boards
+    |           |-- adx
+    |           |   `-- board-specific files
+    |           |-- bigsur
+    |           |   `-- board-specific files
+    |           |
+    |           ... more boards here ...
+    |
+    `-- include
+	`-- asm-sh
+	    |-- adx
+	    |   `-- board-specific headers
+	    |-- bigsur
+	    |   `-- board-specific headers
+	    |
+	    .. more boards here ...
 
-Next, for companion chips:
-.
-`-- arch
-    `-- sh
-        `-- cchips
-            `-- hd6446x
-                `-- hd64461
-                    `-- cchip-specific files
+Next, for companion chips::
+
+    .
+    `-- arch
+	`-- sh
+	    `-- cchips
+		`-- hd6446x
+		    `-- hd64461
+			`-- cchip-specific files
 
 ... and so on. Headers for the companion chips are treated the same way as
 board-specific headers. Thus, include/asm-sh/hd64461 is home to all of the
 hd64461-specific headers.
 
-Finally, CPU family support is also abstracted:
-.
-|-- arch
-|   `-- sh
-|       |-- kernel
-|       |   `-- cpu
-|       |       |-- sh2
-|       |       |   `-- SH-2 generic files
-|       |       |-- sh3
-|       |       |   `-- SH-3 generic files
-|       |       `-- sh4
-|       |           `-- SH-4 generic files
-|       `-- mm
-|           `-- This is also broken out per CPU family, so each family can
-|               have their own set of cache/tlb functions.
-|
-`-- include
-    `-- asm-sh
-        |-- cpu-sh2
-        |   `-- SH-2 specific headers
-        |-- cpu-sh3
-        |   `-- SH-3 specific headers
-        `-- cpu-sh4
-            `-- SH-4 specific headers
+Finally, CPU family support is also abstracted::
+
+    .
+    |-- arch
+    |   `-- sh
+    |       |-- kernel
+    |       |   `-- cpu
+    |       |       |-- sh2
+    |       |       |   `-- SH-2 generic files
+    |       |       |-- sh3
+    |       |       |   `-- SH-3 generic files
+    |       |       `-- sh4
+    |       |           `-- SH-4 generic files
+    |       `-- mm
+    |           `-- This is also broken out per CPU family, so each family can
+    |               have their own set of cache/tlb functions.
+    |
+    `-- include
+	`-- asm-sh
+	    |-- cpu-sh2
+	    |   `-- SH-2 specific headers
+	    |-- cpu-sh3
+	    |   `-- SH-3 specific headers
+	    `-- cpu-sh4
+		`-- SH-4 specific headers
 
 It should be noted that CPU subtypes are _not_ abstracted. Thus, these still
 need to be dealt with by the CPU family specific code.
@@ -110,33 +114,33 @@ arch/sh/boards and the include/asm-sh/ hierarchy. In order to better
 explain this, we use some examples for adding an imaginary board. For
 setup code, we're required at the very least to provide definitions for
 get_system_type() and platform_setup(). For our imaginary board, this
-might look something like:
+might look something like::
 
-/*
- * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
- */
-#include <linux/init.h>
+    /*
+    * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
+    */
+    #include <linux/init.h>
 
-const char *get_system_type(void)
-{
-	return "FooTech Vaporboard";
-}
+    const char *get_system_type(void)
+    {
+	    return "FooTech Vaporboard";
+    }
 
-int __init platform_setup(void)
-{
-  	/*
-	 * If our hardware actually existed, we would do real
-	 * setup here. Though it's also sane to leave this empty
-	 * if there's no real init work that has to be done for
-	 * this board.
-	 */
+    int __init platform_setup(void)
+    {
+	    /*
+	    * If our hardware actually existed, we would do real
+	    * setup here. Though it's also sane to leave this empty
+	    * if there's no real init work that has to be done for
+	    * this board.
+	    */
 
-	/* Start-up imaginary PCI ... */
+	    /* Start-up imaginary PCI ... */
 
-	/* And whatever else ... */
+	    /* And whatever else ... */
 
-	return 0;
-}
+	    return 0;
+    }
 
 Our new imaginary board will also have to tie into the machvec in order for it
 to be of any use.
@@ -172,16 +176,16 @@ sufficient.
    vector.
 
    Note that these prototypes are generated automatically by setting
-   __IO_PREFIX to something sensible. A typical example would be:
+   __IO_PREFIX to something sensible. A typical example would be::
 
 	#define __IO_PREFIX vapor
-   	#include <asm/io_generic.h>
+	#include <asm/io_generic.h>
 
    somewhere in the board-specific header. Any boards being ported that still
    have a legacy io.h should remove it entirely and switch to the new model.
 
  - Add machine vector definitions to the board's setup.c. At a bare minimum,
-   this must be defined as something like:
+   this must be defined as something like::
 
 	struct sh_machine_vector mv_vapor __initmv = {
 		.mv_name = "vapor",
@@ -202,20 +206,20 @@ Large portions of the build system are now entirely dynamic, and merely
 require the proper entry here and there in order to get things done.
 
 The first thing to do is to add an entry to arch/sh/Kconfig, under the
-"System type" menu:
+"System type" menu::
 
-config SH_VAPOR
-	bool "Vapor"
-	help
-	  select Vapor if configuring for a FooTech Vaporboard.
+    config SH_VAPOR
+	    bool "Vapor"
+	    help
+	    select Vapor if configuring for a FooTech Vaporboard.
 
 next, this has to be added into arch/sh/Makefile. All boards require a
 machdir-y entry in order to be built. This entry needs to be the name of
 the board directory as it appears in arch/sh/boards, even if it is in a
 sub-directory (in which case, all parent directories below arch/sh/boards/
-need to be listed). For our new board, this entry can look like:
+need to be listed). For our new board, this entry can look like::
 
-machdir-$(CONFIG_SH_VAPOR)	+= vapor
+    machdir-$(CONFIG_SH_VAPOR)	+= vapor
 
 provided that we've placed everything in the arch/sh/boards/vapor/ directory.
 
@@ -230,7 +234,7 @@ This is done by adding an entry to the end of the arch/sh/tools/mach-types
 list. The method for doing this is self explanatory, and so we won't waste
 space restating it here. After this is done, you will be able to use
 implicit checks for your board if you need this somewhere throughout the
-common code, such as:
+common code, such as::
 
 	/* Make sure we're on the FooTech Vaporboard */
 	if (!mach_is_vapor())
@@ -253,16 +257,19 @@ build target, and it will be implicitly listed as such in the help text.
 Looking at the 'make help' output, you should now see something like:
 
 Architecture specific targets (sh):
-  zImage                  - Compressed kernel image (arch/sh/boot/zImage)
-  adx_defconfig           - Build for adx
-  cqreek_defconfig        - Build for cqreek
-  dreamcast_defconfig     - Build for dreamcast
-...
-  vapor_defconfig         - Build for vapor
 
-which then allows you to do:
+  ============   ======================+  zImage                    Compressed kernel image (arch/sh/boot/zImage)
+  adx_defconfig             Build for adx
+  cqreek_defconfig          Build for cqreek
+  dreamcast_defconfig       Build for dreamcast
+  ...
+  vapor_defconfig           Build for vapor
+  ============   ====================== 
-$ make ARCH=sh CROSS_COMPILE=sh4-linux- vapor_defconfig vmlinux
+which then allows you to do::
+
+    $ make ARCH=sh CROSS_COMPILE=sh4-linux- vapor_defconfig vmlinux
 
 which will in turn copy the defconfig for this board, run it through
 oldconfig (prompting you for any new options since the time of creation),
-- 
2.24.1
