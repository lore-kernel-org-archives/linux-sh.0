From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu, 03 Jul 2008 01:45:27 +0000
Subject: Re: sh64 build error - sh, kbuild or binutils problem?
Message-Id: <8763rng2q0.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

At Sun, 1 Jun 2008 14:30:47 +0900,
Paul Mundt wrote:
> 
> On Sat, May 31, 2008 at 11:22:39PM +0300, Adrian Bunk wrote:
> > Minimal example demonstrating the problem:
> > 
> > $ sh64-linux-ar rcs tmp.o
> > $ sh64-linux-ld -EL -r -o tmp2.o tmp.o
> > $ sh64-linux-ld -EL -r -o out.o tmp2.o 
> > sh64-linux-ld: sh3 architecture of input file `tmp2.o' is incompatible with sh5 output
> > $ 
> > 
> Yes, it's a binutils bug. I've hit this on SH-2A zImage builds too, and
> hacked together a patch for it. I'll see about fixing it up fo sh64 too
> and then posting it to the list.

I think ld is strict machine type check.

This is workaround.
SH-2A build success.

diff -uN ../org/arch/sh/boot/compressed/Makefile_32 arch/sh/boot/compressed/Makefile_32
--- org/arch/sh/boot/compressed/Makefile_32	2008-07-01 00:34:41.000000000 -0400
+++ arch/sh/boot/compressed/Makefile_32	2008-07-02 21:21:57.000000000 -0400
@@ -35,8 +35,7 @@
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-LDFLAGS_piggy.o := -r --format binary --oformat elf32-sh-linux -T
 OBJCOPYFLAGS += -R .empty_zero_page
 
-$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
-	$(call if_changed,ld)
+$(obj)/piggy.o: $(obj)/piggy.S $(obj)/vmlinux.bin.gz FORCE
+	$(call if_changed,as_o_S)
diff -uN ../org/arch/sh/boot/compressed/piggy.S arch/sh/boot/compressed/piggy.S
--- ../org/arch/sh/boot/compressed/piggy.S	1969-12-31 19:00:00.000000000 -0500
+++ arch/sh/boot/compressed/piggy.S	2008-07-02 21:15:05.000000000 -0400
@@ -0,0 +1,8 @@
+	.global	input_len, input_data
+	.data
+input_len:
+	.long	input_data_end - input_data
+input_data:
+	.incbin	"arch/sh/boot/compressed/vmlinux.bin.gz"
+input_data_end:
+	.end

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
