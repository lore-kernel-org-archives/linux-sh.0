From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 18 May 2013 14:38:21 +0000
Subject: Re: [PATCH 4/9] ARM: shmobile: r8a7790: add clock definitions and aliases for MMCIF and SDHI
Message-Id: <5197925D.3060500@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 17-05-2013 18:55, Guennadi Liakhovetski wrote:

> Add MSTP clock definitions and fix aliases for the two MMCIF and four SDHI
> interfaces on r8a7790 (H2).

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>   arch/arm/mach-shmobile/clock-r8a7790.c |   26 +++++++++++++++++++-------
>   1 files changed, 19 insertions(+), 7 deletions(-)

> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index b393592..53a13b4 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -181,7 +181,7 @@ static struct clk div6_clks[DIV6_NR] = {
>   /* MSTP */
>   enum {
>   	MSTP721, MSTP720,
> -	MSTP304,
> +	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311,

    Should have broken this line here.

> MSTP305, MSTP304,
>   	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
>   	MSTP_NR
>   };

WBR, Sergei


