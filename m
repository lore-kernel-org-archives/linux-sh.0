From: Chanwoo Choi <cw00.choi@samsung.com>
Date: Thu, 05 Jan 2017 10:12:29 +0000
Subject: Re: [PATCH] cpufreq: Remove CONFIG_CPU_FREQ_STAT_DETAILS config option
Message-Id: <586E1C0D.20102@samsung.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary_(ID_Cj19Agd5eCCBWYTkjpMRIw)"
List-Id: <linux-sh.vger.kernel.org>
References: <CGME20170105082939epcas4p4b494945ce55c949dc7a030ebf9dbdd4c@epcas4p4.samsung.com>
 <d4299228a500a889c2b4b9e305674f3d1ea9ae06.1483604760.git.viresh.kumar@linaro.org>
In-Reply-To: <d4299228a500a889c2b4b9e305674f3d1ea9ae06.1483604760.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org

This is a multi-part message in MIME format.

--Boundary_(ID_Cj19Agd5eCCBWYTkjpMRIw)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Viresh,

On 2017년 01월 05일 17:27, Viresh Kumar wrote:
> This doesn't have any benefit apart from saving a small amount of memory
> when it is disabled. The ifdef hackery in the code makes it dirty
> unnecessarily.
> 
> Clean it up by removing the Kconfig option completely. Few defconfigs
> are also updated and CONFIG_CPU_FREQ_STAT_DETAILS is replaced with
> CONFIG_CPU_FREQ_STAT now in them, as users wanted stats to be enabled.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/configs/exynos_defconfig         |  2 +-
>  arch/arm/configs/multi_v5_defconfig       |  2 +-
>  arch/arm/configs/multi_v7_defconfig       |  2 +-
>  arch/arm/configs/mvebu_v5_defconfig       |  2 +-
>  arch/arm/configs/pxa_defconfig            |  2 +-
>  arch/arm/configs/shmobile_defconfig       |  2 +-
>  arch/mips/configs/lemote2f_defconfig      |  1 -
>  arch/powerpc/configs/ppc6xx_defconfig     |  1 -
>  arch/sh/configs/sh7785lcr_32bit_defconfig |  2 +-
>  drivers/cpufreq/Kconfig                   |  8 --------
>  drivers/cpufreq/cpufreq_stats.c           | 14 --------------
>  11 files changed, 7 insertions(+), 31 deletions(-)


I agree. Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

--Boundary_(ID_Cj19Agd5eCCBWYTkjpMRIw)
Content-type: text/x-vcard; CHARSET=EUC-KR; name=cw00_choi.vcf
Content-transfer-encoding: base64
Content-disposition: attachment; filename=cw00_choi.vcf

bnVsbA0K

--Boundary_(ID_Cj19Agd5eCCBWYTkjpMRIw)--
