From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Jul 2014 00:08:17 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fixup SD2CKCR register address
Message-Id: <87tx6ai7bl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a987grqy.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87a987grqy.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

> > > From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > > 
> > > Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> (snip)
> > The main difference I have noticed with this patch is:
> > sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 12 MHz
> > 
> > Whereas without I see:
> > sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 48 MHz
> 
> Thank you for testing !
> Hmm... it seems that we are under Document trap again ?
> I ask it to HW team again.
> Thank you

We guess,
"without this patch" is 12 MHz,
"with    this patch" is 48 MHz.

And, 48 MHz is correct clock
