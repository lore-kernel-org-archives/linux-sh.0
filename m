From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 09 Aug 2020 13:39:50 +0000
Subject: "sh: convert to ->regset_get()" breaks linux-sh build
Message-Id: <9c2d391c-6463-398e-95a1-8f238d739340@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Al!

I just tried building Linux next for SH to test it on my SH7785LCR board
but the build is currently broken due to a regression introduced by your
change to convert SH to ->regset_get():

make[1]: 'include/generated/machtypes.h' is up to date.
  CALL    scripts/checksyscalls.sh
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CALL    scripts/atomic/check-atomics.sh
  CHK     include/generated/compile.h
  CC      arch/sh/kernel/ptrace_32.o
arch/sh/kernel/ptrace_32.c:168:5: error: conflicting types for ‘fpregs_get’
  168 | int fpregs_get(struct task_struct *target,
      |     ^~~~~~~~~~
In file included from arch/sh/kernel/ptrace_32.c:31:
./arch/sh/include/asm/fpu.h:40:12: note: previous declaration of ‘fpregs_get’ was here
   40 | extern int fpregs_get(struct task_struct *target,
      |            ^~~~~~~~~~
make[1]: *** [scripts/Makefile.build:283: arch/sh/kernel/ptrace_32.o] Error 1
make: *** [Makefile:1789: arch/sh/kernel] Error 2

This regression was introduced by:

commit 3399d90ce63edf7439900db50b5c02aa822f190b
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Jun 16 00:54:51 2020 -0400

    sh: convert to ->regset_get()

    NB: there's a direct call of fpregs_get() left in dump_fpu().
    To be taken out once we convert ELF_FDPIC to use of regset.

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

 arch/sh/kernel/process_32.c |  5 ++---
 arch/sh/kernel/ptrace_32.c  | 48 ++++++++++-----------------------------------
 2 files changed, 12 insertions(+), 41 deletions(-)

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
