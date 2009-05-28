From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 May 2009 06:54:57 +0000
Subject: Re: [PATCH][RFC] sh: helper code for 4-bit divisors
Message-Id: <20090528065457.GB16978@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <aec7e5c30905272159o7838c469jc7ae935e1eda02d@mail.gmail.com>
In-Reply-To: <aec7e5c30905272159o7838c469jc7ae935e1eda02d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 28, 2009 at 02:54:59PM +0900, Magnus Damm wrote:
> On Thu, May 28, 2009 at 2:25 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > I don't particularly mind which one you want to use, but at least forcing
> > the clock flags in the register function must die. CLK_ENABLE_ON_INIT is
> > only ever supposed to be used sparingly, not as a blanket thing. I have
> > modified the SH-Mobile clocks previously also to fix this up, and I will
> > not apply any patch that default-enables everything. I do not want to see
> > any of these clock flags used by registration functions, ever. These need
> > to be decided on an individual basis by each clock. If you want to have
> > macros for building those up, fine, but the flag setting must be done
> > explicitly for each clock.
> 
> Ok, sure. I agree. Maybe the current cpg clocks for sh7785 can be
> tuned a bit then, maybe the peripheral clock doesn't need to use
> CLK_ENABLE_ON_INIT?
> 
Yes, the peripheral clock can have this disabled, it's children will
force it to be enabled, the reason it has that bit at all is because at
the time I was converting from the legacy clocks, there were no sibling
clocks.

> > The sh_clk_cpg_div4_data structure I am also not terribly keen on.
> > For starters, the frequency table has no place in this data structure, at
> > all. Nothing about it is specific to div4 clocks, and all this does is
> > encourage alternate tables to be constructed elsewhere. There is nothing
> > in this structure that can basically not be included in the struct clk
> > directly, and we can of course throw the CPG ifdef around those fields to
> > make life easier on people who aren't using the CPG.
> 
> The only specific thing for div4 clocks is that it's for 4 bit
> divisors which means that the frequency table size is adjusted to
> that.
> 
Yes, we need to be a bit more intelligent about handling the frequency
table, but that again is a totally unrelated issue.

> I guess the concept of a private pointer is to allow different
> implementations to hook in whatever private data they need.
> It makes sense to use the same structure for all implementations if
> they are close enough, but I'm not sure if it's a good plan to embeed
> a huge frequency table in struct clk at this point. Maybe after moving
> stop bits from clocks to wakeup/idle.
> 
Likewise.

> > Once this is generalized enough I think I will just kill the private data
> > pointer entirely to avoid this sort of abuse happening in the future.
> 
> Your view of the clock framework seems to be that all SuperH clocks
> are close enough so we can just throw everything into struct clock.
> I'd say that we have at least 4 different types of clocks: PLL, DIV4,
> DIV6 and MSTP. We can of course use the same data structure for
> everything, I just don't see why since they are all have different
> needs.
> 
MSTP is not now nor has it ever been a clock. It got shoehorned in to the
clock framework because we had no better place for it, if your generic
platform stuff gets integrated, the MSTP mess will need a separate
abstraction and will be tied in to that. We only use the clock framework
now because piggybacking on clk_enable()/disable() for a virtualized
function clock that maps to an MSTP bit is convenient. However, we have
many blocks with MSTP bits that don't have any clocks of their own in the
first place. Fixing up this coupling is beneficial.

Beyond that, PLL, DIV4, and DIV6 are different. I do not expect that one
size will fit all, but I more than expect that a reasonably flexible
struct clk will work for the 95% case, and we can special case the
scenarios that do not map in to that. There is absolutely no point in
having a struct clk in the first place if you want it to be some sort of
neutered rate/refcount container where all of the real clock information
is stashed off in some random data structure. Divisors and multipliers
are common to _every_ clock, so this is data that you are going to have
to reproduce in every one of your offshoot data structures anyways, with
the only variation being in size. A maze of fairly similar data
structures is a total disaster, and likewise will not be merged, so don't
even waste your time.

For the root clocks it is acceptable to have special data structures if
and only if they can not fit within the struct clk abstraction, or they
happen to need a lot more data (which is probably true in the PLL cases).
But extending this methodology to every clock on the system only creates
an unmaintainable mess.

> I'm more for making struct clk as small as possible and let each
> specialized clock type wrap whatever it needs around the data type.
> With or without private data pointer in struct clk. =)

Which is precisely what struct clk was never intended for in the first
place. It is meant to be a useful abstraction, not a refcount wrapper.
