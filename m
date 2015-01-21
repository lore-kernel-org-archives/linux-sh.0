From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 21 Jan 2015 16:51:16 +0000
Subject: Re: [PATCH 07/11] ARM: shmobile: bockw: add pins and clock to ethernet controller in DT
Message-Id: <54BFD904.70003@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 01/21/2015 07:20 PM, Ulrich Hecht wrote:

> Completes the Ethernet controller DT entry with pin control and clock
> information.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>   arch/arm/boot/dts/r8a7778-bockw.dts | 9 +++++++++
>   1 file changed, 9 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
> index 280a922..52086fe 100644
> --- a/arch/arm/boot/dts/r8a7778-bockw.dts
> +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> @@ -47,8 +47,12 @@
>   	};
>
>   	ethernet@18300000 {
> +		pinctrl-0 = <&ether_pins>;
> +		pinctrl-names = "default";
> +

    What Ether pins? This is an external LAN controller!

>   		compatible = "smsc,lan9220", "smsc,lan9115";

    See this "compatible"?

>   		reg = <0x18300000 0x1000>;
> +		clocks = <&mstp1_clks R8A7778_CLK_ETHER>;

    What, again?

WBR, Sergei

