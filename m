From: Chen Gang <gang.chen@asianux.com>
Date: Thu, 01 Aug 2013 02:52:36 +0000
Subject: [Suggestion] sh: about the warnings for "overflow in branch to syscall_exit_work"
Message-Id: <51F9CD74.1000404@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Maintainers:

I find some warnings for sh, can they cause real world issue ?

It is also found by Geert Uytterhoeven, please ref:
http://lkml.indiana.edu/hypermail/linux/kernel/1301.3/02181.html

The related warnings (with allmodconfig):

    AS      arch/sh/kernel/cpu/sh2/entry.o
  arch/sh/kernel/cpu/sh2/../../entry-common.S: Assembler messages:
  arch/sh/kernel/cpu/sh2/../../entry-common.S:89: Warning: overflow in branch to __restore_all; converted into longer instruction sequence
  arch/sh/kernel/cpu/sh2/../../entry-common.S:210: Warning: overflow in branch to syscall_call; converted into longer instruction sequence
  arch/sh/kernel/cpu/sh2/../../entry-common.S:349: Warning: overflow in branch to syscall_trace_entry; converted into longer instruction sequence
  arch/sh/kernel/cpu/sh2/../../entry-common.S:351: Warning: overflow in branch to syscall_trace_entry; converted into longer instruction sequence
  arch/sh/kernel/cpu/sh2/../../entry-common.S:375: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence
  arch/sh/kernel/cpu/sh2/../../entry-common.S:378: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence

For me, I guess it can cause real world issue (and it seems a "long
time existence" issue)

Welcome any members suggestions or completions.


Thanks.
--
Chen Gang.
