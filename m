From: Paul Bolle <pebolle@tiscali.nl>
Date: Sat, 24 Jan 2015 16:49:16 +0000
Subject: Re: [PATCH 0/4] defconfigs: cleanup obsolete MTD configs
Message-Id: <1422118156.27947.7.camel@x220>
List-Id: <linux-sh.vger.kernel.org>
References: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
In-Reply-To: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, 2015-01-24 at 18:33 +0200, Semen Protsenko wrote:
> This patch series removes next obsolete MTD configs from all defconfig files:
>   - CONFIG_MTD_CHAR
>   - CONFIG_MTD_CONCAT
>   - CONFIG_MTD_DEBUG
>   - CONFIG_MTD_DEBUG_VERBOSE
>   - CONFIG_MTD_PARTITIONS
> 
> All those configs were removed from drivers/mtd/Kconfig earlier, but their usage
> in defconfig files was remain unnoticed. There are at least two obvious reasons
> to get rid of those configs:
>   1. Their usage may cause to build warnings

That's news for me. I thought they are silently ignored. Do you have an
example of such a warning?

>   2. Their usage may confuse someone who is grepping defconfig files to get
>      the clue what MTD configuration may look like.
> 
> This series is harmless for all those defconfigs and will not break anything.
> 
> 
> Semen Protsenko (4):
>   defconfigs: remove CONFIG_MTD_CONCAT
>   defconfigs: remove CONFIG_MTD_PARTITIONS
>   defconfigs: remove CONFIG_MTD_CHAR
>   defconfigs: remove CONFIG_MTD_DEBUG*
> 
>  arch/arm/configs/acs5k_defconfig                   |    3 ---
> [...]
>  arch/unicore32/configs/unicore32_defconfig         |    2 --
>  226 files changed, 364 deletions(-)

Seems like the kind of change that can only be reviewed by a script.

Is there any policy on keeping defconfig files up to date? Because, only
slightly exaggerated, all the defconfig files are outdated, in minor or
major ways, at any given moment.

I seem to remember Greg stating that defconfig files are on their way
out. Did I remember that correctly?  


Paul Bolle

