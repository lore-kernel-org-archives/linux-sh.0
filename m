From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 08 Aug 2013 11:11:39 +0000
Subject: Re: [PATCH v2 2/9] ARM: shmobile: r8a7790: Constify platform data and resources
Message-Id: <52037CEB.2020206@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375916192-22647-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375916192-22647-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 08-08-2013 2:56, Laurent Pinchart wrote:

> Platform data and resources for core devices are kmemdup()ed when the
> corresponding devices are registered and can thus be declared as const.
> Do so.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/mach-shmobile/setup-r8a7790.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)

> diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
> index d0f5c9f..988266e 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> @@ -31,17 +31,18 @@
>   #include <mach/r8a7790.h>
>   #include <asm/mach/arch.h>
>
> -static struct resource pfc_resources[] __initdata = {
> +static const struct resource pfc_resources[] __initdata = {

    I think *const* data should be annotated with '__initconst', no?

WBR, Sergei

