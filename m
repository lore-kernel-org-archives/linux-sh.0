From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 21 Aug 2013 18:58:47 +0000
Subject: Re: [PATCH 2/2] SolutionEngine7724: fix Ether support
Message-Id: <52150DE7.2060309@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308180213.23296.sergei.shtylyov@cogentembedded.com> <201308180219.09528.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308180219.09528.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, davem@davemloft.net

Hello.

On 08/18/2013 02:19 AM, Sergei Shtylyov wrote:

> The Ether platform data is behind the declaration of 'struct sh_eth_plat_data'
> as it's lacking the initializers for the 'register_type' and 'phy_interface'
> fields -- it means they'll be implicitly and wrongly set to SH_ETH_REG_GIGABIT
> and PHY_INTERFACE_MODE_NA. Initialize the fields explicitly and fix off-by-one
> error in the Ether memory resource end, while at it...

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: stable@vger.kernel.org

> ---
>   arch/sh/boards/mach-se/7724/setup.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

> Index: net/arch/sh/boards/mach-se/7724/setup.c
> =================================> --- net.orig/arch/sh/boards/mach-se/7724/setup.c
> +++ net/arch/sh/boards/mach-se/7724/setup.c
[...]
> @@ -377,6 +377,8 @@ static struct resource sh_eth_resources[
>   static struct sh_eth_plat_data sh_eth_plat = {
>   	.phy = 0x1f, /* SMSC LAN8187 */
>   	.edmac_endian = EDMAC_LITTLE_ENDIAN,
> +	.register_type = SH_ETH_REG_FAST_SH4,
> +	.phy_interace = PHY_INTERFACE_MODE_MII,

     Darn, "interace" here too, this time spotted by myself. Obviously, I did 
copy&paste the same mistake.

WBR, Sergei

