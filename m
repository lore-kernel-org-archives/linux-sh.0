From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Date: Tue, 11 Jun 2019 10:00:25 +0000
Subject: Re: [PATCH] sh: dma: Add missing IS_ERR test
Message-Id: <alpine.LNX.2.21.99.1906111147340.3086@5HSWXM1>
List-Id: <linux-sh.vger.kernel.org>
References: <20190607115404.4557-1-embedded24@evers-fischer.de> <b731167e-6285-4fe0-e280-b2626b8efe44@cogentembedded.com>
In-Reply-To: <b731167e-6285-4fe0-e280-b2626b8efe44@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>, ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Sergei,

thanks for your feedback.

On Sat, 8 Jun 2019, Sergei Shtylyov wrote:

> Hello!
> 
> On 07.06.2019 14:54, Rolf Evers-Fischer wrote:
> 
> > get_dma_channel may return ERR_PTR, so a check is added.
> > 
> > Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
> > ---
> >   arch/sh/drivers/dma/dma-api.c   | 20 +++++++++++++++++++-
> >   arch/sh/drivers/dma/dma-sysfs.c |  2 +-
> >   2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
> > index ab9170494dcc..5d6f1a46cc5e 100644
> > --- a/arch/sh/drivers/dma/dma-api.c
> > +++ b/arch/sh/drivers/dma/dma-api.c
> > @@ -94,7 +94,7 @@ int get_dma_residue(unsigned int chan)
> >   	struct dma_info *info = get_dma_info(chan);
> >   	struct dma_channel *channel = get_dma_channel(chan);
> >   -	if (info->ops->get_residue)
> > +	if (!IS_ERR(channel) && (info->ops->get_residue))
> 
>    Extra parens not needed here.
> 
> [...]

I agree with you. They should better be removed.

Kind regards,
 Rolf
