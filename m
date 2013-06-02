From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 02 Jun 2013 19:41:00 +0000
Subject: Re: [PATCH 1/3 v3] ARM: shmobile: r8a7778: add I2C support
Message-Id: <51AB9FCC.3090909@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 05/28/2013 08:22 AM, Kuninori Morimoto wrote:

> Add a platform device for the r8a7778 I2C.
>
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[...]
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 9191acc..eaa6b06 100644
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

     I don't understand why are you wrapping the lines so early here 
(this remark
relates to all the series). This is not a standard way to indent the 
function call
continuation lines, normally you should align them to the next character 
after (.

WBR, Sergei

