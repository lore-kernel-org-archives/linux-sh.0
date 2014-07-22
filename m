From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Jul 2014 02:35:11 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fixup SD2CKCR register address
Message-Id: <87k376i0iq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a987grqy.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87a987grqy.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > > > > From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > > > > 
> > > > > Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > > > ---
> > > (snip)
> > > > The main difference I have noticed with this patch is:
> > > > sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 12 MHz
> > > > 
> > > > Whereas without I see:
> > > > sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 48 MHz
> > > 
> > > Thank you for testing !
> > > Hmm... it seems that we are under Document trap again ?
> > > I ask it to HW team again.
> > > Thank you
> > 
> > We guess,
> > "without this patch" is 12 MHz,
> > "with    this patch" is 48 MHz.
> > 
> > And, 48 MHz is correct clock
> 
> Yes, sorry for the mix-up. Your guess is correct.
> 
> It seems that this problem was introduced in v3.14 by
> 59e79895b9589286 ("ARM: shmobile: r8a7791: Add clocks").
> 
> That it is not manifesting in run-time difficulties when only using using
> mainline code until SDHI devices were enabled on the Koelsch board in v3.15 by
> 2c60a7df72711fb8 ("ARM: shmobile: Add SDHI devices for Koelsch DTS")
> 
> And that it should not manifest as a problem on the Henninger board
> SDHI devices were enabled on that board in v3.16-rc1 by
> 1299df03d7191ab4 ("ARM: shmobile: henninger: add SDHI0/2 DT support")
> 
> If the above is correct could you update the changelog accordingly and
> repost? If not could you collate the correct information regarding
> when the bug was introduced, update the changelog accordingly and repost?

Thank you
OK, I will re-post this patch
