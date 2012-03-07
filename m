From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 07 Mar 2012 21:59:05 +0000
Subject: Re: [PATCH 00/08] mach-shmobile timer consolidation
Message-Id: <201203072302.26681.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120306083606.8131.92041.sendpatchset@w520>
In-Reply-To: <20120306083606.8131.92041.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday, March 06, 2012, Magnus Damm wrote:
> mach-shmobile timer consolidation
> 
> [PATCH 01/08] ARM: mach-shmobile: add shmobile_earlytimer_init()
> [PATCH 02/08] ARM: mach-shmobile: sh7367 and G3EVM timer rework
> [PATCH 03/08] ARM: mach-shmobile: sh7377 and G4EVM timer rework
> [PATCH 04/08] ARM: mach-shmobile: sh7372, AP4EVB and Mackerel timer rework
> [PATCH 05/08] ARM: mach-shmobile: sh73a0, AG5EVM and Kota2 timer rework
> [PATCH 06/08] ARM: mach-shmobile: r8a7740 and Bonito timer rework
> [PATCH 07/08] ARM: mach-shmobile: r8a7779 and Marzen timer rework
> [PATCH 08/08] ARM: mach-shmobile: default to no earlytimer
> 
> These patches rework the shmobile timer code to make the earlytimer
> opt-in instead of default. The exisitng in-tree boards will keep on
> using earlytimer as usual, but upcoming DT-based generic support
> can with these patches use the regular driver model for timers.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied.

Thanks,
Rafael


> ---
> 
>  arch/arm/mach-shmobile/board-ag5evm.c        |   14 +-------------
>  arch/arm/mach-shmobile/board-ap4evb.c        |   13 +------------
>  arch/arm/mach-shmobile/board-bonito.c        |   18 +++++++++++-------
>  arch/arm/mach-shmobile/board-g3evm.c         |   13 +------------
>  arch/arm/mach-shmobile/board-g4evm.c         |   13 +------------
>  arch/arm/mach-shmobile/board-kota2.c         |   13 +------------
>  arch/arm/mach-shmobile/board-mackerel.c      |   13 +------------
>  arch/arm/mach-shmobile/board-marzen.c        |   14 +-------------
>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>  arch/arm/mach-shmobile/setup-r8a7740.c       |   10 ++++++++++
>  arch/arm/mach-shmobile/setup-r8a7779.c       |   10 ++++++++++
>  arch/arm/mach-shmobile/setup-sh7367.c        |   10 ++++++++++
>  arch/arm/mach-shmobile/setup-sh7372.c        |   10 ++++++++++
>  arch/arm/mach-shmobile/setup-sh7377.c        |   10 ++++++++++
>  arch/arm/mach-shmobile/setup-sh73a0.c        |   10 ++++++++++
>  arch/arm/mach-shmobile/timer.c               |    8 ++++++--
>  16 files changed, 85 insertions(+), 95 deletions(-)
> 
> 

