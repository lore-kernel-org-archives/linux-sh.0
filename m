From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 02 Feb 2015 11:06:15 +0000
Subject: Re: [RFC 2/5] ARM: shmobile: r8a7790: add node for rwdt
Message-Id: <54CF5A27.8000209@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 2/1/2015 5:47 PM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   arch/arm/boot/dts/r8a7790.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 999d437496de..1fea7cb6dcd8 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -123,6 +123,13 @@
>   		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>   	};
>
> +	wdt0: wdt@e6020000 {

    ePAPR section 2.2.2 says to name it "watchdog@e6020000".

WBR, Sergei

