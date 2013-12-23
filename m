From: Simon Horman <horms@verge.net.au>
Date: Mon, 23 Dec 2013 00:56:30 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: koelsch-reference: (1+1)GiB memory in DT
Message-Id: <20131223005630.GL12239@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387704444-750-3-git-send-email-takasi-y@ops.dti.ne.jp>
In-Reply-To: <1387704444-750-3-git-send-email-takasi-y@ops.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 22, 2013 at 06:27:24PM +0900, takasi-y@ops.dti.ne.jp wrote:
> From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> 
> Fix dts to have memory 1GiB @ 0_4000_0000 + 1GiB @ 2_0000_0000
> according to Koelsch's hardware manual.
> 
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> ---
>  arch/arm/boot/dts/r8a7791-koelsch-reference.dts |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Hi Yoshii-san,

r8a7791-koelsch-reference.dts is being removed so there
is no need to update this file any more.

> diff --git a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
> index 588ca17..99319e7 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
> @@ -23,7 +23,12 @@
>  
>  	memory@40000000 {
>  		device_type = "memory";
> -		reg = <0 0x40000000 0 0x80000000>;
> +		reg = <0 0x40000000 0 0x40000000>;
> +	};
> +
> +	memory@200000000 {
> +		device_type = "memory";
> +		reg = <2 0x00000000 0 0x40000000>;
>  	};
>  
>  	lbsc {
> -- 
> 1.7.9.5
> 
