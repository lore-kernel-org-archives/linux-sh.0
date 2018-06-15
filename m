From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 15 Jun 2018 16:04:45 +0000
Subject: Re: [PATCH] arch/sh: use slow path for get_user_pages_fast() on SMP
Message-Id: <474bbdcc-d78f-faa0-b2c3-3650cc870b36@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180615155237.8166-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180615155237.8166-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello!

On 06/15/2018 06:52 PM, Thomas Petazzoni wrote:

> The fast path of get_user_pages_fast() disables IRQs and then does:
> 
>  - gup_pud_range()
>    - gup_pmd_range()
>      - gup_pte_range()
>        - flush_dcache_page()
> 
> However, flush_dcache_page() makes a smp_call_function(), and using
> smp_call_function() when IRQs are disabled is not allowed.
> 
> In order to work around this problem, this commit prevents the fast
> path from get_user_pages_fast() from being used on SMP, and directly
       ^^^^ of?
   Else it sounds a bit tautological...

> uses the slow path, which doesn't disable interrupts.
> 
> Fixes the following warning when get_futex_key() is called:
> 
> WARNING: CPU: 1 PID: 410 at kernel/smp.c:416 smp_call_function_many+0x1fc/0x2ac
> Modules linked in:
> 
> CPU: 1 PID: 410 Comm: wdc-pfmu-test Tainted: G           O    4.13.0-00035-g0d3023c733a0-dirty #363
> task: 97d9a120 task.stack: 97d2e000
> PC is at smp_call_function_many+0x1fc/0x2ac
> PR is at smp_call_function_many+0x1e2/0x2ac
> PC  : 88071fd4 SP  : 97d2fcd4 SR  : 400080f1
> TEA : c06d6840
> R0  : 000000f0 R1  : 00000002 R2  : 00000000 R3  : 8849c89c
> R4  : 886d62c4 R5  : 886d62c4 R6  : 886db928 R7  : 884a9dec
> R8  : 00000000 R9  : ffffffff R10 : 8844667c R11 : 29ee9000
> R12 : 8844667c R13 : 00000001 R14 : 97d2fcd4
> MACH: 000177e7 MACL: 0000018c GBR : 295742d0 PR  : 88071fba
> 
> Call trace:
>  [<8800fe2c>] sh4_flush_dcache_page+0x0/0xa4
>  [<880720a2>] smp_call_function+0x1e/0x50
>  [<8800fe2c>] sh4_flush_dcache_page+0x0/0xa4
>  [<8800ecc0>] flush_dcache_page+0x34/0x74
>  [<88010d1c>] gup_pte_range+0xd0/0x140
>  [<88010e04>] gup_pmd_range+0x78/0xa8
>  [<88010c4c>] gup_pte_range+0x0/0x140
>  [<88011006>] get_user_pages_fast+0xda/0x130
>  [<8806f376>] get_futex_key+0x72/0x3a0
>  [<8806f6a4>] futex_wait_setup+0x0/0x10c
>  [<88055a08>] __rcu_read_unlock+0x0/0x54
>  [<880559c8>] __rcu_read_lock+0x0/0x1c
>  [<88010f2c>] get_user_pages_fast+0x0/0x130
>  [<8806f6de>] futex_wait_setup+0x3a/0x10c
>  [<8806f6a4>] futex_wait_setup+0x0/0x10c
>  [<8806f852>] futex_wait+0xa2/0x1b8
>  [<8806f6a4>] futex_wait_setup+0x0/0x10c
>  [<88071c00>] smp_call_function_single+0xac/0x108
>  [<8800e908>] cache_noop+0x0/0xc
>  [<8800e908>] cache_noop+0x0/0xc
>  [<88071018>] do_futex+0x108/0x8f8
>  [<880bdfe4>] finish_fault+0x38/0x70
>  [<880bdff2>] finish_fault+0x46/0x70
>  [<880bf212>] handle_mm_fault+0x2f6/0x954
>  [<880bf21a>] handle_mm_fault+0x2fe/0x954
>  [<88030e64>] resched_curr+0x54/0x6c
>  [<8832be9e>] _raw_spin_lock_irqsave+0xa/0x18
>  [<880718dc>] SyS_futex+0xd4/0x124
>  [<8801488e>] SyS_clone+0x16/0x24
>  [<8800727e>] syscall_call+0x18/0x1e
>  [<88071808>] SyS_futex+0x0/0x124
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
[...]

MBR, Sergei

