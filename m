From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 21 Jan 2015 17:01:41 +0000
Subject: Re: [PATCH 11/11] ARM: shmobile: r8a7778: enable multiplatform target
Message-Id: <54BFDB75.9030901@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-12-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-12-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/21/2015 07:21 PM, Ulrich Hecht wrote:

> Adds config option and enables DTB building.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

[...]

> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 2d0387e..455eb4b 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -62,6 +62,10 @@ config ARCH_R8A7740
>   	select ARCH_RMOBILE
>   	select RENESAS_INTC_IRQPIN
>
> +config ARCH_R8A7778
> +	bool "R-Car M1 (R8A77780)"

    It's R-Car M1A (R8A77781), in fact. R8A77780 is a SH based SoC (R-Car M1S).
Couldn't you simply copy from the existing Kconfig entry?

WBR, Sergei

