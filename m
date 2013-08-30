From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 30 Aug 2013 17:35:15 +0000
Subject: Re: [RFC 08/10] ARM: shmobile: r8a7790: lager: i2c support
Message-Id: <5220D7D3.8000002@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-9-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-9-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 08/30/2013 04:37 PM, Ulrich Hecht wrote:

> Enables the four i2c busses on the Lager board.

> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> ---
>   arch/arm/mach-shmobile/board-lager.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)

> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index 4c3e694..c6b5f21 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
[...]
> @@ -220,6 +243,15 @@ static void __init lager_add_standard_devices(void)
>   					  &ether_pdata, sizeof(ether_pdata));
>
>   	lager_add_du_device();
> +
> +	r8a7790_add_i2c_device(0, &i2c_pdata);
> +	r8a7790_add_i2c_device(1, &i2c_pdata);
> +	r8a7790_add_i2c_device(2, &i2c_pdata);
> +	r8a7790_add_i2c_device(3, &i2c_pdata);
> +
> +	/* I2C channels 0 and 3 are wired to external connectors; channel 1
> +	   has only one device (da9063) for which no driver exists. */

    The preferred kernel multi-line comment style is this:

/*
  * bla
  * bla
  */

WBR, Sergei

