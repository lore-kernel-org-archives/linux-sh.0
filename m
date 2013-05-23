From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 23 May 2013 13:09:59 +0000
Subject: Re: [PATCH 17/17 v2] ARM: shmobile: r8a7778: rename sdhi device additional function
Message-Id: <519E1527.1060100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87obc22xbi.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87obc22xbi.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 23-05-2013 7:24, Kuninori Morimoto wrote:

> Other device additional function are r8a7778_add_xxx_device()
> sdhi also follow it.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    Thanks for the patch. I didn't find time to do it.

> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 3e128c3..749d886 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -162,7 +162,7 @@ static struct resource sdhi_resources[] __initdata = {
>   	DEFINE_RES_IRQ(gic_iid(0x76)),
>   };
>
> -void __init r8a7778_sdhi_init(int id,
> +void __init r8a7778_add_sdhi_device(int id,
>   			      struct sh_mobile_sdhi_info *info)

    You should have realigned the second line below *int* on the first.

WBR, Sergei

