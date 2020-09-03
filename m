From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 03 Sep 2020 08:13:43 +0000
Subject: Re: [PATCH] sh: fix syscall tracing
Message-Id: <65bf8a3b-8213-0a67-1156-043bca545ada@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
In-Reply-To: <20200903054803.GX3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

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

I'm testing this patch now with a rebased kernel and a rebased libseccomp with my
patch for SuperH support on top.

I'll report back later.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
