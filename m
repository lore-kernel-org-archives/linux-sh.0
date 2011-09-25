From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 25 Sep 2011 21:29:50 +0000
Subject: Re: [PATCH 00/03] ARM: mach-shmobile: sh7372 CPU sleep patches
Message-Id: <201109252329.50206.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630094653.10442.68817.sendpatchset@t400s>
In-Reply-To: <20110630094653.10442.68817.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday, September 23, 2011, Magnus Damm wrote:
> ARM: mach-shmobile: sh7372 CPU sleep patches
> 
> Subject: [PATCH 01/03] ARM: mach-shmobile: sh7372 generic suspend/resume support
> Subject: [PATCH 02/03] ARM: mach-shmobile: sh7372 A3SM support
> Subject: [PATCH 03/03] ARM: mach-shmobile: sh7372 sleep warning fixes
> 
> These patches update the sh7372 sleep code to make use
> of the generic ARM suspend/resume code and to add A3SM
> sleep mode support for Suspend-to-RAM. The first two
> patches have been posted earlier, and the last contain
> a few warning fixes.
> 
> Fits the pm-test branch of the linux-pm git repository.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

All patches applied to linux-pm/pm-domains (and merged into pm-test
and linux-next).

Thanks,
Rafael


> ---
> 
>  arch/arm/mach-shmobile/include/mach/common.h |    6 
>  arch/arm/mach-shmobile/pm-sh7372.c           |  252 ++++++++++++++++++++--
>  arch/arm/mach-shmobile/sleep-sh7372.S        |  287 +++++---------------------
>  3 files changed, 286 insertions(+), 259 deletions(-)
> 
> 

