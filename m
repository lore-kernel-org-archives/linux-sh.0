From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 May 2011 07:37:08 +0000
Subject: Re: [PATCH 1/3 v2] sh_mobile_meram: Add clock enable/disble hooks via runtime PM
Message-Id: <20110524073707.GH11986@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1306221381-30083-2-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1306221381-30083-2-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 24, 2011 at 04:16:19PM +0900, Damian Hobson-Garcia wrote:
> @@ -460,11 +461,33 @@ static int sh_mobile_meram_update(struct sh_mobile_meram_info *pdata,
> +int sh_mobile_meram_clk_on(struct sh_mobile_meram_info *pdata)
> +int sh_mobile_meram_clk_off(struct sh_mobile_meram_info *pdata)

[snip]

>  	.meram_update		= sh_mobile_meram_update,
> +	.meram_clk_off		= sh_mobile_meram_clk_off,
> +	.meram_clk_on		= sh_mobile_meram_clk_on,
>  };
>  
Seems like the _clk_off/on functions ought to be static, too.
