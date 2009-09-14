From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 14 Sep 2009 07:21:20 +0000
Subject: Re: [PATCH] sh: kfr2r09: add the reason to change PLL/FLL
Message-Id: <u7hw2f0un.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <utyz9kg1v.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <utyz9kg1v.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> >  LIST "setup clocks"
> > +LIST "To avoid the frequency of RF, PLL and FLL are changed"
> > +LIST "This frequency influences the reception sensitivity"
> >  ED 0xa4150004, 0x00000050
> >  ED 0xa4150000, 0x91053508
> >  WAIT 1
> 
> I'm not really sure what you mean here. Do you mean to say that PLL and
> FLL are adjusted for optimal RF reception?

Yes.

Best regards
--
Kuninori Morimoto
 
