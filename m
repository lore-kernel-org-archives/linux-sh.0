From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 01 Mar 2011 09:25:27 +0000
Subject: Re: [PATCH] sh: Enable PMB support on SH4AL-DSP
Message-Id: <20110301092527.GA15618@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110301064150.GB5985@linux-sh.org>
In-Reply-To: <20110301064150.GB5985@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 01, 2011 at 06:12:25PM +0900, Magnus Damm wrote:
> On Tue, Mar 1, 2011 at 6:02 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > I'm not sure how you extracted that question out of the above or even
> > what relevance it has to anything.
> 
> You seem to want to special case ARM/SH multi-core configurations. I
> don't disagree with that, but you are arguing about enabling PMB on
> SH4AL-DSP or not. Which I find rather strange, since the PMB may or
> may not be included in SH4A.
> 
To date PMB support has existed in every SH-4A, and has never existed in
any SH4AL-DSP. How much more straightforward do you want me to spell it
out for you?

> > No, I do not want to allow people to enable support for something that
> > doesn't exist. Standard SH4AL-DSP parts do not have a PMB, at all,
> > period. The only parts with PMBs are regular SH-4A parts and apparently
> > all of the SH/R-Mobile multi-core parts regardless of whether they're
> > using an SH-4A or SH4AL-DSP based SH core. This is what needs to be
> > special cased, and we're not going to pretend like the rest of the
> > SH4AL-DSP family can theoretically be equipped with PMB support just
> > because a special fork of the SoC line happened to introduce them without
> > reving the core version up.
> 
> And you're certain that you've seen all SH4AL-DSP parts available?
> 
We do not make configuration options based on arbitrary speculation, only
on facts. To date there have been no SH4AL-DSP parts with a PMB as part
of its configuration. If and when one shows up, it gets special cased.

> >> Take a look at sh7723. It has an X2 core and selects CPU_SH4A. People
> >> compiling for sh7723 can chose to enable CONFIG_PMB if they want to.
> >> This may not be the way you want it to work though, I'm not sure.
> >>
> > All SH-4A parts support the PMB, so I'm not sure why this is surprising?
> 
> sh7723 has an SH4A yes, but no PMB support is included. At least
> that's what the data sheet says.
> 
Then SH7723 violates SH-4A specifications and likewise needs to have its
dependencies tightened down.

> >> But if the sh7723 case is like that then I can't see what is wrong
> >> with removing the !SH4AL_DSP bits for the Kconfig.
> >>
> > Because SH4AL-DSP does not support the PMB. Regular SH-4A cores do, as do
> > apparently all of the R-Mobile parts regardless of which core was
> > included on the SH SoC side. This is where the special casing needs to
> > happen, and I'm not really sure why you seem to be having such a hard
> > time following the dependency chain.
> 
> I believe that the PMB feature can be added to SH4A or SH4A-DSP,
> regardless of if it's included in an ARM multi-core package.
> 
Fortunately what you believe has no bearing on the issue at hand. While
any IP block can be added to any CPU subtype in theory, we don't make
arbitrary combinations available up until the point where a certain
configuration is demonstrable for a given subtype.

Show me the hardware and its PRR/PVR settings, and then we can work out
how best to express that in Kconfig language. Arbitrary hand-waving is
not how we do things, particularly when it comes to options that make
randomized configurations unbootable.

> > There are certain things that can be inferred from each core family
> > revision. We know that SH-X has a certain subset of features, likewise
> > for SH-X2, SH-X3, etc. this is likewise true for SH-4A and SH4AL-DSP. The
> > PMB is part of the core features on SH-4A but has never been part of
> > SH4AL-DSP. If some hardware people somewhere have taken an SH4AL-DSP and
> > bolted on some extra logic to it and made that a standard subset for
> > those particular SoCs, then we need to special case the CPU family and
> > pile the dependencies on top of that. The pattern as such needs to be one
> > of R-Mobile implies PMB rather than SH4AL-DSP implies PMB, as the latter
> > is demonstrably false.
> 
> But sh7723 is SH-Mobile but it does not support PMB.
> 
Then this is a bug and needs to be corrected, not blindly layered on top
of.
