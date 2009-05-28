From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 05:54:59 +0000
Subject: Re: [PATCH][RFC] sh: helper code for 4-bit divisors
Message-Id: <aec7e5c30905272254i48c6b52asf99c9edf03031653@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <aec7e5c30905272159o7838c469jc7ae935e1eda02d@mail.gmail.com>
In-Reply-To: <aec7e5c30905272159o7838c469jc7ae935e1eda02d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, May 28, 2009 at 2:25 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, May 28, 2009 at 01:59:31PM +0900, Magnus Damm wrote:
>> Hey Paul,
>>
>> Attached are two versions of helper code for 4-bit divisors. The
>> sh7785 clock code is modified as an example.
>>
>> linux-2.6.31-pre-sh-clk-cpg-div4-sh7785-a-20090528.patch
>> =A0include/asm/clock.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 42 +++++++
>> =A0kernel/cpu/clock-cpg.c =A0 =A0 =A0 =A0 | =A0 66 +++++++++++
>> =A0kernel/cpu/sh4a/clock-sh7785.c | =A0241 +++++++++++++----------------=
------------
>> =A03 files changed, 188 insertions(+), 161 deletions(-)
>>
>> linux-2.6.31-pre-sh-clk-cpg-div4-sh7785-b-20090528.patch
>> =A0include/asm/clock.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 40 +++++++
>> =A0kernel/cpu/clock-cpg.c =A0 =A0 =A0 =A0 | =A0 69 +++++++++++++
>> =A0kernel/cpu/sh4a/clock-sh7785.c | =A0206 ++++++++---------------------=
------------
>> =A03 files changed, 154 insertions(+), 161 deletions(-)
>>
>> I prefer version b (the last) since it allows us to write more compact
>> per-processor code. Also, I think using offsetof is a quick and cheap
>> way to get private data without using much memory. I may be the only
>> person that likes wrapping stuff like this though. Any thoughts?
>>
>> If we can agree on something then i'd like to convert the SuperH
>> Mobile processors using this.
>>
> I don't particularly mind which one you want to use, but at least forcing
> the clock flags in the register function must die. CLK_ENABLE_ON_INIT is
> only ever supposed to be used sparingly, not as a blanket thing. I have
> modified the SH-Mobile clocks previously also to fix this up, and I will
> not apply any patch that default-enables everything. I do not want to see
> any of these clock flags used by registration functions, ever. These need
> to be decided on an individual basis by each clock. If you want to have
> macros for building those up, fine, but the flag setting must be done
> explicitly for each clock.

Ok, sure. I agree. Maybe the current cpg clocks for sh7785 can be
tuned a bit then, maybe the peripheral clock doesn't need to use
CLK_ENABLE_ON_INIT?

> The sh_clk_cpg_div4_data structure I am also not terribly keen on.
> For starters, the frequency table has no place in this data structure, at
> all. Nothing about it is specific to div4 clocks, and all this does is
> encourage alternate tables to be constructed elsewhere. There is nothing
> in this structure that can basically not be included in the struct clk
> directly, and we can of course throw the CPG ifdef around those fields to
> make life easier on people who aren't using the CPG.

The only specific thing for div4 clocks is that it's for 4 bit
divisors which means that the frequency table size is adjusted to
that.

> I was hesitant to add a private data pointer to struct clk in the first
> place because I knew as soon as that was done people would use that as an
> excuse for building up all manner of unspeakable helper structures rather
> than just thinking about what needs to be in struct clk and what doesn't.
> If you want to have smaller data structures for making things easier to
> manipulate, that is perfectly fine, but struct clk is the container that
> they ultimately belong in, not buried under the private data pointer.

I guess the concept of a private pointer is to allow different
implementations to hook in whatever private data they need.
It makes sense to use the same structure for all implementations if
they are close enough, but I'm not sure if it's a good plan to embeed
a huge frequency table in struct clk at this point. Maybe after moving
stop bits from clocks to wakeup/idle.

> Once this is generalized enough I think I will just kill the private data
> pointer entirely to avoid this sort of abuse happening in the future.

Your view of the clock framework seems to be that all SuperH clocks
are close enough so we can just throw everything into struct clock.
I'd say that we have at least 4 different types of clocks: PLL, DIV4,
DIV6 and MSTP. We can of course use the same data structure for
everything, I just don't see why since they are all have different
needs.

I'm more for making struct clk as small as possible and let each
specialized clock type wrap whatever it needs around the data type.
With or without private data pointer in struct clk. =3D)

/ magnus
