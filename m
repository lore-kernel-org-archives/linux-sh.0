From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Date: Tue, 11 Jun 2019 10:20:20 +0000
Subject: Re: [PATCH] sh: dma: Add missing IS_ERR test
Message-Id: <alpine.LNX.2.21.99.1906111200560.3086@5HSWXM1>
List-Id: <linux-sh.vger.kernel.org>
References: <20190607115404.4557-1-embedded24@evers-fischer.de> <CAMuHMdVGhd3KfRq9F+-Qzc7q5kJyczG1RRQDpgs4FqJpPwK4QA@mail.gmail.com>
In-Reply-To: <CAMuHMdVGhd3KfRq9F+-Qzc7q5kJyczG1RRQDpgs4FqJpPwK4QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



On Sat, 8 Jun 2019, Geert Uytterhoeven wrote:
Hi Geert,

thank you for your reply and your additional findings.

> Hi Rolf,
> 
> Thanks for your patch!
> 
> On Fri, Jun 7, 2019 at 2:04 PM Rolf Evers-Fischer
> <embedded24@evers-fischer.de> wrote:
> > get_dma_channel may return ERR_PTR, so a check is added.
> 
> It may also return NULL...

Good catch. I must have missed this.

> 
> > --- a/arch/sh/drivers/dma/dma-api.c
> > +++ b/arch/sh/drivers/dma/dma-api.c
> > @@ -94,7 +94,7 @@ int get_dma_residue(unsigned int chan)
> >         struct dma_info *info = get_dma_info(chan);
> >         struct dma_channel *channel = get_dma_channel(chan);
> >
> > -       if (info->ops->get_residue)
> > +       if (!IS_ERR(channel) && (info->ops->get_residue))
> >                 return info->ops->get_residue(channel);
> 
> ... in which case .get_residue() may crash, as some implementations
> dereference the passed channel pointer.
> 
> Hence !IS_ERR_OR_NULL()?

Yes, in fact. IS_ERR_OR_NULL is the better choice here. 
I will resend a reworked patch immediately.

> 
> I didn't check the other callers.

Well, I did. And I found that none of the implementations checks the 
passed pointer. However, no in-tree driver is using the .extend() op, but 
as long as we don't know, if any out-of-tree drivers are using it without 
any additional check, I would prefer to check for NULL or error in 
dma_extend() as well.

Kind regards,
 Rolf
