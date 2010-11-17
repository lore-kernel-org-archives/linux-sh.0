From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Date: Wed, 17 Nov 2010 08:51:37 +0000
Subject: Re: [PATCH (sh-2.6)] sh: Use GCC __builtin_prefetch() to implement
Message-Id: <4CE39799.8040009@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
In-Reply-To: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Paul,

On 11/17/2010 9:17 AM, Paul Mundt wrote:
>
> On Wed, Nov 17, 2010 at 07:50:17AM +0100, Giuseppe CAVALLARO wrote:
> > GCC's __builtin_prefetch() was introduced a long time ago, all
> > supported GCC versions have it. So this patch is to use it for
> > implementing the prefetch on SH2A and SH4.
> >
> > The current  prefetch implementation is almost equivalent with
> > __builtin_prefetch.
> > The third parameter in the __builtin_prefetch is the locality
> > that it's not supported on SH architectures.  It has been set
> > to three and it should be verified if it's suitable for SH2A
> > as well. I didn't test on this architecture.
> >
> Do we actually require the third parameter at all here? If not, the
>
No we don't.
>
> easiest solution is to just kill off the ARCH_HAS_PREFETCH and
> ARCH_HAS_PREFETCHW bits entirely, as this will already fall back on
> __builtin_prefetch() through the generic code. include/linux/prefetch.h
> already does this:
>
> #ifndef ARCH_HAS_PREFETCH
> #define prefetch(x) __builtin_prefetch(x)
> #endif
>
> #ifndef ARCH_HAS_PREFETCHW
> #define prefetchw(x) __builtin_prefetch(x,1)
> #endif
>
I totally agree!
>
> This is probably a reasonable approach in general since we can leave the
> decision up to gcc, and we don't need to navigate SH ISA hell worrying
> about
> figuring out which CPUs support the instruction and which don't.
>
I'm reworking the patch and I send it to you.

Best Regards
Giuseppe
