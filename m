From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 12 Oct 2015 12:00:33 +0000
Subject: Re: [RFC v2 2/5] ARM: shmobile: r8a7790: add node for rwdt
Message-Id: <561BA0E1.7010901@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444632876-2672-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1444632876-2672-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 10/12/2015 9:54 AM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   arch/arm/boot/dts/r8a7790.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index a1225e0b437fd0..3daa56e3222303 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -124,6 +124,13 @@
>   		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>   	};
>
> +	wdt0: wdt@e6020000 {

    The ePAPR standard defines the "watchdog" node name for WDTs.

MBR, Sergei

