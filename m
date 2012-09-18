From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Sep 2012 02:24:37 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: bugfix: correct mmcif interrupt settings
Message-Id: <20120918022433.GA11172@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1346915976-14079-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1346915976-14079-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 06, 2012 at 05:47:14PM -0700, Kuninori Morimoto wrote:
> 
> Hi Kobayshi-san
> 
> > From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> > 
> > Correct interrupt settings of sh_mmc:int and sh_mmc:error in board-kzm9g.c.
> > 
> > Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> > ---
> > Hello, morimoto-san
> > 
> > I found small bug in interrpt setting of sh_mmc in board-kzm9g.c.
> > According to SoC document, there are 2 interrupts for sh_mmc and smaller vector id is error. But the setting in board-kzm9g seems wrong.
> > 
> > Actually these 2 interrupts use the same interrupt handler. So this patch only affects the output of /proc/interrpts.
> > 
> > before this patch:
> >   ...
> > 172:          3          0       GIC  sh_mmc:int
> > 173:       9504          0       GIC  sh_mmc:error
> >   ...
> > 
> > after this patch:
> >   ...
> > 172:          3          0       GIC  sh_mmc:error
> > 173:       9454          0       GIC  sh_mmc:int
> >   ...
> > 
> > Morimoto-san, could you verify this?
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, applied to fixes.
I will try and get this included in 3.6.
