From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Fri, 08 May 2015 01:35:03 +0000
Subject: Re: [PATCH 1/1 v2] spi: Re-do the returning value of rspi_dma_check_then_transfer
Message-Id: <554C12C7.4030302@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1430359932-13245-1-git-send-email-cm-hiep@jinso.co.jp> <1430359932-13245-2-git-send-email-cm-hiep@jinso.co.jp> <20150507125744.GX15510@sirena.org.uk>
In-Reply-To: <20150507125744.GX15510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Mark-san

On 2015年05月07日 21:57, Mark Brown wrote:
> On Thu, Apr 30, 2015 at 11:12:12AM +0900, Cao Minh Hiep wrote:
>> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>>
>> To reduce indentation and complexity of code, insteeds of returning zero
>> the function rspi_dma_check_then_transfer should return rspi_dma_transfer
>> directly after checking error.
> Applied, thanks.  Please use subject lines reflecting the style for the
> subsystem and don't send cover letters for single patches - if there's
> any content in there it's usually a sign that the changelog is not
> detailed enough.
Thank you!, I understood.

Hiep.

