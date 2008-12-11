From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 11 Dec 2008 00:59:29 +0000
Subject: Re: [PATCH 01/05] clocksource: add read2() callback and warning
Message-Id: <20081211005929.GA9377@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081210151243.32515.61254.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081210151243.32515.61254.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 10, 2008 at 09:47:40PM +0100, Thomas Gleixner wrote:
> On Wed, 10 Dec 2008, john stultz wrote:
> > I do somewhat agree with Thomas that maybe just fixing all the in tree
> > clocksources instead of creating the dual interface is the way to go.
> > But I recognize as an internal interface we may want to deprecate it and
> > let out of tree users have some time to convert. So I could go either
> > way.
> 
> Come on, the function takes now an argument with no further changes to
> the function code itself.
> 
> It's not a complex change which involves refactoring of code.
> 
I agree, we've done this with kmem_cache_create() and friends plenty of
times, which are far more invasive, yet have never been a problem in
converting in one shot. The incremental move approach seems to mostly
work for modules where people are primarily concerned about out-of-tree
code. As modules aren't really a factor here that basically leaves
out-of-tree code as a consideration, which is not something that should
be stopping us from making these API changes. It's not a difficult change
to make to out-of-tree code in any event.
