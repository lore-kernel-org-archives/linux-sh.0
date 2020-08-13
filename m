From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 13 Aug 2020 20:02:59 +0000
Subject: Re: [PATCH] locking/seqlock, headers: Untangle the spaghetti monster
Message-Id: <20200813200258.GA113946@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 02:35:11PM +0200, Peter Zijlstra wrote:
> By using lockdep_assert_*() from seqlock.h, the spaghetti monster
> attacked.
> 
> Attack back by reducing seqlock.h dependencies from two key high level headers:
> 
>  - <linux/seqlock.h>:               -Remove <linux/ww_mutex.h>
>  - <linux/time.h>:                  -Remove <linux/seqlock.h>
>  - <linux/sched.h>:                 +Add    <linux/seqlock.h>
> 
> The price was to add it to sched.h ...
> 
> Core header fallout, we add direct header dependencies instead of gaining them
> parasitically from higher level headers:
> 
>  - <linux/dynamic_queue_limits.h>:  +Add <asm/bug.h>
>  - <linux/hrtimer.h>:               +Add <linux/seqlock.h>
>  - <linux/ktime.h>:                 +Add <asm/bug.h>
>  - <linux/lockdep.h>:               +Add <linux/smp.h>
>  - <linux/sched.h>:                 +Add <linux/seqlock.h>
>  - <linux/videodev2.h>:             +Add <linux/kernel.h>
> 
> Arch headers fallout:
> 
>  - PARISC: <asm/timex.h>:           +Add <asm/special_insns.h>
>  - SH:     <asm/io.h>:              +Add <asm/page.h>
>  - SPARC:  <asm/timer_64.h>:        +Add <uapi/asm/asi.h>
>  - SPARC:  <asm/vvar.h>:            +Add <asm/processor.h>, <asm/barrier.h>
>                                     -Remove <linux/seqlock.h>
>  - X86:    <asm/fixmap.h>:          +Add <asm/pgtable_types.h>
>                                     -Remove <asm/acpi.h>
> 
> There's also a bunch of parasitic header dependency fallout in .c files, not listed
> separately.
> 
> [ mingo: Extended the changelog, split up & fixed the original patch. ]
> 
> Co-developed-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Building sh:defconfig ... failed
--------------
Error log:
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from include/linux/spinlock.h:318,
                 from arch/sh/include/asm/smp.h:11,
                 from include/linux/smp.h:82,
                 from include/linux/lockdep.h:14,
                 from include/linux/rcupdate.h:29,
                 from include/linux/init_task.h:5,
                 from init/init_task.c:2:
include/linux/spinlock_api_smp.h: In function '__raw_spin_trylock':
include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function 'spin_acquire'; did you mean 'xchg_acquire'? [-Werror=implicit-function-declaration]
   90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
      |   ^~~~~~~~~~~~
      |   xchg_acquire
include/linux/spinlock_api_smp.h:90:21: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
   90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);

and many more. Bisect log attached.

Guenter

---
# bad: [dc06fe51d26efc100ac74121607c01a454867c91] Merge tag 'rtc-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
# good: [96e3f3c16b7aedcd71502ccfc5778dddfc2e7b15] Merge tag 'thermal-v5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux
git bisect start 'HEAD' '96e3f3c16b7a'
# good: [32663c78c10f80df90b832de0428a6cb98a64e9a] Merge tag 'trace-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect good 32663c78c10f80df90b832de0428a6cb98a64e9a
# bad: [3a5139f1c5bb76d69756fb8f13fffa173e261153] cma: don't quit at first error when activating reserved areas
git bisect bad 3a5139f1c5bb76d69756fb8f13fffa173e261153
# good: [8d3e09b43312991c503478bf0f5f99e92c23ccf1] Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect good 8d3e09b43312991c503478bf0f5f99e92c23ccf1
# bad: [97d052ea3fa853b9aabcc4baca1a605cb1188611] Merge tag 'locking-urgent-2020-08-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 97d052ea3fa853b9aabcc4baca1a605cb1188611
# good: [4bcf69e57063c9b1b15df1a293c969e80a1c97e6] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect good 4bcf69e57063c9b1b15df1a293c969e80a1c97e6
# good: [1f0b067b6e4927f06f5ffaea8eccdf722e563819] f2fs: compress: disable compression mount option if compression is off
git bisect good 1f0b067b6e4927f06f5ffaea8eccdf722e563819
# good: [13c01139b17163c9b2aa543a9c39f8bbc875b625] x86/headers: Remove APIC headers from <asm/smp.h>
git bisect good 13c01139b17163c9b2aa543a9c39f8bbc875b625
# good: [e28c02b94f9e039beeb5c75198caf6e17b66c520] gfs2: When gfs2_dirty_inode gets a glock error, dump the glock
git bisect good e28c02b94f9e039beeb5c75198caf6e17b66c520
# good: [163c3e3dc0ddcea3edac51612fced13c597f37dc] Merge tag 'for-linus-5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
git bisect good 163c3e3dc0ddcea3edac51612fced13c597f37dc
# good: [828add774f0d2bf930cdeca6c982c1fbcdd846bb] f2fs: prepare a waiter before entering io_schedule
git bisect good 828add774f0d2bf930cdeca6c982c1fbcdd846bb
# bad: [0cd39f4600ed4de859383018eb10f0f724900e1b] locking/seqlock, headers: Untangle the spaghetti monster
git bisect bad 0cd39f4600ed4de859383018eb10f0f724900e1b
# good: [b3545192e2b4647234254c5122f8cbfddbcbdaa0] locking, arch/ia64: Reduce <asm/smp.h> header dependencies by moving XTP bits into the new <asm/xtp.h> header
git bisect good b3545192e2b4647234254c5122f8cbfddbcbdaa0
# first bad commit: [0cd39f4600ed4de859383018eb10f0f724900e1b] locking/seqlock, headers: Untangle the spaghetti monster
