From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Aug 2008 05:37:33 +0000
Subject: Re: [PATCH] add addrespace definition for sh2a.
Message-Id: <20080804053733.GA11682@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48969386.4050705@renesas.com>
In-Reply-To: <48969386.4050705@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 04, 2008 at 02:28:38PM +0900, Takashi Yoshii wrote:
> Newfile: arch/sh/include/cpu-sh2a/cpu/addrspace.h
> 
> This file seems had be removed to use fallback (cpu-common/cpu/addrspace.h),
> but, I'd like to add sh2a specific file here, because
> 1. the values defined there are not suitable for sh2a.
> 2. I don't think there is "common" definition for these values.
> 
> Values are chosen by consideration of followings...
> P1 is 0. perhaps no question.
> P2 is from hardware manual, which says no-cache area starts at 20000000.
> It means that P? space size 000000.
> P3 is P2+size since asm/ptrace.h uses P3 as a end of P2. 
> P4 is P3+size since asm/fixup.h uses P4 as a end of P3.
> 
> Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>

This is a good indicator for why we should just kill off all of the
references in-tree that we can find, it's been a terrible abstraction
from the beginning. It would have been nice if more than a single family
of CPUs could have been consistent with its segmentation.

For SH-2A these look fine, so I'll check this in as it is, but I would
much rather see patches that get rid of more of these references, rather
than adding more ;-)
