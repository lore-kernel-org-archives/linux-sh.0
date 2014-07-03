From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 03 Jul 2014 17:25:28 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7791: add CAN DT support
Message-Id: <53B59208.703@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407030239.15921.sergei.shtylyov@cogentembedded.com>
 <201407030243.25237.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407030243.25237.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 07/03/2014 02:43 AM, Sergei Shtylyov wrote:

> Define the generic R8A7791 parts of the CAN0/1 device nodes.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
>   arch/arm/boot/dts/r8a7791.dtsi |   16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

> Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
> =================================> --- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7791.dtsi
> @@ -518,6 +518,22 @@
>   		status = "disabled";
>   	};
>
> +	can0: can@e6e80000 {
> +		compatible = "renesas,rcar-can";

    Oops, this ain't gonna fly with the current CAN driver patch... :-(
I'll repost.

WBR, Sergei

