From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Date: Fri, 05 Sep 2008 11:35:25 +0000
Subject: Re: [PATCH] fix build failure when compiling without TRACE_IRQFLAGS_SUPPORT
Message-Id: <48C1197D.8000608@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48C0D2A4.90208@st.com>
In-Reply-To: <48C0D2A4.90208@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Fri, Sep 05, 2008 at 08:33:08AM +0200, Giuseppe CAVALLARO wrote:
>   
>> Hi All,
>> playing with the kernel configuration we noticed that the
>> kernel doesn't build if TRACE_IRQFLAGS_SUPPORT is
>> forced off. So this patch just fixes it.
>>
>> Anyway, we are wondering why it's not possible to disable
>> this option from Kconfig.
>> Reading the Documentation/irqflags-tracing.txt, this option is
>> "needed for CONFIG_PROVE_SPIN_LOCKING and
>> CONFIG_PROVE_RW_LOCKING to be offered by the generic
>> lock debugging code."
>> But we cannot find any references to PROVE_RW_LOCKING etc.
>> May be removed?
>>
>>     
> Have you noticed this problem on non-sh platforms also? If so, you should
> resend this patch to linux-kernel with the linux-sh list CCed.
>   
we'll send the patch soon.
> The config dependencies are a bit of a mess, but it's all quite
> functional. CONFIG_PROVE_RW_LOCKING is bogus though, it's actually
> CONFIG_PROVE_LOCKING. Anyways, take a look at lib/Kconfig.debug and it
> should all be pretty obvious.
>
> TRACE_IRQFLAGS_SUPPORT is used by quite a lot of things, lockdep, lock
> stat, preempt debug, etc. You really do _not_ want to disable this
> option, especially as it is a _support_ option, not a functional one.
>
> CONFIG_TRACE_IRQFLAGS itself is what introduces extra overhead, and while
> this depends on TRACE_IRQFLAGS_SUPPORT, it also has a dependency on
> DEBUG_KERNEL. Thus, you will never see any of this stuff with kernel
> debugging disabled. Most of this stuff is hidden away from the user in
> Kconfig for a good reason :-)
Sure, all sounds clear now.
Thanks!
