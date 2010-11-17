From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Date: Wed, 17 Nov 2010 11:01:27 +0000
Subject: Re: [PATCH (sh-2.6)] sh: Use GCC __builtin_prefetch() to implement
Message-Id: <4CE3B607.7080406@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
In-Reply-To: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Paul,

On 11/17/2010 10:49 AM, Paul Mundt wrote:
>
> Actually now that I think about it, it's not that simple. If
> ARCH_HAS_PREFETCH goes away then we lose prefetch_range() (which
> admittely isn't called anywhere that matters, but it may in the future).
>
> If gcc is smart enough to optimize out __builtin_prefetch() for the cases
> where nothing has to be done, then the ARCH_HAS_PREFETCH define could
> simply be killed and each arch would be responsible for establishing the
> prefetch stride (this seems to vary between the size of an L1 or L2
> cacheline depending on the platform). This is a different change though,
> and is something you would have to bring up on linux-arch and
> linux-kernel as a separate patch.
>
> Perhaps the easiest solution for now is just to stick with your first
> version, which at least retains the stride data and prefetch_range()
> behaviour.
>
Maybe it's worth having my first patch.
We don't lose the prefetch_range behavior.
Compiler should also be smart enough to manage the pref
inst optimizing the generated code.
>
> If you wish to sort out the PREFETCH_STRIDE/ARCH_HAS_PREFETCH
> and prefetch_range() mess separately then of course that's something we
> can deal with incrementally, too.
>
I agree, we can deal with that as step further.

Regards
Peppe
