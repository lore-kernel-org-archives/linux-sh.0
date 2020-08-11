From: Jann Horn <jannh@google.com>
Date: Tue, 11 Aug 2020 03:05:42 +0000
Subject: Re: [PATCH v2 1/5] binfmt_elf_fdpic: Stop using dump_emit() on user pointers on !MMU
Message-Id: <CAG48ez3ssZLqGC_Jy1su93wieCtvaxEtVw43skiXcKFHEMhp5A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429214954.44866-2-jannh@google.com>
 <20200505104805.GA17400@lst.de>
 <CAG48ez3F70-UXwdHmO4CnR0bAForn-SBtstW5WAYjcrLFwS_9A@mail.gmail.com>
 <20200505121557.GA24052@lst.de>
In-Reply-To: <20200505121557.GA24052@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On Tue, May 5, 2020 at 2:15 PM Christoph Hellwig <hch@lst.de> wrote:
> On Tue, May 05, 2020 at 01:42:12PM +0200, Jann Horn wrote:
> > On Tue, May 5, 2020 at 12:48 PM Christoph Hellwig <hch@lst.de> wrote:
> > > On Wed, Apr 29, 2020 at 11:49:50PM +0200, Jann Horn wrote:
> > > > dump_emit() is for kernel pointers, and VMAs describe userspace memory.
> > > > Let's be tidy here and avoid accessing userspace pointers under KERNEL_DS,
> > > > even if it probably doesn't matter much on !MMU systems - especially given
> > > > that it looks like we can just use the same get_dump_page() as on MMU if
> > > > we move it out of the CONFIG_MMU block.
> > >
> > > Looks sensible.  Did you get a chance to test this with a nommu setup?
> >
> > Nope. Do you happen to have a recommendation for a convenient
> > environment I can use with QEMU, or something like that? I'm guessing
> > that just running a standard armel Debian userspace with a !mmu ARM
> > kernel wouldn't work so well?
>
> Nommu generally needs special userspace either using uclibc-ng or musl.
> When I did the RISC-V nommu work I used buildroot for my root file
> systems.  We haven't gotten elffdpic to work on RISC-V yet, so I can't
> use that setup for testing, but it should support ARM as well.

I've finally gotten around to testing this, and discovered that I
actually had to change something in the patch - thanks for asking me
to test this.



Some notes on running ARM nommu testing:

I ended up running QEMU with "-machine versatilepb". To make that
work, I applied this patch:
<https://github.com/buildroot/buildroot/blob/master/board/qemu/arm-versatile/patches/linux/versatile-nommu.patch>
A couple of directories up, there are also a README and a kernel
config for that.

Note that the emulated harddrive of this board doesn't seem to work,
because it's connected via PCI, and nommu generally can't use PCI; but
you can boot from initramfs, and you can copy files from/to the host
with netcat, since the emulated network card does work. (To avoid
having to bring up the interface from userspace, you can use
"ip.0.2.1::10.0.2.2:255.255.255.0" on the kernel cmdline if the
corresponding feature is enabled in the kernel config.)

The first trouble I ran into with trying to run FDPIC userspace (based
on musl) was that Linux has support for running ARM userspace in
"26-bit mode", which is some ARM feature from the dark ages, with no
support in QEMU; and while normally Linux only tries to enable that
thing when the binary explicitly requires it, the FDPIC path isn't
wired up to the appropriate personality logic properly, and so you get
a spectacular explosion, where eventually the kernel oopses with a
message about how it's trying to load an invalid value into CPSR
because first the kernel tries to return to 26-bit mode, and then,
through some mysterious spooky action at a distance, the kernel
(AFAICS) ends up trying to do a syscall return with the stack pointer
pointing somewhere in the middle of the kernel stack (and not where
the entry register frame is).

Anyway, my hacky workaround for that is:

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index b9241051e5cb..d5aa409e366c 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -70,7 +70,7 @@ static inline void
arch_thread_struct_whitelist(unsigned long *offset,
        if (current->personality & ADDR_LIMIT_32BIT)                    \
                regs->ARM_cpsr = USR_MODE;                              \
        else                                                            \
-               regs->ARM_cpsr = USR26_MODE;                            \
+               { WARN(1, "setting USR26_MODE"); regs->ARM_cpsr = USR_MODE; } \
        if (elf_hwcap & HWCAP_THUMB && pc & 1)                          \
                regs->ARM_cpsr |= PSR_T_BIT;                            \
        regs->ARM_cpsr |= PSR_ENDSTATE;                                 \


Next up: Early on in the libc startup code, musl aborts execution by
intentionally executing an undefined instruction in
__set_thread_area(), because it can't figure out any working
implementation of atomic cmpxchg. For the MMU case, there is a kuser
helper (what x86 would call vsyscall); but for NOMMU ARM, no working
implementation exists. So I gave up on musl and went with uclibc-ng
(built via buildroot) instead, since uclibc-ng has support for
compiling out thread support.


Annoyingly, buildroot doesn't support FDPIC (at least not for nommu
ARM). So I ended up telling it to build a small FLAT userspace, and
used a standard ARM toolchain to build a tiny static PIE ELF binary
with no reliance on libc (the FDPIC loader can actually load normal
ELF mostly fine as long as it's PIE, at the cost of having to
duplicate the text section for every instance) - luckily I didn't need
the ELF binary to actually do anything complicated, and so working
without any libc was tolerable:

arm-linux-gnueabi-gcc-10 -fPIC -c -o test_crash.o test_crash.c
arm-linux-gnueabi-ld -pie --no-dynamic-linker -o test_crash test_crash.o


Next fun part: gdb-multiarch doesn't seem to be able to open FDPIC
core dumps properly - none of the register status is available. I took
apart the core dump before and after the patch in a hex editor,
though, and it seems to have all the expected stuff in it. I'm
guessing that maybe GDB got thrown off by struct elf_prstatus having a
different layout if the core dump was generated on nommu? GDB's
elf32_arm_nabi_grok_prstatus() seems to only handle the struct size
for the non-FDPIC struct.
