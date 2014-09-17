From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 17 Sep 2014 19:03:12 +0000
Subject: Re: [PATCH 1/8] ARM: shmobile: r8a7779: Add DU node to device tree
Message-Id: <5419DAF0.1010305@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410963073-3176-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410963073-3176-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 9/17/2014 5:11 PM, Laurent Pinchart wrote:

> Add the DU device with a disabled state. Boards that want to enable the
> DU need to specify the output topology

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/boot/dts/r8a7779.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index 7cfba9a..f4c03cc 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -379,6 +379,30 @@
>   		status = "disabled";
>   	};
>
> +	du: du@fff80000 {

    Perhaps the "display" name from the ePAPR section 2.2.2 fits here?

WBR, Sergei

