From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Thu, 30 Apr 2015 00:33:38 +0000
Subject: Re: [PATCH 1/3] spi: Re-do the returning value of rspi_dma_check_then_transfer
Message-Id: <55417862.4010800@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp> <1430200551-20708-2-git-send-email-cm-hiep@jinso.co.jp> <553F72F1.9010300@cogentembedded.com>
In-Reply-To: <553F72F1.9010300-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Sergei-san,

>> To reduce indentation and complex of code, insteeds of returning zero,
>
>    Complexity?
>

>> the function rspi_dma_check_then_transfer should be returned
>
>    Returning? Or perhaps just "return", without "be"?
>

Thanks for pointing this out. I'll update it.


Hiep.

