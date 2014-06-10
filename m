From: Simon Horman <horms@verge.net.au>
Date: Tue, 10 Jun 2014 07:27:26 +0000
Subject: Re: [PATCH v2 00/07] ARM: shmobile: Suspend on non-SMP for r8a7790/r8a7791
Message-Id: <20140610072723.GA10908@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140606071749.14853.90558.sendpatchset@w520>
In-Reply-To: <20140606071749.14853.90558.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 06, 2014 at 04:17:49PM +0900, Magnus Damm wrote:
> ARM: shmobile: Suspend on non-SMP for r8a7790/r8a7791 (V2)
> 
> [PATCH v2 01/07] ARM: shmobile: Allow use of boot code for non-SMP case
> [PATCH v2 02/07] ARM: shmobile: Adjust APMU code to build for non-SMP
> [PATCH v2 03/07] ARM: shmobile: Use __init for APMU suspend init function
> [PATCH v2 04/07] ARM: shmobile: Move r8a7790 reset code to pm-r8a7790.c
> [PATCH v2 05/07] ARM: shmobile: Allow r8a7790 to build non-SMP APMU code
> [PATCH v2 06/07] ARM: shmobile: Move r8a7791 reset code to pm-r8a7791.c
> [PATCH v2 07/07] ARM: shmobile: Allow r8a7791 to build non-SMP APMU code
> 
> These patches update mach-shmobile and r8a7790/r8a7791 to allow build of
> early boot code and APMU power management code in case of CONFIG_SMP=n.
> 
> The reason for this change is to allow use of Suspend-to-RAM for recent
> SoCs like R-Car Gen2 with simplified kernel configuration such as when
> SMP is disabled. Power management code like CPUFreq, CPUIdle and
> Suspend-to-RAM should work regardless of what kind of CONFIG_SMP
> setting the user decides.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Hi Magnus,

could you let me know what the status of this series is?

> ---
> 
>  Written on top of renesas-devel-v3.15-rc8-20140605v3
> 
>  Changes since V1:
>  - Dropped V1 patch 6, 7, 8 - needs more discussions how to tie in UP case
>  - Moved V1 patch 5 to V2 patch 3
>  - Added r8a7791 code at end of series
> 
>  arch/arm/mach-shmobile/Makefile       |   21 ++++++++++------
>  arch/arm/mach-shmobile/headsmp.S      |   13 ++++++----
>  arch/arm/mach-shmobile/platsmp-apmu.c |   13 ++++++----
>  arch/arm/mach-shmobile/pm-r8a7790.c   |   41 +++++++++++++++++++++++++++++++--
>  arch/arm/mach-shmobile/pm-r8a7791.c   |   29 +++++++++++++++++++++--
>  arch/arm/mach-shmobile/smp-r8a7790.c  |   31 ------------------------
>  arch/arm/mach-shmobile/smp-r8a7791.c  |   25 --------------------
>  7 files changed, 95 insertions(+), 78 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
