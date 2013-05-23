From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 23 May 2013 12:47:46 +0000
Subject: Re: [PATCH 06/17 v2] ARM: shmobile: r8a7778: add I2C support
Message-Id: <519E0FF2.2070609@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874ndu4c4n.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874ndu4c4n.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 23-05-2013 7:18, Kuninori Morimoto wrote:

    I still would like to see a proper changelog here. You could just 
copy it from mine I guess...

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index a02efce..87b74a5 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -173,6 +173,31 @@ void __init r8a7778_sdhi_init(int id,
[...]
> +void __init r8a7778_add_i2c_device(int id)
> +{
> +	BUG_ON(id < 0 || id > 3);
> +
> +	platform_device_register_simple(
> +		"i2c-rcar", id,
> +		i2c_resources + (2 * id), 2);

     I've already told you () is superfluous.

WBR, Sergei

