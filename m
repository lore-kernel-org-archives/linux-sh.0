From: Tejun Heo <tj@kernel.org>
Date: Tue, 25 Mar 2014 19:13:24 +0000
Subject: Re: [PATCH] ata: limit sata_rcar host driver to ARCH_SHMOBILE
Message-Id: <20140325191324.GA3279@htj.dyndns.org>
List-Id: <linux-sh.vger.kernel.org>
References: <9835622.nRa3VdL61G@amdc1032>
In-Reply-To: <9835622.nRa3VdL61G@amdc1032>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 25, 2014 at 08:10:27PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Limit sata_rcar host driver to ARCH_SHMOBILE as Renesas R-Car SATA
> support is specific to Renesas SoCs and the driver to work requires
> suitable device tree node (or platform device) to be defined.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/ata/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: b/drivers/ata/Kconfig
> =================================> --- a/drivers/ata/Kconfig	2014-03-25 19:52:31.952327027 +0100
> +++ b/drivers/ata/Kconfig	2014-03-25 19:57:21.104322097 +0100
> @@ -298,6 +298,7 @@ config SATA_PROMISE
>  
>  config SATA_RCAR
>  	tristate "Renesas R-Car SATA support"
> +	depends on ARCH_SHMOBILE

COMPILE_TEST?

-- 
tejun
