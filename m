From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Jan 2008 01:57:34 +0000
Subject: Re: Build error with -rc7/.25 queue
Message-Id: <20080111015734.GB29171@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1199993564.6349.4.camel@localhost.localdomain>
In-Reply-To: <1199993564.6349.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 10, 2008 at 07:32:44PM +0000, Adrian McMenamin wrote:
> Building with the 2.6.25 queue on top of 2.6.24-rc7-git(latest) I get
> this:
> 
The current queue is against 2.6.24-rc7, so I'm not sure what you're
using.

>  SYSCALL arch/sh/kernel/vsyscall/vsyscall-trapa.so
> /home/adrian/dreamy-linux/buildroot/build_sh4/staging_dir/usr/bin/sh4-linux-uclibc-ld: error in arch/sh/kernel/vsyscall/vsyscall-trapa.o(.eh_frame); no .eh_frame_hdr table will be created.
> 
That's about the quality of error message I'd expect from binutils.

Please provide information on your toolchain versions, or if it's
something particularly exotic, a pointer to a tarball would be helpful,
too. I assume you simply have a new version of binutils that isn't happy
with something in .eh_frame, though in that case, the kernel version
shouldn't make any difference, as nothing has changed in the SH VDSO
implementation in ages.
