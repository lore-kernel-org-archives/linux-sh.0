From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 18 Mar 2013 17:13:19 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: Add PCIe clock support
Message-Id: <51474B2F.7040608@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363624732-24660-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1363624732-24660-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 18-03-2013 20:38, Phil Edworthy wrote:

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> Depends on "r8a7779: Add Display Unit clock support"

>   arch/arm/mach-shmobile/clock-r8a7779.c |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
> index 9ea6087..a017418 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
[...]
> @@ -182,6 +184,7 @@ static struct clk_lookup lookups[] = {
>   	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
>   	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP320]), /* SDHI3 */
>   	CLKDEV_DEV_ID("rcar-du.0", &mstp_clks[MSTP103]), /* DU */
> +	CLKDEV_DEV_ID("rcar-pcie.0", &mstp_clks[MSTP116]), /* PCIe */

   Hm, why this name? Is there going to be a driver somewhere in drivers/pci/, 
and is there goiung to be more than one instance of PCIe?

WBR, Sergei

