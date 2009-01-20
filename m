From: Kaz Kojima <kkojima@rr.iij4u.or.jp>
Date: Tue, 20 Jan 2009 04:43:50 +0000
Subject: Re: ERESTART* seen by userland
Message-Id: <20090120.134350.89916914.kkojima@rr.iij4u.or.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20090117.084015.142054869.kkojima@rr.iij4u.or.jp>
In-Reply-To: <20090117.084015.142054869.kkojima@rr.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt <lethal@linux-sh.org> wrote:
>> It seems that some syscalls return with ERESTART* errno when
>> they should return EINTR in the recent SH kernels.
>> Has anybody experienced this?
>> 
> I haven't hit this personally, but the only logical explanation I can
> think of for this is the T-bit setting in the syscall restart code. I
> suppose I will have to find another bit to use. Can you confirm if
> getting rid of regs->sr T-bit manipulation makes this go away?

I've confirmed that my testcases are fixed with removing the if line
just before handle_syscall_restart call in do_signal:

--- GIT/linux-2.6/arch/sh/kernel/signal_32.c	2008-12-30 09:31:12.000000000 +0900
+++ linux-2.6.29-rc1/arch/sh/kernel/signal_32.c	2009-01-20 12:48:40.000000000 +0900
@@ -589,8 +589,7 @@ static void do_signal(struct pt_regs *re
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
-		if (regs->sr & 1)
-			handle_syscall_restart(save_r0, regs, &ka.sa);
+		handle_syscall_restart(save_r0, regs, &ka.sa);
 
 		/* Whee!  Actually deliver the signal.  */
 		if (handle_signal(signr, &ka, &info, oldset,

Regards,
	kaz
