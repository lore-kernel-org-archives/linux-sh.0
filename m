From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 20 Feb 2010 11:47:16 +0000
Subject: Re: Unaligned kernel access for __udivsi3_i4i
Message-Id: <20100220114716.GB9774@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <5ec3d7931002191551g21c0cda9le17729529b1afd78@mail.gmail.com>
In-Reply-To: <5ec3d7931002191551g21c0cda9le17729529b1afd78@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Feb 20, 2010 at 01:24:38AM +0100, Drasko DRASKOVIC wrote:
> 
> Does that mean that we can do division by zero that goes completely
> unnoticed, unless we turn up the warnings (as kernel will fix these
> unalignments without even reporting it)?
> 

Unfortunately, yes.

> Doing: echo 1 > /proc/cpu/kernel_alignement, I saw that the kernel
> unaligned access was reported. Would that say that some module is
> trying division by zero, and not the application itself (because I did
> echo 1 > /proc/cpu/alignment at the same time, and it was not reported
> as User fault)? I am trying to isolate guilty party, so I would like
> to know if it comes from the user space or kernel module (or kernel
> itself).
> 

I would suspect that it is a kernel module that is doing the division by
zero in that case.

> Do you have some ah hoc ideas what would be best strategy to trace
> this call back?
> 

Perhaps insert a call to dump_stack() in inc_unaligned_kernel_access()?
That should give you some information about who called __udivsi3_i4i.

