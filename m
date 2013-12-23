From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 23 Dec 2013 13:21:05 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: kzm9g: add FSI support for DTS
Message-Id: <52B838C1.1080705@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387764079.git.horms+renesas@verge.net.au>
 <3c2a87c85391272b098827e432813c9437e93992.1387764079.git.horms+renesas@verge.net.au>
In-Reply-To: <3c2a87c85391272b098827e432813c9437e93992.1387764079.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 23-12-2013 6:08, Simon Horman wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> This patch support FSI-AK4648 with simple audio card

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 33 ++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)

> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> index 5bb593d..eb8886b 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
[...]
> @@ -226,6 +240,12 @@
>   			};
>   		};
>   	};
> +
> +	ak4648: ak4648@0x12 {

    Perhaps "sound-codec" or "audio-codec" would be a better name; hardware 
specific names are not recommended by ePAPR. And drop "0x" from the address 
part please.

> +		#sound-dai-cells = <0>;
> +		compatible = "asahi-kasei,ak4648";
> +		reg = <0x12>;
> +	};
>   };
>
>   &i2c3 {

WBR, Sergei

