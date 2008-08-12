From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 12 Aug 2008 02:22:10 +0000
Subject: Re: can't single-step on gdb
Message-Id: <20080812022210.GA9162@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080812.100434.68561126.saito@densan.co.jp>
In-Reply-To: <20080812.100434.68561126.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 12, 2008 at 10:04:34AM +0900, Hideo Saito wrote:
> Hi Paul,
> 
> I have a problem as to tracing a program using gdb on my
> platform(SH7780). I can single-step a program on gdb usually, however,
> in some conditions, I can not single-step the program because gdb does
> not change the PC without any failed assertions.
> 
> It seems that do_syscall_trace() sets SIGTRAP in exit_code in the task
> structure before the traced program executes the instruction. I think
> that do_syscall_trace should ignore single-step because the schedule of
> the traced process might be delayed.
> 
Yes, there were a couple of other single-step related bugs that showed up
as well. All of those fixes went in to 2.6.27-rc2, so you may want to
take a look at that. Please see if you have any outstanding issues with
current git.
