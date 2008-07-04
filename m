From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Fri, 04 Jul 2008 00:24:52 +0000
Subject: Re: sh64 build error - sh, kbuild or binutils problem?
Message-Id: <87iqvmsdgr.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <8763rng2q0.wl%ysato@users.sourceforge.jp>
In-Reply-To: <8763rng2q0.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

At Thu, 3 Jul 2008 19:03:23 +0900,
Paul Mundt wrote:
> 
> On Wed, Jul 02, 2008 at 09:45:27PM -0400, Yoshinori Sato wrote:
> > At Sun, 1 Jun 2008 14:30:47 +0900,
> > Paul Mundt wrote:
> > > 
> > > On Sat, May 31, 2008 at 11:22:39PM +0300, Adrian Bunk wrote:
> > > > Minimal example demonstrating the problem:
> > > > 
> > > > $ sh64-linux-ar rcs tmp.o
> > > > $ sh64-linux-ld -EL -r -o tmp2.o tmp.o
> > > > $ sh64-linux-ld -EL -r -o out.o tmp2.o 
> > > > sh64-linux-ld: sh3 architecture of input file `tmp2.o' is incompatible with sh5 output
> > > > $ 
> > > > 
> > > Yes, it's a binutils bug. I've hit this on SH-2A zImage builds too, and
> > > hacked together a patch for it. I'll see about fixing it up fo sh64 too
> > > and then posting it to the list.
> > 
> > I think ld is strict machine type check.
> > 
> > This is workaround.
> > SH-2A build success.
> > 
> This is probably a reasonable workaround until fixed versions of binutils
> are more readily available. Please re-send this with a Signed-off-by and
> I'll add it to my queue.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

diff --git a/arch/sh/boot/compressed/Makefile_32 b/arch/sh/boot/compressed/Makefile_32
index c0d25fb..47685f6 100644
--- a/arch/sh/boot/compressed/Makefile_32
+++ b/arch/sh/boot/compressed/Makefile_32
@@ -35,8 +35,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-LDFLAGS_piggy.o := -r --format binary --oformat elf32-sh-linux -T
 OBJCOPYFLAGS += -R .empty_zero_page
 
-$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
-	$(call if_changed,ld)
+$(obj)/piggy.o: $(obj)/piggy.S $(obj)/vmlinux.bin.gz FORCE
+	$(call if_changed,as_o_S)
diff --git a/arch/sh/boot/compressed/Makefile_64 b/arch/sh/boot/compressed/Makefile_64
index 912f3e2..658d4f9 100644
--- a/arch/sh/boot/compressed/Makefile_64
+++ b/arch/sh/boot/compressed/Makefile_64
@@ -37,8 +37,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-LDFLAGS_piggy.o := -r --format binary --oformat elf32-sh64-linux -T
 OBJCOPYFLAGS += -R .empty_zero_page
 
-$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
-	$(call if_changed,ld)
+$(obj)/piggy.o: $(obj)/piggy.S $(obj)/vmlinux.bin.gz FORCE
+	$(call if_changed,as_o_S)
diff --git a/arch/sh/boot/compressed/piggy.S b/arch/sh/boot/compressed/piggy.S
new file mode 100644
index 0000000..5660719
--- /dev/null
+++ b/arch/sh/boot/compressed/piggy.S
@@ -0,0 +1,8 @@
+	.global	input_len, input_data
+	.data
+input_len:
+	.long	input_data_end - input_data
+input_data:
+	.incbin	"arch/sh/boot/compressed/vmlinux.bin.gz"
+input_data_end:
+	.end
diff --git a/arch/sh/boot/compressed/vmlinux.scr b/arch/sh/boot/compressed/vmlinux.scr
deleted file mode 100644
index 1ed9d79..0000000
--- a/arch/sh/boot/compressed/vmlinux.scr
+++ /dev/null
@@ -1,9 +0,0 @@
-SECTIONS
-{
-  .data : { 
-	input_len = .;
-	LONG(input_data_end - input_data) input_data = .; 
-	*(.data) 
-	input_data_end = .; 
-	}
-}

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
