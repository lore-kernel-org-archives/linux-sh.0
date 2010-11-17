From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 17 Nov 2010 09:49:39 +0000
Subject: Re: [PATCH (sh-2.6)] sh: Use GCC __builtin_prefetch() to implement prefetch (V2)
Message-Id: <20101117094938.GA12227@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
In-Reply-To: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 17, 2010 at 10:27:19AM +0100, Giuseppe CAVALLARO wrote:
> GCC's __builtin_prefetch() was introduced a long time ago, all
> supported GCC versions have it.
> So this patch removes the ARCH_HAS_PREFETCH and ARCH_HAS_PREFETCHW
> macros, defined for SH2A and SH4 that will fall back on
> __builtin_prefetch() through the generic code:
>   include/linux/prefetch.h
> 
> The builtin usage should be more efficient that an __asm__
> because less barriers, and because the compiler doesn't see the
> inst as a "black box" allowing better code generation.
> Many thanks to Christian Bruel <christain.bruel@st.com> for his
> support on evaluate the impact of the gcc built-in on SH4 arch.
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Stuart Menefy <stuart.menefy@st.com>

Actually now that I think about it, it's not that simple. If
ARCH_HAS_PREFETCH goes away then we lose prefetch_range() (which
admittely isn't called anywhere that matters, but it may in the future).

If gcc is smart enough to optimize out __builtin_prefetch() for the cases
where nothing has to be done, then the ARCH_HAS_PREFETCH define could
simply be killed and each arch would be responsible for establishing the
prefetch stride (this seems to vary between the size of an L1 or L2
cacheline depending on the platform). This is a different change though,
and is something you would have to bring up on linux-arch and
linux-kernel as a separate patch.

Perhaps the easiest solution for now is just to stick with your first
version, which at least retains the stride data and prefetch_range()
behaviour. If you wish to sort out the PREFETCH_STRIDE/ARCH_HAS_PREFETCH
and prefetch_range() mess separately then of course that's something we
can deal with incrementally, too.
