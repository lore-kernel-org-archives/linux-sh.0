From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 27 Feb 2016 14:20:46 +0000
Subject: Re: sh7724 regression: commit 8222dbe21e79338de92d5e1956cd1e3994cc9f93
Message-Id: <CAMuHMdWR0RZhGrX4qW+fHwOYxAXffNinUdhrL=SZsMn5BUKoeA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CC linux-sh

On Sat, Feb 27, 2016 at 2:50 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> Hi all,
>
> The last time I used my ecovec sh7724 board was with kernel 4.1 and that worked fine.
>
> But I needed to do some more testing with the mainline kernel and this generated this
> error:
>
> ------------[ cut here ]------------
> kernel BUG at arch/sh/mm/kmap.c:47!
> Kernel BUG: 003e [#1]
>
> CPU: 0 PID: 553 Comm: systemd Not tainted 4.5.0-rc5-renesas #49
> task: 968ac4a0 ti: 9568e000 task.ti: 9568e000
> PC is at kmap_coherent+0x52/0xe0
> PR is at kmap_coherent+0x28/0xe0
> PC  : 88013d52 SP  : 9568feb0 SR  : 40008000 TEA : 2957677f
> R0  : dffff000 R1  : 88664ff8 R2  : 00003810 R3  : 134a750e
> R4  : 885a68c4 R5  : 00000000 R6  : 134ae50c R7  : 00003f10
> R8  : 887ce5c0 R9  : 0007bfff R10 : 00001000 R11 : 00001040
> R12 : 00000001 R13 : 9569230c R14 : 00000000
> MACH: 00000002 MACL: 00000000 GBR : 2957bd50 PR  : 88013d28
>
> Call trace:
>  [<88011806>] __flush_anon_page+0xc6/0x100
>  [<880ae268>] __get_user_pages.part.31+0x348/0x3e0
>  [<880d58d6>] copy_strings+0xd6/0x2c0
>  [<880d619e>] kernel_read+0x1e/0x40
>  [<880d5db2>] copy_strings_kernel+0x12/0x20
>  [<880d5b40>] count.constprop.40+0x0/0xe0
>  [<880d75cc>] do_execveat_common+0x46c/0x680
>  [<880d77f8>] do_execve+0x18/0x40
>  [<880d7a80>] SyS_execve+0x0/0x40
>  [<8800927e>] syscall_call+0x18/0x1e
>
> Code:
>   88013d4c:  tst       r2, r2
>   88013d4e:  bt.s      88013da0
>   88013d50:  mov.l     @r1, r3
> ->88013d52:  trapa     #62
>   88013d54:  mov.l     88013dd8 <kmap_coherent+0xd8/0xe0>, r2  ! 8864e790 <0x8864e790>
>   88013d56:  mov       r8, r4
>   88013d58:  mov.l     @r2, r2
>   88013d5a:  sub       r2, r4
>   88013d5c:  mov       #-5, r2
>
> Process: systemd (pid: 553, stack limit = 9568e001)
> Stack: (0x9568feb0 to 0x95690000)
> fea0:                                     88011806 887ce5c0 934ae000 00001040
> fec0: 880ae268 7bffffc2 887ce5c0 968ac4a0 95620020 00000001 00000010 00000000
> fee0: 880d58d6 00020000 00000000 968b9010 fffff000 7bffffc2 9697dd7c 9697dd00
> ff00: 00000017 9568ff34 00000000 00000000 0000003a 880d619e 9697ddb0 00000000
> ff20: 00000000 00000ffc 00000000 00000000 00000080 887ce5c0 880d5db2 00000080
> ff40: 9697dd7c 9697dd00 7b90feec 7b90fb5c 880d5b40 80000000 880d75cc 968b9000
> ff60: 9569230c 95620058 00000000 00000000 880d77f8 7b90fb5c 52be8914 296dac54
> ff80: 00000000 00000071 00000100 880d7a80 00000000 8800927e 000000ec fffffec2
> ffa0: fffffff4 000000ec fffffec2 fffffff4 0000000b 52bf2438 7b90fb5c 7b90feec
> ffc0: 2957b940 52be9e44 7b90fb34 52bf2438 52be6034 296dac54 52be8914 7b90fb5c
> ffe0: 7b90fb2c 29636be4 29636d1e 00008001 2957bd50 0a136394 00000040 0000004c
> ------------[ cut here ]------------
>
> Always at the same place (kmap.c line 47), but with different stack traces,
> e.g.:
>
> Call trace:
>  [<880114b2>] copy_user_highpage+0x152/0x260
>  [<880af48a>] wp_page_copy.isra.102+0x6a/0x600
>  [<88037c20>] preempt_count_sub+0x0/0xe0
>  [<880b032e>] do_wp_page.isra.104+0x14e/0x9c0
>  [<88037c20>] preempt_count_sub+0x0/0xe0
>  [<884e864c>] __down_read+0xcc/0x140
>  [<880b30d0>] handle_mm_fault+0x8b0/0xfe0
>  [<88003820>] arch_local_irq_restore+0x0/0x40
>  [<880090ec>] ret_from_exception+0x0/0x8
>  [<88043abc>] __up_read+0x1c/0xa0
>  [<884e85a0>] __down_read+0x20/0x140
>  [<884e864c>] __down_read+0xcc/0x140
>  [<88013586>] do_page_fault+0xe6/0x300
>  [<880090ec>] ret_from_exception+0x0/0x8
>  [<88009010>] tlb_protection_violation_store+0x0/0x4
>  [<880090ec>] ret_from_exception+0x0/0x8
>
> I noticed that 4.1 was ok and v4.2 wasn't, so I did a git bisect and ended up with
> commit 8222dbe21e79338de92d5e1956cd1e3994cc9f93 (sched/preempt, mm/fault: Decouple
> preemption from the page fault logic) as the culprit.
>
> It makes this change to include/linux/uaccess.h:
>
>  static inline void pagefault_disable(void)
>  {
> -       preempt_count_inc();
>         pagefault_disabled_inc();
>         /*
>          * make sure to have issued the store before a pagefault
> @@ -47,11 +40,6 @@ static inline void pagefault_enable(void)
>          */
>         barrier();
>         pagefault_disabled_dec();
> -#ifndef CONFIG_PREEMPT
> -       preempt_count_dec();
> -#else
> -       preempt_enable();
> -#endif
>  }
>
> I'm sure something was missed in arch/sh that caused this to go wrong.
> But that's where my expertise ends.
>
> I can easily reproduce it on my board, so if someone has a patch for me
> to test, then that's no problem.
>
> For now I am just reverting this for the time being so that I can continue
> testing some v4l2 drivers.
>
> Regards,
>
>         Hans
