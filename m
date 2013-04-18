From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 18 Apr 2013 22:39:54 +0000
Subject: Re: [PATCH] ARM: shmobile: marzen: keep local function as static
Message-Id: <5170763A.3030105@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87haj4s5yw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87haj4s5yw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/18/2013 10:33 AM, Kuninori Morimoto wrote:

> marzen_init_late() should be static
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/board-marzen.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index fac9e0f..ff8111b 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
> @@ -350,7 +350,7 @@ static struct platform_device *marzen_late_devices[] __initdata = {
>   	&ohci1_device,
>   };
>   
> -void __init marzen_init_late(void)
> +static void __init marzen_init_late(void)

    Grr, I'm killing this function with my R8A7779 USB patchset!
You've only caused me to respin it extra time... although R8A7778
patchset needed a respin too. :-(

WBR, Sergei

