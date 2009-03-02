From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 02 Mar 2009 02:48:15 +0000
Subject: Re: [PATCH 04/04] sh: prefetch early exception data on sh3/sh4/sh4a
Message-Id: <aec7e5c30903011848h1414c87fv4e0f9dc26f510ec1@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 2, 2009 at 11:30 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Fri, Feb 27, 2009 at 04:53:00PM +0900, Magnus Damm wrote:
>> On Fri, Feb 27, 2009 at 4:22 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>> > This does show how often SH-3 gets tested though, as asm/processor_32.h
>> > happily defines prefetch() for SH-3 when it shouldn't. I'll tidy this up
>> > and drop in a PREF() macro.
>>
>> Right, I do recall building for hp6xx at some point. Thanks for fixing it up.
>>
> The fact that that didn't blow up on the opcode is likely because the
> toolchain you were using had no idea about SH-3 ISA tuning, and so fell
> back on an anything-goes tuning policy. If you are building for exotic
> combinations, always do a single run with V=1 to make sure that the
> CFLAGS are sticking and doing what you think they are doing.

Hm, what about extending the makefiles to check for SH-3 support?
Or maybe that's impossible or takes too long time to implement.

> There are far more people building SH-3 targetted kernels with an SH-4+
> specific toolchain than there are actual SH-3 users, the latter of which
> tend to only provide feedback a few times a year. This unfortunately
> means that these sorts of bugs can be long lived and tedious to bisect at
> a later point in time, but there is not much that can be done about that.

I guess that checking for CFLAGS in the makefiles is out of the question then..

/ magnus
