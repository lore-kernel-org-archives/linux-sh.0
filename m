From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 03 Sep 2020 06:03:06 +0000
Subject: Re: [PATCH 3/4] sh: Add SECCOMP_FILTER
Message-Id: <54a4db1a-1d41-7fa2-cb74-460256d3be0d@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20200722231322.419642-3-kernel@mkarcher.dialup.fu-berlin.de>
 <20200828155024.GX3265@brightrain.aerifal.cx>
 <20200828163057.GY3265@brightrain.aerifal.cx>
 <82b625c2-23cb-69a4-7495-39427430c306@physik.fu-berlin.de>
 <20200828170259.GZ3265@brightrain.aerifal.cx>
 <20200829004939.GB3265@brightrain.aerifal.cx>
 <b0e38ede-3860-eb83-615e-ad77f619a3a6@physik.fu-berlin.de>
 <20200903035603.GV3265@brightrain.aerifal.cx>
In-Reply-To: <20200903035603.GV3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

Hi Richi!

On 9/3/20 5:56 AM, Rich Felker wrote:
>> Test 51-live-user_notification%%001-00001 result:   FAILURE 51-live-user_notification 5 ALLOW rc
> 
> AFAICT, this test is buggy and cannot possibly work. It attempts to
> have SYS_getpid return a 64-bit value and check that the returned
> value matches. On 32-bit archs this will be truncated to 32 bits, but
> the comparison in the caller still compares against the full 64-bit
> value. I have no idea how this seemed to work before.

You're actually right, I forgot about that. Michael discovered this bug as well
and it was consequently fixed:

> https://github.com/seccomp/libseccomp/commit/bee43d3e884788569860a384e6a38357785a3995

>> Test 58-live-tsync_notify%%001-00001 result:   FAILURE 58-live-tsync_notify 6 ALLOW rc
> 
> This is similar to 51.
> 
> I think the commonality of all the failures is that they deal with
> return values set by seccomp filters for blocked syscalls, which are
> getting clobbered by ENOSYS from the failed syscall here. So I do need
> to keep the code path that jumps over the actual syscall if
> do_syscall_trace_enter returns -1, but that means
> do_syscall_trace_enter must now be responsible for setting the return
> value in non-seccomp failure paths.

Same here:

> https://github.com/seccomp/libseccomp/commit/f0686d9de911e7ffcdc7364566c1d146e44657c2

Not sure about the other two tests. I can re-base and re-test.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
