From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 20 Mar 2014 01:48:00 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <2155101.UbbyfOZxJe@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patches.

On Wednesday 19 March 2014 20:06:45 Geert Uytterhoeven wrote:
> This patchset enables the PM runtime code in drivers/sh/pm_runtime.c when
> running a multi-platform ARM kernel including support for shmobile.
> Before this code was only enabled for legacy shmobile kernels, leading to
> disabled clocks in multiplatform kernels, depending on implicit reset state
> or on the bootloader.
> 
>   [1/5] drivers: sh: pm_runtime does not need idle callback
>   [2/5] sh: intc: Restrict INTC_USERIMASK to SH4A
>   [3/5] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
>   [4/5] ARM: shmobile: Call sh_pm_runtime_init() from platform code on all
>         SoCs
>   [5/5] drivers: sh: Remove automatic sh_pm_runtime_init() if
>         ARCH_SHMOBILE_LEGACY
> 
> Patches 1 and 3 were authored by Ben Dooks, with some changes made by me
> (for patch 3). Patch 4 was based on a patch by Ben for r8a7790.
> 
> After this it should be safe to revert the various commits to "Work around
> core clock issues". Note that this is just a port of the existing
> sh(mobile)-specifc PM runtime code from legacy to multi-platform, so
> expect more work to fix the core issues.
> 
> This was tested on Koelsch, both legacy and multi-platform.
> 
> Many thanks to Ben Dooks, Laurent Pinchart, and Magnus Damm for the
> valuable input, investigations, and discussions.
> 
> Thanks for your comments, and test results on other boards/SoCs (esp.
> SoCs supporting power domains, like sh7372, r8a7740, and r8a7779)!

For the whole series,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On r8a7779 legacy only (as r8a7779 isn't supported in multiplatform kernels 
yet),

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

