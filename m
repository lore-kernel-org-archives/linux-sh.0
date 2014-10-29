From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 29 Oct 2014 11:22:59 +0000
Subject: Re: [PATCH v3 0/9] R-Car Gen2 DMA Controller driver
Message-Id: <7382991.mN71S6k9c6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tuesday 28 October 2014 17:04:01 Kuninori Morimoto wrote:
> Hi Laurent, Simon
> 
> > > On Lager board + SDHI
> > > 
> > > Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Thank you.
> > 
> > > Current SDHI driver + DMAC is working, but super slow,
> > > especially, write case....
> > 
> > *sigh* I'll test that.
> 
> Maybe this is SDHI side issue (?)
> Buswidth/clock/setting etc etc etc...
> No one used SDHI + DMA in DT and in R-Car Gen2 today.

I've performed my tests using a 2 bytes bus width. Using a 4 bytes bus width I 
get similar performances for PIO and DMA. 16 bytes and 32 bytes bus widths 
don't work out of the box, they would need more work.

> So, I guess it is very safety if we can ignore SDHI + DMA in upstream
> -> Simon ?

-- 
Regards,

Laurent Pinchart
