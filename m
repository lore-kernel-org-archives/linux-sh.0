From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 13 Sep 2010 11:18:50 +0000
Subject: Re: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
Message-Id: <20100913111850.GC14882@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1284357372.git.matt@console-pimps.org> <1284372533.3042.11.camel@e102144-lin.cambridge.arm.com>
In-Reply-To: <1284372533.3042.11.camel@e102144-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Deacon <will.deacon@arm.com>
Cc: Robert Richter <robert.richter@amd.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-arch@vger.kernel.org

On Mon, Sep 13, 2010 at 11:08:53AM +0100, Will Deacon wrote:
> Hi Matt,
> 
> On Mon, 2010-09-13 at 07:07 +0100, Matt Fleming wrote:
> > The perf-events backend for OProfile that Will Deacon wrote in
> > 8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprofile: use
> > perf-events framework as backend") is of use to more architectures
> > than just ARM. Move the code into drivers/oprofile/ so that SH can use
> > it instead of the nearly identical copy of its OProfile code.
> > 
> [...]
> > 
> > Note that I haven't been able to test these patches on an ARM board to
> > see if I've caused any regressions. If anyone else could do that I'd
> > appreciate it. Though, I have been able to compile this version of the
> > series.
> > 
> I've tested this patch series on a multicore Cortex-A9 board. If I
> revert patch 5/6 (ARM: Make oprofile depend on CONFIG_HW_PERF_EVENTS)
> then everything seems to work fine. Otherwise, testing without
> HW_PERF_EVENTS doesn't fall back to timer mode.
> 
> So, with the exception of the patch above:
> 
> Tested-by: Will Deacon <will.deacon@arm.com>

Hi Will, thanks for testing!

Ah yeah, making oprofile rely on CONFIG_HW_PERF_EVENTS is too
strict. I hadn't noticed that armpmu_get_pmu_id() is wrapped in
CONFIG_HW_PERF_EVENTS and had intended op->cpu_type to be NULL and so
we'd fallback to the timer mode.

This patch needs to be dropped entirely (though another patch should
conditionally include oprofile_perf.o based on CONFIG_HW_PERF_EVENT
like I had in my original series).
