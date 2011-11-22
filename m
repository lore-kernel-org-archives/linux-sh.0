From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 22 Nov 2011 08:26:45 +0000
Subject: Re: [PATCH 0/2] sh: bugfix: sh7724/sh7723 boot on paul/hwblk
Message-Id: <Pine.LNX.4.64.1111220918570.29085@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <87zkfoyi9l.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zkfoyi9l.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san

On Mon, 21 Nov 2011, Kuninori Morimoto wrote:

> 
> Hi Paul
> Cc Guennadi
> 
> These are bugfix patches for sh7724/sh7723 boot on paul/hwblk branch
> 
> Kuninori Morimoto (2):
>       sh: sh7724.h: bugfix: remove unused clock index
>       sh: sh7723.h: bugfix: remove unused clock index
> 
> Now it doesn't use hwblk, but it still have un-needed HWBLK_xxx index
> which are not set by SH_CLK_MSTP32() macro.
> So, sh7724/sh7723 boot will be crash, because clk.enable_reg = NULL on such clocks.

Thanks for the patches! It is certainly good to remove unused code / data, 
but could you please explain a bit what exactly crashes you observed and 
how you triggered them? I tested my patches on ecovec and migor without 
any problems.

As for sh7722 - if you tell me, how to reproduce the problem, I can either 
test your patch, removing those unused HWBLK_* indices, I could prepare 
one myself.

Thanks
Guennadi

> I tested it on Ecovec (sh7724) and ALGO (sh7723) board.
> I don't have sh7722 board now.
> 
> Best regards
> ---
> Kuninori Morimoto

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
