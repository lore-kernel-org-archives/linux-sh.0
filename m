From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Mar 2009 12:45:56 +0000
Subject: Re: [PATCH] sh: clkfwk: Changed the init function
Message-Id: <20090316124556.GI21433@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49BA1505.7000500@st.com>
In-Reply-To: <49BA1505.7000500@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 16, 2009 at 01:39:16PM +0100, Francesco VIRLINZI wrote:
> Hi Paul
> Paul Mundt ha scritto:
> >On Fri, Mar 13, 2009 at 09:10:45AM +0100, Francesco VIRLINZI wrote:
> >  
> >>This patch changes the init field in the clk_ops structure.
> >>Moreover it changes how the init function is used.
> >>Now it's called during registration and if something was wrong the clock 
> >>isn't registered.
> >>
> >>    
> >Ok, I'll bite. Why?
> >  
> Than:
> I think the clk_ops.init function has (mandatory) to return a value
>  to notify to the clk framework if the clock initialization was ok or not.
> 
> Moreover in my point of view if a clock has an clk_ops.init function 
> than the function
> has to be called during the clk_register because we must know as soon 
> as possible
> if a clock is working or not... It isn't really nice discover a 
> not-working clock
> after a call to clk_enable().... while the clk is perfectly registered...
> 
> i.e.: I'm thinking for example on a clock on i2c bus... ( I assume a clkfwk
> should be able to manage any kind of clock). During the clk_register
> (with the clk_ops.init) I can check if the clock can be really used
> or not instead of discover (for example) with the clk_enable()
> that the i2c-bus sees no device...
> 
> Let me know if I clarified my view.
> 
You are blurring the lines between what init and enable are supposed to
do. In the case of init, it is giving the clock in question a chance to
set some initial paramters and prepare itself for further use. If a clock
is registering with the clock framework, this init sequence can not fail.
This is especially true for clocks that are always enabled, as it is
simply mapping out a topology rather than anything more profound.

The issues that determine whether a clock can be enabled or not depends
entirely on the current set of constraints, constraints that are not
fixed across the lifetime of the system, this means that the one and only
place you can error out on an enable, is through the ->enable() hook
itself. The situation you discuss with the i2c clock is something that
should be erroring out through the enable path, not the init path.

The clock framework itself also specifies that no assumptions can be made
about the state of the clock, so you must call clk_enable() to enable the
clock after bumping the refcount with clk_get(), and then and only then
can you determine if there is a problem with the clock settings.
