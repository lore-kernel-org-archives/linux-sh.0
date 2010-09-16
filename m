From: Robert Richter <robert.richter@amd.com>
Date: Thu, 16 Sep 2010 13:34:44 +0000
Subject: Re: [PATCH 5/6] ARM: Make oprofile depend on CONFIG_HW_PERF_EVENTS
Message-Id: <20100916133444.GB13563@erda.amd.com>
List-Id: <linux-sh.vger.kernel.org>
References: <831bc9523fe04ce899bc78230990033fbe009431.1284357372.git.matt@console-pimps.org>
In-Reply-To: <831bc9523fe04ce899bc78230990033fbe009431.1284357372.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 13.09.10 04:39:52, Will Deacon wrote:
> Hi Matt,
> 
> On Mon, 2010-09-13 at 07:07 +0100, Matt Fleming wrote:
> > Currently, oprofile support is only functional if CONFIG_HW_PERF_EVENTS
> > is set. If this symbol is not set, oprofile initialisation will fail at
> > runtime. Instead of allowing the oprofile code to build but fail at
> > runtime it seems less confusing to not allow the code to be built unless
> > hardware performance counter support is available.
> > 
> > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> > ---
> >  arch/arm/Kconfig           |    2 +-
> >  arch/arm/oprofile/common.c |    9 ---------
> >  2 files changed, 1 insertions(+), 10 deletions(-)

> When oprofile_arch_init fails (-ENODEV), oprofile will fall back to
> timer mode. With this patch, how can you make use of a timer fallback?

True, if you want an error at compile time, maybe we use the #error
pragma instead. But falling back to timer mode is fine to me too.
Will leave that decision to the arm folks.

-Robert

> 
> I'll try and get around to testing the rest of this series today.
> 
> Cheers,
> 
> Will
> 
> 
> 
> 

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

