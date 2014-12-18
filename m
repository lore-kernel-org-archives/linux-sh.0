From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Dec 2014 00:19:18 +0000
Subject: Re: [PATCH v3 0/9] ARM: shmobile: ape6evm: multiplatform support
Message-Id: <20141218001918.GB1421@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418833101-7774-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418833101-7774-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 17, 2014 at 05:18:12PM +0100, Ulrich Hecht wrote:
> Hi!
> 
> This series implements multiplatform support for the APE6EVM board, and
> eliminates both legacy platforms.
> 
> This version adds more removal courtesy of Laurent and splits off the
> lan9220 compatible string fix, meaning we (hopefully) are at six patches
> that can go straight in.

Thanks, I have queued up the first 6 patches of this series for v3.20.
And I have deferred the remaining 3; please repost them when the
dependencies are in place. And if it is during the v3.20 release cycle,
please note what those dependencies are including the earlier patches
in this series.

> CU
> Uli
> 
> 
> Changes since v2:
> - removed more leftovers (ape6evm_defconfig, MAINTAINERS entry)
> - break out minor fix in ethernet DT description
> - added Laurent's legacy clock/setup removal patch
> - added Acked-bys
> 
> Changes since v1:
> - merged with "ARM: shmobile: ape6evm-reference: add missing devices"
> - resequenced for merging without CCF support
> - removed a few leftover Kconfig and Makefile targets
> - added Acked-bys
> 
> 
> Laurent Pinchart (1):
>   ARM: shmobile: r8a73a4: Remove legacy code
> 
> Ulrich Hecht (8):
>   ARM: shmobile: ape6evm: fix compatible string for Ethernet controller
>   ARM: shmobile: ape6evm: synchronize dts with reference platform
>   ARM: shmobile: ape6evm: Add LEDs to the device tree
>   ARM: shmobile: ape6evm: Add keypad to the device tree
>   ARM: shmobile: r8a73a4: Multiplatform support
>   ARM: shmobile: r8a73a4: Add r8a73a4-ape6evm.dtb to ARCH_SHMOBILE_MULTI
>   ARM: shmobile: ape6evm-reference: Remove board C code and DT file
>   ARM: shmobile: r8a73a4: ape6evm: remove legacy platform
> 
>  MAINTAINERS                                      |   1 -
>  arch/arm/boot/dts/Makefile                       |   3 +-
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  | 156 ------
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts            | 163 +++++-
>  arch/arm/configs/ape6evm_defconfig               | 109 ----
>  arch/arm/mach-shmobile/Kconfig                   |  30 +-
>  arch/arm/mach-shmobile/Makefile                  |   3 -
>  arch/arm/mach-shmobile/Makefile.boot             |   2 -
>  arch/arm/mach-shmobile/board-ape6evm-reference.c |  61 ---
>  arch/arm/mach-shmobile/board-ape6evm.c           | 286 ----------
>  arch/arm/mach-shmobile/clock-r8a73a4.c           | 659 -----------------------
>  arch/arm/mach-shmobile/r8a73a4.h                 |  17 -
>  arch/arm/mach-shmobile/setup-r8a73a4.c           | 273 +---------
>  13 files changed, 168 insertions(+), 1595 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
>  delete mode 100644 arch/arm/configs/ape6evm_defconfig
>  delete mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c
>  delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c
>  delete mode 100644 arch/arm/mach-shmobile/clock-r8a73a4.c
>  delete mode 100644 arch/arm/mach-shmobile/r8a73a4.h
> 
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
