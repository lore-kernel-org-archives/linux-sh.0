From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Sep 2014 00:23:25 +0000
Subject: Re: [PATCH] ARM: shmobile: Add manufacturer for KZM boards
Message-Id: <20140917002325.GC27426@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410897436-28107-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1410897436-28107-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 16, 2014 at 09:57:16PM +0200, Geert Uytterhoeven wrote:
> KZM-A9-Dual and KZM-A9-GT are manufactured by Kyoto Microcomputer Co.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.

> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index 5d1c5c0085dc7871..51147cb5c036599a 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -53,11 +53,11 @@ Boards:
>      compatible = "renesas,henninger", "renesas,r8a7791"
>    - Koelsch (RTP0RC7791SEB00010S)
>      compatible = "renesas,koelsch", "renesas,r8a7791"
> -  - KZM9D
> +  - Kyoto Microcomputer Co. KZM-A9-Dual
>      compatible = "renesas,kzm9d", "renesas,emev2"
> -  - KZM-A9-GT
> +  - Kyoto Microcomputer Co. KZM-A9-GT
>      compatible = "renesas,kzm9g", "renesas,sh73a0"
> -  - KZM-A9-GT - Reference Device Tree Implementation
> +  - Kyoto Microcomputer Co. KZM-A9-GT - Reference Device Tree Implementation
>      compatible = "renesas,kzm9g-reference", "renesas,sh73a0"
>    - Lager (RTP0RC7790SEB00010S)
>      compatible = "renesas,lager", "renesas,r8a7790"
> -- 
> 1.9.1
> 
