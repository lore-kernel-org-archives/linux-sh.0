From: Robert Richter <robert.richter@amd.com>
Date: Mon, 11 Oct 2010 18:59:23 +0000
Subject: Re: [PATCH V5 0/7] Generalise ARM perf-events backend for oprofile
Message-Id: <20101011185923.GW13563@erda.amd.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1286584677.git.matt@console-pimps.org>
In-Reply-To: <cover.1286584677.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matt Fleming <matt@console-pimps.org>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>

On 08.10.10 20:46:15, Matt Fleming wrote:
> The perf-events backend for OProfile that Will Deacon wrote in
> 8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprofile: use
> perf-events framework as backend") is of use to more architectures
> than just ARM. Move the code into drivers/oprofile/ so that SH can use
> it instead of the nearly identical copy of its OProfile code.
> 
> The benefit of the backend is that it becomes necessary to only
> maintain one copy of the PMU accessor functions for each architecture,
> with bug fixes and new features benefiting both OProfile and perf.

> Matt Fleming (7):
>   perf: Add helper function to return number of counters
>   perf: New helper function for pmu name
>   oprofile: Make op_name_from_perf_id() global
>   ARM: oprofile: Rename op_arm to oprofile_perf
>   ARM: oprofile: Move non-ARM code into separate init/exit
>   oprofile: Abstract the perf-events backend
>   sh: oprofile: Use perf-events oprofile backend
> 
>  arch/arm/kernel/perf_event.c     |    6 +
>  arch/arm/oprofile/Makefile       |    4 +
>  arch/arm/oprofile/common.c       |  309 +-----------------------------------
>  arch/sh/Kconfig                  |   13 ++
>  arch/sh/kernel/perf_event.c      |   18 ++
>  arch/sh/oprofile/Makefile        |    4 +
>  arch/sh/oprofile/common.c        |  115 +++-----------
>  arch/sh/oprofile/op_impl.h       |   33 ----
>  drivers/oprofile/oprofile_perf.c |  326 ++++++++++++++++++++++++++++++++++++++
>  include/linux/oprofile.h         |    7 +
>  include/linux/perf_event.h       |    2 +
>  kernel/perf_event.c              |    5 +
>  12 files changed, 412 insertions(+), 430 deletions(-)
>  delete mode 100644 arch/sh/oprofile/op_impl.h
>  create mode 100644 drivers/oprofile/oprofile_perf.c

Thanks Matt, I applied your patches to the oprofile tree and merged
them with the core branch. As I already wrote, I modified patch #4 to
fix the compile breakage.

The patches are available for testing in

 git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git core

Thanks again,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

