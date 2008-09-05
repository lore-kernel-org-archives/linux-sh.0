From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Fri, 05 Sep 2008 05:45:34 +0000
Subject: Re: [PATCH] resume_kernel fix for kernel oops built with CONFIG_BKL_PREEMPT=y
Message-Id: <48C0C77E.3050401@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48BFD6F5.5030508@st.com>
In-Reply-To: <48BFD6F5.5030508@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Thu, Sep 04, 2008 at 02:39:17PM +0200, Carmelo AMOROSO wrote:
>> Hi All,
>> attached patch solves a kernel OOPS discovered while running LTP 
>> testsuite (doio test) with kernel 2.6.23.y (rootf on hd).
>> Attached for your reference the output of the test and the kernel oops.
>>
>> The problems is within the SH implementation of resume_kernel code,
>> that implements in assembly the bulk of preempt_schedule_irq function 
>> without taking care of the extra code needed to handle the BKL preemptible.
>>
>> The patch basically consists of removing this asm code and calling the 
>> common C implementation (see kernel/sched.c) as other archs do.
>>
> I don't recall that C implementation existing when I wrote that code back
> in the 2.4 days, so that's probably why the semantics are a bit
> different. We certainly should be doing what the other arches are doing
> though, so your patch looks good and I'll apply it. The irqflags tracing
> will probably need a bit more thinking there, but I'll look at that
> tomorrow.
> 

Hi Paul,
well irqflags tracing is managed internally by local_irq_[enable,diable]
as defined in include/linux/irqflags.h.

#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT

#include <asm/irqflags.h>

#define local_irq_enable() \
      do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
#define local_irq_disable() \
      do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)

.........

#else /* !CONFIG_TRACE_IRQFLAGS_SUPPORT */
/*
  * The local_irq_*() APIs are equal to the raw_local_irq*()
  * if !TRACE_IRQFLAGS.
  */
# define raw_local_irq_disable()    local_irq_disable()
# define raw_local_irq_enable()     local_irq_enable()
......
#endif

Indeed, looking better, the macros within the #else path
are erroneously exchanged... we should have

# define local_irq_disable() raw_local_irq_disable()
# define local_irq_enable() raw_local_irq_enable()

These should be fixed on Linus' main stream.

> I'll add this in to the 2.6.27 queue, thanks.
> 
That's fine.

Cheers,
Carmelo


