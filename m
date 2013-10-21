From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 21 Oct 2013 13:13:17 +0000
Subject: Re: [PATCH 1/2 v3] ARM: shmobile: r8a7790: add QSPI support
Message-Id: <5265286D.2080505@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1382326020-10558-2-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1382326020-10558-2-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 10/21/2013 07:26 AM, Cao Minh Hiep wrote:

> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

> Adds support for QSPI on the r8a7790.

> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> ---
>   arch/arm/mach-shmobile/clock-r8a7790.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index a64f965..ba6f258 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -182,7 +182,7 @@ static struct clk div6_clks[DIV6_NR] = {
>
>   /* MSTP */
>   enum {
> -	MSTP931, MSTP930, MSTP929, MSTP928,
> +	MSTP931, MSTP930, MSTP929, MSTP928, MSTP917,

    Sorry for not mentioning it before but MSTP917 should be on a line of its own.

>   	MSTP813,
>   	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
>   	MSTP717, MSTP716,

WBR, Sergei

