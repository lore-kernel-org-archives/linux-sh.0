From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 May 2009 03:52:43 +0000
Subject: Re: [PATCH] sh: clkfw: Moved the .init callback in the clk_register function [v4]
Message-Id: <20090514035243.GC10956@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1242050283-7986-1-git-send-email-francesco.virlinzi@st.com>
In-Reply-To: <1242050283-7986-1-git-send-email-francesco.virlinzi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 13, 2009 at 02:27:41PM +0200, Francesco VIRLINZI wrote:
> This patch moves the .init callback in the clk_register function.
> Moreover not the .init callback return a value:
>  - zero means the initialization is ok and the clock can be registered.
>  - any value not zero means there is a problem in the initialization and
>    the clkfw rejects the clock registration
> 
Again, init does not actually mean what you seem to think it does. init
can _never_ fail, if it can, then you are using it for things it was not
intended for. clock registration and clock usability are two totally
different things, the latter of which you can _never_ figure out until
clk_enable() time!

If a CPU has a clock that others are hanging off of, then it needs to be
registered. If there are clock states you can be in where that clock can
not be used, then clk_enable() is the one and only place where you can
fail. Whether a given clock is ok to use or not depends entirely on
present state, none of which you can make any reasonable guess at from
->init time. Additionally, at ->init() time you likewise only have a
single view of the initial clock topology. If that can "fail", then your
clock topology is a disaster and needs to be reworked.

Whether a clock can be enabled or not depends entirely on present
operating conditions, none of which has anything to do with the validity
of the clock itself, or its ability to be registered.

If you can show a good example for why init should return an error code,
then feel free to try. The only thing you seem to be interested in is
using it as a stop-gap solution for bailing out of clock registration,
which is not a change we will make, as it completely ignores the
differences between clk_register()/clk_enable() and ->init().

If you submit a struct clk for registration, there is never a case for it
to fail, plain and simple. If you need to adjust the clock's parent
before registration can "succeed", then you are just moving clock
definition logic in to ->init(). Only the platform can know what sort of
esoteric parent mappings it is employing, and if it has that information
at ->init() time, it damn well does at clk_register() time, too.
