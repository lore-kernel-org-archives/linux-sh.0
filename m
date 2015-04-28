From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 28 Apr 2015 11:45:53 +0000
Subject: Re: [PATCH 1/3] spi: Re-do the returning value of rspi_dma_check_then_transfer
Message-Id: <553F72F1.9010300@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp> <1430200551-20708-2-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1430200551-20708-2-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

On 4/28/2015 8:55 AM, Cao Minh Hiep wrote:

> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

> To reduce indentation and complex of code, insteeds of returning zero,

    Complexity?

> the function rspi_dma_check_then_transfer should be returned

    Returning? Or perhaps just "return", without "be"?

> rspi_dma_transfer directly after checking error.

> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> ---
>   drivers/spi/spi-rspi.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)

[...]

WBR, Sergei

