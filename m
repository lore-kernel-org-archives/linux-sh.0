From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 08 Aug 2013 11:39:06 +0000
Subject: Re: [PATCH v2 8/9] ARM: shmobile: lager: Add Display Unit support
Message-Id: <5203835A.1040208@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375916192-22647-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375916192-22647-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 08-08-2013 2:56, Laurent Pinchart wrote:

> Only the VGA output is currently supported.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/mach-shmobile/board-lager.c | 42 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)

> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index 76363f9..cb2457e 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
[...]
> +static const struct rcar_du_platform_data lager_du_pdata __initdata = {

    '__initconst'?

> +	.encoders = lager_du_encoders,
> +	.num_encoders = ARRAY_SIZE(lager_du_encoders),
> +};
> +

WBR, Sergei

