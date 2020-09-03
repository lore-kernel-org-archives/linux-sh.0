From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 03 Sep 2020 10:14:43 +0000
Subject: Re: [PATCH] sh: fix syscall tracing
Message-Id: <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------312FB7917C728875E74D6DAF"
List-Id: <linux-sh.vger.kernel.org>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
In-Reply-To: <20200903054803.GX3265@brightrain.aerifal.cx>
To: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

This is a multi-part message in MIME format.
--------------312FB7917C728875E74D6DAF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Rich!

On 9/3/20 7:48 AM, Rich Felker wrote:
> Addition of SECCOMP_FILTER exposed a longstanding bug in
> do_syscall_trace_enter, whereby r0 (the 5th argument register) was
> mistakenly used where r3 (syscall_nr) was intended. By overwriting r0
> rather than r3 with -1 when attempting to block a syscall, the
> existing code would instead have caused the syscall to execute with an
> argument clobbered.
> 
> Commit 0bb605c2c7f2b4b3 then introduced skipping of the syscall when
> do_syscall_trace_enter returns -1, so that the return value set by
> seccomp filters would not be clobbered by -ENOSYS. This eliminated the
> clobbering of the 5th argument register, but instead caused syscalls
> made with a 5th argument of -1 to be misinterpreted as a request by
> do_syscall_trace_enter to suppress the syscall.
> 
> Fixes: 0bb605c2c7f2b4b3 ("sh: Add SECCOMP_FILTER")
> Fixes: ab99c733ae73cce3 ("sh: Make syscall tracer use tracehook notifiers, add TIF_NOTIFY_RESUME.")
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  arch/sh/kernel/entry-common.S |  1 -
>  arch/sh/kernel/ptrace_32.c    | 15 +++++----------
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
> index ad963104d22d..91ab2607a1ff 100644
> --- a/arch/sh/kernel/entry-common.S
> +++ b/arch/sh/kernel/entry-common.S
> @@ -370,7 +370,6 @@ syscall_trace_entry:
>  	 nop
>  	cmp/eq	#-1, r0
>  	bt	syscall_exit
> -	mov.l	r0, @(OFF_R0,r15)	! Save return value
>  	!			Reload R0-R4 from kernel stack, where the
>  	!   	    	    	parent may have modified them using
>  	!   	    	    	ptrace(POKEUSR).  (Note that R0-R2 are
> diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> index b05bf92f9c32..5281685f6ad1 100644
> --- a/arch/sh/kernel/ptrace_32.c
> +++ b/arch/sh/kernel/ptrace_32.c
> @@ -455,16 +455,11 @@ long arch_ptrace(struct task_struct *child, long request,
>  
>  asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
>  {
> -	long ret = 0;
> -
>  	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> -	    tracehook_report_syscall_entry(regs))
> -		/*
> -		 * Tracing decided this syscall should not happen.
> -		 * We'll return a bogus call number to get an ENOSYS
> -		 * error, but leave the original number in regs->regs[0].
> -		 */
> -		ret = -1L;
> +	    tracehook_report_syscall_entry(regs)) {
> +		regs->regs[0] = -ENOSYS;
> +		return -1;
> +	}
>  
>  	if (secure_computing() == -1)
>  		return -1;
> @@ -475,7 +470,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
>  	audit_syscall_entry(regs->regs[3], regs->regs[4], regs->regs[5],
>  			    regs->regs[6], regs->regs[7]);
>  
> -	return ret ?: regs->regs[0];
> +	return 0;
>  }
>  
>  asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
> 

I can confirm that this patch fixes both strace for me and does not break libseccomp,
I have run the libseccomp testsuite with my patch for SuperH support applied on top
of a rebased libseccomp with the 32-bit fixes. Attaching the testsuite log.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--------------312FB7917C728875E74D6DAF
Content-Type: text/x-log; charset=UTF-8;
 name="seccomp-live-test.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="seccomp-live-test.log"

=============== Thu 03 Sep 2020 11:57:57 AM CEST ===============
Regression Test Report ("regression -T live")
 batch name: 01-sim-allow
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 02-sim-basic
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 03-sim-basic_chains
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 04-sim-multilevel_chains
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 05-sim-long_jumps
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 06-sim-actions
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 07-sim-db_bug_looping
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 08-sim-subtree_checks
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 09-sim-syscall_priority_pre
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 10-sim-syscall_priority_post
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 11-basic-basic_errors
 test mode:  c
 test type:  basic
 batch name: 12-sim-basic_masked_ops
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 13-basic-attrs
 test mode:  c
 test type:  basic
 batch name: 14-sim-reset
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 15-basic-resolver
 test mode:  c
 test type:  basic
 batch name: 16-sim-arch_basic
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 17-sim-arch_merge
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 18-sim-basic_allowlist
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 19-sim-missing_syscalls
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 20-live-basic_die
 test mode:  c
 test type:  live
Test 20-live-basic_die%%001-00001 result:   SUCCESS
Test 20-live-basic_die%%002-00001 result:   SUCCESS
Test 20-live-basic_die%%003-00001 result:   SUCCESS
 batch name: 21-live-basic_allow
 test mode:  c
 test type:  live
Test 21-live-basic_allow%%001-00001 result:   SUCCESS
 batch name: 22-sim-basic_chains_array
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 23-sim-arch_all_le_basic
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 24-live-arg_allow
 test mode:  c
 test type:  live
Test 24-live-arg_allow%%001-00001 result:   SUCCESS
 batch name: 25-sim-multilevel_chains_adv
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 26-sim-arch_all_be_basic
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 27-sim-bpf_blk_state
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 28-sim-arch_x86
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 29-sim-pseudo_syscall
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 30-sim-socket_syscalls
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 31-basic-version_check
 test mode:  c
 test type:  basic
 batch name: 32-live-tsync_allow
 test mode:  c
 test type:  live
Test 32-live-tsync_allow%%001-00001 result:   SUCCESS
 batch name: 33-sim-socket_syscalls_be
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 34-sim-basic_denylist
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 35-sim-negative_one
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 36-sim-ipc_syscalls
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 37-sim-ipc_syscalls_be
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 38-basic-pfc_coverage
 test mode:  c
 test type:  basic
 batch name: 39-basic-api_level
 test mode:  c
 test type:  basic
 batch name: 40-sim-log
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 41-sim-syscall_priority_arch
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 42-sim-adv_chains
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 43-sim-a2_order
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 44-live-a2_order
 test mode:  c
 test type:  live
Test 44-live-a2_order%%001-00001 result:   SUCCESS
 batch name: 45-sim-chain_code_coverage
 test mode:  c
 test type:  bpf-sim
 batch name: 46-sim-kill_process
 test mode:  c
 test type:  bpf-sim
 batch name: 47-live-kill_process
 test mode:  c
 test type:  live
Test 47-live-kill_process%%001-00001 result:   SUCCESS
 batch name: 48-sim-32b_args
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-sim-fuzz
 test mode:  c
 test type:  bpf-valgrind
 batch name: 49-sim-64b_comparisons
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 50-sim-hash_collision
 test mode:  c
 test type:  bpf-sim
 batch name: 51-live-user_notification
 test mode:  c
 test type:  live
Test 51-live-user_notification%%001-00001 result:   SUCCESS
 batch name: 52-basic-load
 test mode:  c
 test type:  basic
 batch name: 53-sim-binary_tree
 test mode:  c
 test type:  bpf-sim
 test mode:  c
 test type:  bpf-valgrind
 batch name: 54-live-binary_tree
 test mode:  c
 test type:  live
Test 54-live-binary_tree%%001-00001 result:   SUCCESS
 batch name: 55-basic-pfc_binary_tree
 test mode:  c
 test type:  basic
 batch name: 56-basic-iterate_syscalls
 test mode:  c
 test type:  basic
 batch name: 57-basic-rawsysrc
 test mode:  c
 test type:  basic
 batch name: 58-live-tsync_notify
 test mode:  c
 test type:  live
Test 58-live-tsync_notify%%001-00001 result:   SUCCESS
Regression Test Summary
 tests run: 11
 tests skipped: 0
 tests passed: 11
 tests failed: 0
 tests errored: 0
============================================================

--------------312FB7917C728875E74D6DAF--
