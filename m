From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 15 Apr 2014 14:49:35 +0000
Subject: Re: [ PATCH v2 00/17] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <1912265.bpG4EOo3xd@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1397565253-22741-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1397565253-22741-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Tuesday 15 April 2014 14:33:56 Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patchset enables the PM runtime code in drivers/sh/pm_runtime.c when
> running a multi-platform ARM kernel including support for shmobile.
> Before this code was only enabled for legacy shmobile kernels, leading to
> disabled clocks in multiplatform kernels, depending on implicit reset state
> or on the bootloader.
> It also contains some related cleanups, and removals of workarounds.
>
>   - [01/17] ARM: shmobile: r8a7740: Remove unused
>     r8a7740_add_early_devices_dt()
>   - [02/17] ARM: shmobile: r8a7740: Make r8a7740_meram_workaround() __init
>   - [03/17] ARM: shmobile: sh7372: Call sh7372_add_early_devices() instead
> of open coding
>   - [04/17] drivers: sh: pm_runtime does not need idle callback
>   - [05/17] drivers: sh: pm_runtime implementation needs to suspend and
> resume devices
>   - [06/17] sh: intc: Restrict INTC_USERIMASK to SH4A
>   - [07/17] drivers: sh: compile drivers/sh/pm_runtime.c if
> ARCH_SHMOBILE_MULTI - [08/17] ARM: shmobile: Call sh_pm_runtime_init() from
> platform code on all SoCs
>   - [09/17] drivers: sh: Remove automatic sh_pm_runtime_init() if
>     ARCH_SHMOBILE_LEGACY
>   - [10/17] ARM: shmobile: koelsch-reference: Remove workarounds for core
> clock issues
>   - [11/17] ARM: shmobile: lager-reference: Remove workarounds for core
> clock issues
>   - [12/17] clk: shmobile: mstp: Fix the is_enabled() operation
>   - [13/17] ARM: shmobile: r7s72100: Populate .init_machine for generic
>     r7s72100
>   - [14/17] ARM: shmobile: r8a73a4: Populate .init_machine for generic
> r8a73a4 - [15/17] ARM: shmobile: r8a7778: Populate .init_machine for
> generic r8a7778 - [16/17] ARM: shmobile: r8a7790: Populate .init_machine
> for generic r8a7790 - [17/17] ARM: shmobile: r8a7791: Populate
> .init_machine for generic r8a7791
> 
> Patches 4, 5, and 7 were authored by Ben Dooks, with some changes made by me
> (for patch 7).
> Patch 8 was based on a patch by Ben for r8a7790.
> Patch 12 was authored by Laurent Pinchart.
> 
> Besides rebasing, only one patch was changed, compared to previous
> submission: - 8: The call to sh_pm_runtime_init() was moved to the start of
>     .init_machine(), to enable the GPIO clocks on R-Car Gen2.

Thank you for the patches.

> Several patches are new:
>   - 1-3 contain some related cleanups to board support code,
>   - 5 was added as it touches related code,
>   - 10-11 remove workarounds that are no longer needed,
>   - 12 was added as it depends on the fixes from this series,

For 01/17 to 12/17,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>   - 13-17 are more or less RFCs: As we always have to call
>     sh_pm_runtime_init(), I added .init_machine hooks in the generic support
> code for all SoCs that didn't have it yet. I also included code to set up
> SoC platform support while at it, as this will be useful later. Booting
> using a generic "renesas,r*" DT was untested.

I wonder whether we shouldn't wait until we get rid of the *_add_dt_devices() 
functions before applying those.

As the goal is to remove the setup-*.c files, have you thought about where the 
sh_pm_runtime_init() calls should move to ?

> This was tested on Koelsch, both legacy and multi-platform.
> 
> Many thanks to Ben Dooks, Laurent Pinchart, and Magnus Damm for the
> valuable input, investigations, and discussions.

-- 
Regards,

Laurent Pinchart

