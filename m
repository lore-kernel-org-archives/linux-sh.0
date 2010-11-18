From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 18 Nov 2010 06:09:57 +0000
Subject: Re: [PATCH (sh-2.6)] sh: Use GCC __builtin_prefetch() to implement prefetch (V2)
Message-Id: <20101118060957.GA17539@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
In-Reply-To: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 17, 2010 at 12:01:27PM +0100, Peppe CAVALLARO wrote:
> On 11/17/2010 10:49 AM, Paul Mundt wrote:
> > Actually now that I think about it, it's not that simple. If
> > ARCH_HAS_PREFETCH goes away then we lose prefetch_range() (which
> > admittely isn't called anywhere that matters, but it may in the future).
> >
> > If gcc is smart enough to optimize out __builtin_prefetch() for the cases
> > where nothing has to be done, then the ARCH_HAS_PREFETCH define could
> > simply be killed and each arch would be responsible for establishing the
> > prefetch stride (this seems to vary between the size of an L1 or L2
> > cacheline depending on the platform). This is a different change though,
> > and is something you would have to bring up on linux-arch and
> > linux-kernel as a separate patch.
> >
> > Perhaps the easiest solution for now is just to stick with your first
> > version, which at least retains the stride data and prefetch_range()
> > behaviour.
> >
> Maybe it's worth having my first patch.
> We don't lose the prefetch_range behavior.
> Compiler should also be smart enough to manage the pref
> inst optimizing the generated code.

Ok, I've taken the first patch for the .37 queue. I've given it a spin on
SH-2A and things seem to be ok there, too.
