From: Valentine <valentine.barshak@cogentembedded.com>
Date: Fri, 17 Jan 2014 19:24:53 +0000
Subject: Re: [PATCH 1/2] ARM: dts: r8a7790: Add SATA nodes to r8a7790.dtsi
Message-Id: <52D98385.9050600@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/17/2014 09:26 AM, Simon Horman wrote:
> On Tue, Jan 14, 2014 at 09:05:30PM +0400, Valentine Barshak wrote:
>> This adds SATA[01] device nodes to r8a7790.dtsi
>
> I have queued this up with Magnus's Ack and dts: changed to shmobile:
> in the subject. There was a minor conflict which I resolved.
> Please check that the following is correct.

That is correct, thanks.

>
> From: Valentine Barshak <valentine.barshak@cogentembedded.com>
>
> ARM: shmobile: lager: Enable SATA1 in r8a7790-lager.dts
>
> This enables SATA1 in Lager device tree.
> SATA0 is not available on Lager since its
> pinmux is fixed to USB3.0.
>
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 57569cb..1081c5e 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -91,3 +91,7 @@
>   	non-removable;
>   	status = "okay";
>   };
> +
> +&sata1 {
> +	status = "okay";
> +};
>

Thanks,
Val.
