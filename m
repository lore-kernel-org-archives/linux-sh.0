From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 09 May 2008 01:52:23 +0000
Subject: Re: sh migor_defconfig build breakage
Message-Id: <20080509015223.GA30083@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080508203949.GC22887@cs181133002.pp.htv.fi> <48236E59.8070400@sgi.com> <4823711D.70401@sgi.com> <482376BC.2000404@sgi.com> <48237ADE.3090703@sgi.com> <20080509005006.GA29869@linux-sh.org> <4823A70D.10103@sgi.com>
In-Reply-To: <4823A70D.10103@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Travis <travis@sgi.com>
Cc: Adrian Bunk <bunk@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, ralf@linux-mips.org

On Thu, May 08, 2008 at 06:21:17PM -0700, Mike Travis wrote:
> Paul Mundt wrote:
> > On Thu, May 08, 2008 at 03:12:46PM -0700, Mike Travis wrote:
> >> Mike Travis wrote:
> >>> Because some arch's have it defined as an inline function.  Perhaps the
> >>> easiest would be to add to include/asm-sh/topology.h a simple define of
> >>> cpu_to_node()?
> >> Ahh, this is what caused the error.  In include/asm-generic/topology.h
> >> cpu_to_node is only defined now if NUMA is turned off.
> >>
> >> #ifndef CONFIG_NUMA
> >>
> >> /* Other architectures wishing to use this simple topology API should fill
> >>    in the below functions as appropriate in their own <asm/topology.h> file. */
> >> #ifndef cpu_to_node
> >> #define cpu_to_node(cpu)        ((void)(cpu),0)
> >> #endif
> >> ...
> >>
> >> So before my change arch 'sh' used the default define whether NUMA was
> >> set or not.
> >>
> > The dependency here is a bit vague in the first place. For UP NUMA the
> > asm-generic definitions are perfectly fine, it's only the CONFIG_NUMA &&
> > CONFIG_SMP cases where there is any point in doing anything more
> > fine-grained. So while it would be trivial to add a CONFIG_SMP test here
> > too, that's likely to break all of the other NUMA platforms.
> > 
> > So while sh can use the asm-generic definitions in the UP case, it
> > obviously can't on SMP. The easiest option for now is to just stub the
> > asm-generic bits in to asm-sh/topology.h under a CONFIG_NUMA ifdef and
> > then add more reasonable definitions for the SMP cases.
> 
> The "suggested" patch I submitted sort of covered all the cases of CONFIG_NUMA=y
> without regards to CONFIG_SMP.  It seems you're suggesting that I only change
> the asm-sh/topology.h file and leave the remaining arch's for "error discovery"
> later?
> 
If you want to solve it that way, it's fine as well. My point is simply
that the asm-generic/topology.h definitions are effectively only sane on
the UP case in the first place. Out of the platforms that do CONFIG_NUMA,
both sh and mips are currently broken due to the cpu_to_node() bits.

sh tends to be the odd one out in doing both UP and SMP NUMA, so I don't
mind doing this in asm-sh/topology.h either. mips is almost certainly
broken, but the generic cpu_to_node() isn't going to be sufficient there
anyways, so "error discovery" there will at least wake up anyone
interested in the broken platform. ip27 seems to be the only effected
platform there, though it's not obvious if NUMA depends on SMP or not in
that case.
