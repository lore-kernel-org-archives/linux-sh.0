From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Mar 2009 12:50:58 +0000
Subject: Re: [PATCH 04/04] sh: prefetch early exception data on sh3/sh4/sh4a
Message-Id: <20090316125058.GJ21433@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 16, 2009 at 01:00:47PM +0100, Kristoffer Ericson wrote:
> On Mon, 2 Mar 2009 11:30:13 +0900
> Paul Mundt <lethal@linux-sh.org> wrote:
> > On Fri, Feb 27, 2009 at 04:53:00PM +0900, Magnus Damm wrote:
> > > On Fri, Feb 27, 2009 at 4:22 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > > > This does show how often SH-3 gets tested though, as asm/processor_32.h
> > > > happily defines prefetch() for SH-3 when it shouldn't. I'll tidy this up
> > > > and drop in a PREF() macro.
> > > 
> > > Right, I do recall building for hp6xx at some point. Thanks for fixing it up.
> > > 
> > 
[snip]

> > There are far more people building SH-3 targetted kernels with an SH-4+
> > specific toolchain than there are actual SH-3 users, the latter of which
> > tend to only provide feedback a few times a year. This unfortunately
> > means that these sorts of bugs can be long lived and tedious to bisect at
> > a later point in time, but there is not much that can be done about that.
> 
> I usually build a couple of kernels per month for the hp6xx (sh3) so the biggest
> stuff kernel wise usually gets caught there. I however use an old sh3 toolchain so
> gcc stuff often runs me by. Lack of time to fix the hd64461 mfd driver is probably the main
> reason why hp6xx isnt more in sync currently.
> If theres anything specific you want to test just shout. I keep an close eye
> on the mailinglists even if I dont say much :)
> 
The entire purpose of this thread is to show that _building_ is not the
issue, as various SH-3 targets are built daily by multiple people with
multiple compilers and multiple trees. The issue is with testing. The
platforms with a close to single user userbase suffer from the problem
that the only time we get any feedback is when something has broken,
usually months after the fact. There is no easy way to solve this issue
though, it is just something to be aware of. When issues do pop up, they
will be fixed in turn, but are not likely to be prioritized. Jumping in
when things are being worked on and integrated early on gaurantees that
those issues are fixed immediately.
