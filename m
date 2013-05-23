From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 23 May 2013 12:50:10 +0000
Subject: Re: [PATCH 07/17 v2] ARM: shmobile: r8a7778: add HSPI support
Message-Id: <519E1082.8080903@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738te4c3u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738te4c3u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 23-05-2013 7:19, Kuninori Morimoto wrote:

     I would like to see a proper changelog here. The patch is not as 
trivial as to only have the subject.

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]

> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 87b74a5..8f011cb 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -198,6 +198,29 @@ void __init r8a7778_add_i2c_device(int id)
[...]
> +void __init r8a7778_add_hspi_device(int id)
> +{
> +	BUG_ON(id < 0 || id > 2);
> +
> +	platform_device_register_simple(
> +		"sh-hspi", id,
> +		hspi_resources + (2 * id), 2);

    () not needed.

WBR, Sergei

