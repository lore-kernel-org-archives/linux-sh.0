From: Fengguang Wu <fengguang.wu@intel.com>
Date: Fri, 26 Aug 2016 12:51:26 +0000
Subject: Re: [kbuild-all] [peterz-queue:locking/rfc 3/5] arch/sh/include/asm/atomic-llsc.h:76:38: note: in ex
Message-Id: <20160826125126.wrs3csbiv3qtafdi@wfg-t540p.sh.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160826114225.hloesk72zqvajrmj@wfg-t540p.sh.intel.com>
In-Reply-To: <20160826114225.hloesk72zqvajrmj@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Fri, Aug 26, 2016 at 08:31:53PM +0800, Fengguang Wu wrote:
>On Fri, Aug 26, 2016 at 07:42:25PM +0800, Fengguang Wu wrote:
>>Hi Peter,
>>
>>On Fri, Aug 26, 2016 at 11:34:23AM +0200, Peter Zijlstra wrote:
>>>
>>>SH folks, could you help me decode this?
>>>
>>>I more or less copied this from ATOMIC_OP_RETURN() which seems to work
>>>just fine.
>>
>>Yeah this error message looks hard to interpret. CC sh people while
>>trying to interpret it with my little experience.
>>
>>I just managed to reproduce it
>>
>>The parent commit builds fine:
>>
>>wfg /c/linux% /usr/bin/make ARCH=sh CROSS_COMPILE=sh4-linux-gnu-
>>...
>>  OBJCOPY arch/sh/boot/zImage
>>  Kernel: arch/sh/boot/zImage is ready
>>
>>While commit 5d1977c stops here.
>>
>>  CC      kernel/locking/mutex.o
>>In file included from ./arch/sh/include/asm/atomic.h:29:0,
>>                 from ./include/linux/atomic.h:4,
>>                 from ./include/linux/mutex.h:18,
>>                 from kernel/locking/mutex.c:20:
>>kernel/locking/mutex.c: In function ‘mutex_unlock’:
>
>It's this atomic_long_fetch_and() that triggered the error.
>It builds fine if line 505 is commented out.
>
>503         owner = atomic_long_read(&lock->owner);                                                                                 504         if (!(owner & MUTEX_FLAG_HANDOFF))
>505                 owner = atomic_long_fetch_and(MUTEX_FLAGS, &lock->owner);
>                            ~~~~~~~~~~~~~~~~~~~~~

Perhaps the sh ARCH does not support that OP. I can reproduce this
error if checking out the parent commit and apply this test patch:
 
@@ -434,6 +434,7 @@ void __sched mutex_unlock(struct mutex *lock)
         */
        mutex_clear_owner(lock);
 #endif
+       atomic_long_fetch_and(0, 0);
        __mutex_fastpath_unlock(&lock->count, __mutex_unlock_slowpath);
 }

Cheers,
Fengguang

>>./arch/sh/include/asm/atomic-llsc.h:56:2: error: can’t find a register in class ‘R0_REGS’ while reloading ‘asm’
>>  __asm__ __volatile__ (      \
>>  ^
>>./arch/sh/include/asm/atomic-llsc.h:76:38: note: in expansion of macro ‘ATOMIC_FETCH_OP’
>> #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
>>                                      ^~~~~~~~~~~~~~~
>>./arch/sh/include/asm/atomic-llsc.h:78:1: note: in expansion of macro ‘ATOMIC_OPS’
>> ATOMIC_OPS(and)
>> ^~~~~~~~~~
>>./arch/sh/include/asm/atomic-llsc.h:56:2: error: ‘asm’ operand has impossible constraints
>>  __asm__ __volatile__ (      \
>>  ^
>>./arch/sh/include/asm/atomic-llsc.h:76:38: note: in expansion of macro ‘ATOMIC_FETCH_OP’
>> #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
>>                                      ^~~~~~~~~~~~~~~
>>./arch/sh/include/asm/atomic-llsc.h:78:1: note: in expansion of macro ‘ATOMIC_OPS’
>> ATOMIC_OPS(and)
>> ^~~~~~~~~~
>>scripts/Makefile.build:289: recipe for target 'kernel/locking/mutex.o' failed
>>make[2]: *** [kernel/locking/mutex.o] Error 1
>>scripts/Makefile.build:440: recipe for target 'kernel/locking' failed
>>make[1]: *** [kernel/locking] Error 2
>>Makefile:968: recipe for target 'kernel' failed
>>make: *** [kernel] Error 2
>>
>>I'm reproducing with Debian's latest gcc-sh4 cross compiler:
>>
>>Package: gcc-sh4-linux-gnu
>>Version: 4:6.1.1--2
>>
>>Thanks,
>>Fengguang
>>
>>>On Fri, Aug 26, 2016 at 06:14:40AM +0800, kbuild test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/rfc
>>>> head:   adbaf84bd3c6d786114c68e4e2d53ac42957e8d8
>>>> commit: 5d1977c2783b1ee817776e90c613721e7ba5edd5 [3/5] locking/mutex: Rework mutex::owner
>>>> config: sh-sh7724_generic_defconfig (attached as .config)
>>>> compiler: sh4-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
>>>> reproduce:
>>>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>>>         chmod +x ~/bin/make.cross
>>>>         git checkout 5d1977c2783b1ee817776e90c613721e7ba5edd5
>>>>         # save the attached .config to linux build tree
>>>>         make.cross ARCH=sh
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>    In file included from arch/sh/include/asm/atomic.h:29:0,
>>>>                     from include/linux/atomic.h:4,
>>>>                     from include/linux/mutex.h:18,
>>>>                     from kernel/locking/mutex.c:20:
>>>>    kernel/locking/mutex.c: In function 'mutex_unlock':
>>>>    arch/sh/include/asm/atomic-llsc.h:56:2: error: can't find a register in class 'R0_REGS' while reloading 'asm'
>>>>      __asm__ __volatile__ (      \
>>>>      ^
>>>> >> arch/sh/include/asm/atomic-llsc.h:76:38: note: in expansion of macro 'ATOMIC_FETCH_OP'
>>>>     #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
>>>>                                          ^
>>>> >> arch/sh/include/asm/atomic-llsc.h:78:1: note: in expansion of macro 'ATOMIC_OPS'
>>>>     ATOMIC_OPS(and)
>>>>     ^
>>>>    arch/sh/include/asm/atomic-llsc.h:56:2: error: 'asm' operand has impossible constraints
>>>>      __asm__ __volatile__ (      \
>>>>      ^
>>>> >> arch/sh/include/asm/atomic-llsc.h:76:38: note: in expansion of macro 'ATOMIC_FETCH_OP'
>>>>     #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
>>>>                                          ^
>>>> >> arch/sh/include/asm/atomic-llsc.h:78:1: note: in expansion of macro 'ATOMIC_OPS'
>>>>     ATOMIC_OPS(and)
>>>>     ^
>>>>
>>>> vim +/ATOMIC_FETCH_OP +76 arch/sh/include/asm/atomic-llsc.h
>>>>
>>>> ec723fbe7 include/asm-sh/atomic-llsc.h      Paul Mundt     2006-12-07  50
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  51  #define ATOMIC_FETCH_OP(op)						\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  52  static inline int atomic_fetch_##op(int i, atomic_t *v)			\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  53  {									\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  54  	unsigned long res, temp;					\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  55  									\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18 @56  	__asm__ __volatile__ (						\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  57  "1:	movli.l @%3, %0		! atomic_fetch_" #op "	\n"		\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  58  "	mov %0, %1					\n"		\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  59  "	" #op "	%2, %0					\n"		\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  60  "	movco.l	%0, @%3					\n"		\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  61  "	bf	1b					\n"		\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  62  "	synco						\n"		\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  63  	: "=&z" (temp), "=&z" (res)					\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  64  	: "r" (i), "r" (&v->counter)					\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  65  	: "t");								\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  66  									\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  67  	return res;							\
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  68  }
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  69
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  70  #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
>>>> ec723fbe7 include/asm-sh/atomic-llsc.h      Paul Mundt     2006-12-07  71
>>>> c6470150d arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2014-03-26  72  ATOMIC_OPS(add)
>>>> c6470150d arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2014-03-26  73  ATOMIC_OPS(sub)
>>>> ec723fbe7 include/asm-sh/atomic-llsc.h      Paul Mundt     2006-12-07  74
>>>> c6470150d arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2014-03-26  75  #undef ATOMIC_OPS
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18 @76  #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  77
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18 @78  ATOMIC_OPS(and)
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  79  ATOMIC_OPS(or)
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  80  ATOMIC_OPS(xor)
>>>> 7d9794e75 arch/sh/include/asm/atomic-llsc.h Peter Zijlstra 2016-04-18  81
>>>>
>>>> :::::: The code at line 76 was first introduced by commit
>>>> :::::: 7d9794e7523798e1b9422ad9f4e4d808ae5d5932 locking/atomic, arch/sh: Implement atomic_fetch_{add,sub,and,or,xor}()
>>>>
>>>> :::::: TO: Peter Zijlstra <peterz@infradead.org>
>>>> :::::: CC: Ingo Molnar <mingo@kernel.org>
>>>>
>>>> ---
>>>> 0-DAY kernel test infrastructure                Open Source Technology Center
>>>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>>>
>>>
>>>_______________________________________________
>>>kbuild-all mailing list
>>>kbuild-all@lists.01.org
>>>https://lists.01.org/mailman/listinfo/kbuild-all
