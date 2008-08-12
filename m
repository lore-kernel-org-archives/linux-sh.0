From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 12 Aug 2008 02:48:15 +0000
Subject: Re: can't single-step on gdb
Message-Id: <20080812024815.GA31588@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080812.100434.68561126.saito@densan.co.jp>
In-Reply-To: <20080812.100434.68561126.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Tue, Aug 12, 2008 at 11:22:10AM +0900, Paul Mundt wrote:
> On Tue, Aug 12, 2008 at 10:04:34AM +0900, Hideo Saito wrote:
> > Hi Paul,
> >=20
> > I have a problem as to tracing a program using gdb on my
> > platform(SH7780). I can single-step a program on gdb usually, however,
> > in some conditions, I can not single-step the program because gdb does
> > not change the PC without any failed assertions.
> >=20
> > It seems that do_syscall_trace() sets SIGTRAP in exit_code in the task
> > structure before the traced program executes the instruction. I think
> > that do_syscall_trace should ignore single-step because the schedule of
> > the traced process might be delayed.
> >=20
> Yes, there were a couple of other single-step related bugs that showed up
> as well. All of those fixes went in to 2.6.27-rc2, so you may want to
> take a look at that. Please see if you have any outstanding issues with
> current git.

To elaborate on this, the single-step rework falls in to a couple of
categories:

	- general bugs
	- hooking in to the general ptrace API more consistently
	- tracehook conversion

the first two you can easily backport in to whatever kernel you happen to
be using, while the tracehook bits are obviously only going to be
relevant for recent kernels.

Given that, the commits you want to look at are probably:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=CEc3fd3e2a7cacf37e2bd6d9fa915337245cc563;hp=DAf423db3b6afd90ecdd77=
6dbc32c0b57cc78edb
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=C459dbf294b4a3d70490a468a7ca3907fb2c2f57
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=AB99c733ae73cce31f2a2434f7099564e5a73d95
