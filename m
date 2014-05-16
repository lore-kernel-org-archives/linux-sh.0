From: Simon Horman <horms@verge.net.au>
Date: Fri, 16 May 2014 23:59:58 +0000
Subject: Re: [PATCH 4/5] ARM: shmobile: Let Genmai multiplatform boot with Genmai DTB
Message-Id: <20140516235957.GB10078@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
 <1400242216-20848-5-git-send-email-wsa@the-dreams.de>
 <CAMuHMdUYW=5mmVakBt2iLX0pDQL9dC-+TB++=U0kLNK--AKZMw@mail.gmail.com>
In-Reply-To: <CAMuHMdUYW=5mmVakBt2iLX0pDQL9dC-+TB++=U0kLNK--AKZMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, May 16, 2014 at 02:25:36PM +0200, Geert Uytterhoeven wrote:
> On Fri, May 16, 2014 at 2:10 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > --- a/arch/arm/mach-shmobile/board-genmai-reference.c
> > +++ b/arch/arm/mach-shmobile/board-genmai-reference.c
> > @@ -42,7 +42,7 @@ static void __init genmai_add_standard_devices(void)
> >  }
> >
> >  static const char * const genmai_boards_compat_dt[] __initconst = {
> > -       "renesas,genmai-reference",
> > +       "renesas,genmai",
> >         NULL,
> >  };
> 
> Regardless of my Acked-by for the series (it was done similarly for other
> boards), I have a more political question: As there's no more board support
> code for "renesas,genmai-reference", this means new kernels won't boot
> using an old r7s72100-genmai-reference.dts?

Yes, that is the implication of the way things have been done.
Its not ideal but as -reference has been considered a developers
playground it seems reasonable.
