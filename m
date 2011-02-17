From: Simon Horman <horms@verge.net.au>
Date: Thu, 17 Feb 2011 00:41:59 +0000
Subject: Re: [PATCH 2/2] ARM: mach-shmobile: mackerel: fixup memory
Message-Id: <20110217004158.GA27179@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 15, 2011 at 02:03:53PM +0900, Kuninori Morimoto wrote:
> Current makerel had issue which couldn't boot sometimes.
> This patch fixup it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Morimoto-san,

I have verified that this boots on my Mackerel.
I have also looked over the register changes
and they seem reasonable to me.

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  .../mach-shmobile/include/mach/head-mackerel.txt   |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/include/mach/head-mackerel.txt b/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
> index efd3687..3029aba 100644
> --- a/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
> +++ b/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
> @@ -6,13 +6,10 @@ LIST "RWT Setting"
>  EW 0xE6020004, 0xA500
>  EW 0xE6030004, 0xA500
>  
> -DD 0x01001000, 0x01001000
> -
>  LIST "GPIO Setting"
>  EB 0xE6051013, 0xA2
>  
>  LIST "CPG"
> -ED 0xE6150080, 0x00000180
>  ED 0xE61500C0, 0x00000002
>  
>  WAIT 1, 0xFE40009C
> @@ -37,6 +34,9 @@ ED 0xE615002C, 0x93000040
>  
>  WAIT 1, 0xFE40009C
>  
> +LIST "SUB/USBClk"
> +ED 0xE6150080, 0x00000180
> +
>  LIST "BSC"
>  ED 0xFEC10000, 0x00E0001B
>  
> @@ -53,7 +53,7 @@ ED 0xFE400048, 0x20C18505
>  ED 0xFE40004C, 0x00110209
>  ED 0xFE400010, 0x00000087
>  
> -WAIT 10, 0xFE40009C
> +WAIT 30, 0xFE40009C
>  
>  ED 0xFE400084, 0x0000003F
>  EB 0xFE500000, 0x00
> @@ -84,7 +84,7 @@ ED 0xE6150004, 0x80331050
>  
>  WAIT 1, 0xFE40009C
>  
> -ED 0xE6150354, 0x00000002
> +ED 0xFE400354, 0x01AD8002

I don't see 0xE6150354 in the processor manual. Was it a typo?

>  LIST "SCIF0 - Serial port for earlyprintk"
>  EB 0xE6053098, 0x11
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
