From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 19 Dec 2013 22:05:26 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Conditionally select MICREL_PHY
Message-Id: <52B37BAC.4090405@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387153872-8387-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1387153872-8387-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 12/16/2013 03:31 AM, Simon Horman wrote:

> The koelsch board uses has an SH ethernet controller which uses a Micrel
> phy. Select MICREL_PHY for koelsch if SH_ETH is enabled to make use of the
> Micrel-specific phy driver rather than relying on the generic phy driver.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)

> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index f01e878..670238a 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -41,6 +41,7 @@ config MACH_GENMAI
>   config MACH_KOELSCH
>   	bool "Koelsch board"
>   	depends on ARCH_R8A7791
> +	select MICREL_PHY if SH_ETH
>
>   config MACH_KZM9D
>   	bool "KZM9D board"

    Simon, did you initially remove that hunk when committing?

WBR, Sergei

