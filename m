From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Wed, 05 Sep 2012 08:20:49 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: sh73a0: Select ERRATAs in Kconfig
Message-Id: <50470B61.4060101@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1346832708-7369-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1346832708-7369-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I am sorry, I missed subject. This patch is not 1/3, but only one.
The correct subject is:

[PATCH] ARM: shmobile: sh73a0: Select ERRATAs in Kconfig

(2012/09/05 17:11), Tetsuyuki Kobayshi wrote:
> From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> 
> SH73a0 SoC has Cortex-A9 core which revision is r2p8.
> This patch selects ERRATAs for this revision in Kconfig file.
> 
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
>   arch/arm/mach-shmobile/Kconfig |    7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 4cacc2d..a80836c 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -28,6 +28,13 @@ config ARCH_SH73A0
>   	select ARCH_WANT_OPTIONAL_GPIOLIB
>   	select ARM_GIC
>   	select I2C
> +	select ARM_ERRATA_743622
> +	select ARM_ERRATA_751472
> +	select ARM_ERRATA_754322
> +	select ARM_ERRATA_764369
> +	select PL310_ERRATA_588369 if CACHE_PL310
> +	select PL310_ERRATA_727915 if CACHE_PL310
> +	select PL310_ERRATA_769419 if CACHE_PL310
>   
>   config ARCH_R8A7740
>   	bool "R-Mobile A1 (R8A77400)"
> 

