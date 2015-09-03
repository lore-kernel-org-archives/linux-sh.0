From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 03 Sep 2015 00:11:57 +0000
Subject: Re: [PATCH 8/9] sh-pfc: Initial R8A7795 PFC support
Message-Id: <87si6wqs9u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wpw9jn3i.wl%kuninori.morimoto.gx@renesas.com>
	<878u8pjmfb.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdW58Z7BKpADWCz_ofoxn_gtjvaGLCr=9r2-OHzPo=4ugA@mail.gmail.com>
In-Reply-To: <CAMuHMdW58Z7BKpADWCz_ofoxn_gtjvaGLCr=9r2-OHzPo=4ugA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


Hi Geert

> > +/* IPSRx */            /* 0 */                 /* 1 */         /* 2 */                 /* 3 */                         /* 4 */         /* 5 */         /* 6 */                 /* 7 */         /* 8 */                 /* 9 */         /* A */         /* B */         /* C - E */
> > +#define IP0_3_0                FM(AVB_MDC)             F_(0,0)         FM(MSIOF2_SS2_C)        F_(0,0)                         F_(0,0)         F_(0,0)         F_(0,0)                 F_(0,0)         F_(0,0)                 F_(0,0)         F_(0,0)         F_(0,0)         F_(0,0) F_(0,0) F_(0,0)
> 
> The 16th column ("F") is missing for all IPx_y_z macros.

Thanks. will fix in v2
