From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 16 May 2015 18:18:30 +0000
Subject: Re: [PATCH v2] sh-sci: Get register size from platform data
Message-Id: <555789F6.6000007@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431788588-14974-2-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1431788588-14974-2-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 05/16/2015 06:03 PM, Yoshinori Sato wrote:

> There is much implement of SCI,

    Many implementations, you mean?

> So the register size should be acquired from platform data.

    You're not acquiring them from the platform data, you're using platform 
device resources for that.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

[...]
> @@ -2207,6 +2198,7 @@ static int sci_init_single(struct platform_device *dev,
>   		return -ENOMEM;
>
>   	port->mapbase = res->start;
> +	sci_port->reg_size = res->end - res->start + 1;

    Use resource_size(res) instead, please.

[...]

WBR, Sergei

