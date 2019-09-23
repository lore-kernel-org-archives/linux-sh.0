From: Valentin Schneider <valentin.schneider@arm.com>
Date: Mon, 23 Sep 2019 14:36:11 +0000
Subject: [PATCH v2 0/9] entry: preempt_schedule_irq() callers scrub
Message-Id: <20190923143620.29334-1-valentin.schneider@arm.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-riscv@lists.infradead.org

I've left this to ~rot~ age out in the sun for a while, apologies for that.
One early new-year resolution for me is to maintain a shorter resend
timeout on this.


This is the continuation of [1] where I'm hunting down
preempt_schedule_irq() callers because of [2]. I've looked at users of
preempt_schedule_irq(), and made sure they didn't have one of those useless
loops. The list of offenders is:

$ grep -r -I "preempt_schedule_irq" arch/ | cut -d/ -f2 | sort | uniq

  arc
  arm
  arm64
  c6x
  csky
  h8300
  ia64
  m68k
  microblaze
  mips
  nds32
  nios2
  parisc
  powerpc
  riscv
  s390
  sh
  sparc
  x86
  xtensa

Regarding that loop, archs seem to fall in 3 categories:
A) Those that don't have the loop
B) Those that have a small need_resched() loop around the
   preempt_schedule_irq() callsite
C) Those that branch to some more generic code further up the entry code
   and eventually branch back to preempt_schedule_irq()

arc, m68k, nios2 fall in A)
sparc, ia64, s390 fall in C)
all the others fall in B)

I've written patches for B). As of 5.3 mainline contains those for:
- arm64
- mips
- x86
- powerpc
- nds32

I've also got acks/reviews but haven't seen in any tree yet for:
- c6x
- csky
- riscv
- xtensa

The remaining ones for which I haven't had any reply at all are
- h8300
- microblaze
- sh
- sh64

Build-tested:
- h8300
- c6x
- microblaze
- riscv

No major change since v1 other than rebasing on top of 5.4 and collecting
Reviewed-By / Acked-By.

Thanks,
Valentin

[1]: https://lore.kernel.org/lkml/20190131182339.9835-1-valentin.schneider@arm.com/
[2]: https://lore.kernel.org/lkml/cc989920-a13b-d53b-db83-1584a7f53edc@arm.com/

Valentin Schneider (9):
  sched/core: Fix preempt_schedule() interrupt return comment
  c6x: entry: Remove unneeded need_resched() loop
  csky: entry: Remove unneeded need_resched() loop
  h8300: entry: Remove unneeded need_resched() loop
  microblaze: entry: Remove unneeded need_resched() loop
  RISC-V: entry: Remove unneeded need_resched() loop
  sh: entry: Remove unneeded need_resched() loop
  sh64: entry: Remove unneeded need_resched() loop
  xtensa: entry: Remove unneeded need_resched() loop

 arch/c6x/kernel/entry.S        | 3 +--
 arch/csky/kernel/entry.S       | 4 ----
 arch/h8300/kernel/entry.S      | 3 +--
 arch/microblaze/kernel/entry.S | 5 -----
 arch/riscv/kernel/entry.S      | 3 +--
 arch/sh/kernel/cpu/sh5/entry.S | 5 +----
 arch/sh/kernel/entry-common.S  | 4 +---
 arch/xtensa/kernel/entry.S     | 2 +-
 kernel/sched/core.c            | 7 +++----
 9 files changed, 9 insertions(+), 27 deletions(-)

--
2.22.0
