From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 25 Apr 2012 03:11:14 +0000
Subject: Re: [RFC/PATCH] sh: Remove cast of atomic_t in ATOMIC_INIT macro
Message-Id: <CABMQnVJ3_HzGcW0o_D=rnDM1vEmPRp6eoPQzNvZvHdE2YoXQwQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335149312-1564-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1335149312-1564-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2012/4/23 Paul Mundt <lethal@linux-sh.org>:
> On Mon, Apr 23, 2012 at 11:48:32AM +0900, Nobuhiro Iwamatsu wrote:
>> Hi,
>>
>> By the update of the trace system (enable CONFIG_TRACING), trace build is not made in SH.
>> This is macro of trace, and ATOMIC_INIT is used, but becomes the build error with an initialization code.
>>
>> ----
>> include/trace/events/oom.h:8:13: error: initializer element is not constant
>> include/trace/events/oom.h:8:13: error: (near initialization for '__tracepoint_oom_score_adj_update')
>> include/trace/events/oom.h:8:13: error: initializer element is not constant
>> include/trace/events/oom.h:8:13: error: (near initialization for '__tracepoint_oom_score_adj_update.key')
>> ----
>>
>> This is caused by that the cast to atomic_t is performed by ATOMIC_INIT of SH.
>> However, at almost all the architecture, the cast to atomic_t is not performed by ATOMIC_INIT.
>
> And on other architectures it is. We don't specifically have any need for
> using the cast, so dropping it is probably fine, but there are other
> architectures that will either have to do the same or the tracing change
> that introduced the build failure has to be rethought.

Thanks for your comments.

The architecture casting in ATOMIC_INIT has IA64 and Alpha, Parisc
other than SH.
The others do not cast. And these architectures have same problem.

And this problem occurs by STATIC_KEY_INIT_TRUE and
STATIC_KEY_INIT_FALSE of include/linux/jump_label.h.
The architecture by which jumplabel   is defined following,

> #define STATIC_KEY_INIT_TRUE ((struct static_key) \
>     { .enabled = ATOMIC_INIT(1), .entries = (void *)1 })
> #define STATIC_KEY_INIT_FALSE ((struct static_key) \
>     { .enabled = ATOMIC_INIT(0), .entries = (void *)0 })

and does not define following.

> #define STATIC_KEY_INIT_TRUE ((struct static_key) \
>                { .enabled = ATOMIC_INIT(1) })
> #define STATIC_KEY_INIT_FALSE ((struct static_key) \
>                { .enabled = ATOMIC_INIT(0) })

Although a problem is solved by considering it following.

> #define STATIC_KEY_INIT_TRUE {ATOMIC_INIT(1)}
> #define STATIC_KEY_INIT_FALSE {ATOMIC_INIT(0)}

However, since definitions differ by the same macro name,
extendibility is lost.
I think that it is better to remove the cast from ATOMIC_INIT.

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
