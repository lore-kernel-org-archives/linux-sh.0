From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 09 Feb 2015 18:03:57 +0000
Subject: Re: [PATCH v2 10/15] ARM: shmobile: r8a7778: add sound to DT
Message-Id: <54D8F68D.7000100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423497763-3450-11-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1423497763-3450-11-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 02/09/2015 07:02 PM, Ulrich Hecht wrote:

> Adds an entry for an R-Car Gen. 1 sound controller.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>   arch/arm/boot/dts/r8a7778.dtsi | 55 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index 98ad685..8700e2e 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -220,6 +220,61 @@
>   		status = "disabled";
>   	};
>
> +	rcar_sound: rcar_sound@ffd90000 {

    Just "sound@ffd90000" please, in order to comply with ePAPR.

[...]

WBR, Sergei

