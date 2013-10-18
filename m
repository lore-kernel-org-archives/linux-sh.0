From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 18 Oct 2013 11:54:16 +0000
Subject: Re: [PATCH 2/2 v2] ARM: shmobile: Lager:add SPI FLASH support on QSPI
Message-Id: <52612168.9070106@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1382074384-24975-3-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1382074384-24975-3-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 18-10-2013 9:33, Cao Minh Hiep wrote:

> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

> This patch enables Spansion S25FL512SAGMFIG11 chip on QSPI,
> Add support for the QSPI interface on Lager.

> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> ---
>   arch/arm/mach-shmobile/board-lager.c |   69 ++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)

> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index 78a31b6..5d69cde 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
[...]
> @@ -165,6 +170,67 @@ static const struct resource ether_resources[] __initconst = {
[...]
> +void __init r8a7790_add_qspi_device(struct rspi_plat_data *pdata)

    You apparently forgot to change the name prefix to 'lager_'. Also, there's 
no dire need in this function, you can register the QSPI device right in 
lager_add_standard_devices().

> +{
> +	platform_device_register_resndata(

    You're breaking the line to early, I think.

> +		&platform_bus, "qspi", 0,
> +		qspi_resources, ARRAY_SIZE(qspi_resources),
> +		pdata, sizeof(*pdata));
> +}
> +
>   static const struct pinctrl_map lager_pinctrl_map[] = {
>   	/* DU (CN10: ARGB0, CN13: LVDS) */
>   	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",

WBR, Sergei

