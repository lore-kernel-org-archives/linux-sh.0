From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Aug 2011 01:07:36 +0000
Subject: Can not compile Ecovec board
Message-Id: <87aaaxou97.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul, Magnus, SH-ML members

I can not compile Ecovec board on latest linus/master branch
it say

-------------------------
  GEN     /opt/usr/src/WORK/morimoto/gitlinux/binary/ecovec/Makefile
  CHK     include/linux/version.h
  Using /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6 as source for kernel
  CHK     include/generated/utsrelease.h
make[3]: `include/generated/machtypes.h' is up to date.
  CALL    /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      arch/sh/kernel/idle.o
  CC      arch/sh/kernel/ptrace_32.o
  CC      arch/sh/kernel/return_address.o
/opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/arch/sh/kernel/idle.c:25:15: error: static declaration of 'pm_idle' follows non-static declaration
/opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/include/linux/pm.h:34:15: note: previous declaration of 'pm_idle' was here
make[3]: *** [arch/sh/kernel/idle.o] Error 1
make[3]: *** Waiting for unfinished jobs....
/opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/arch/sh/kernel/ptrace_32.c:66:6: error: conflicting types for 'ptrace_triggered'
/opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/arch/sh/include/asm/ptrace.h:126:13: note: previous declaration of 'ptrace_triggered' was here
make[3]: *** [arch/sh/kernel/ptrace_32.o] Error 1
make[2]: *** [arch/sh/kernel] Error 2
make[2]: *** Waiting for unfinished jobs....
make[2]: *** wait: No child processes.  Stop.
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2
-------------------------

Best regards
---
Kuninori Morimoto
