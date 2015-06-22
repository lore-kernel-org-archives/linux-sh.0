From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 22 Jun 2015 09:52:07 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: rsrc-card: Remove unused variable in	rsrc_card_startup()
Message-Id: <s5hpp4o6pfc.wl-tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1434962073-9597-1-git-send-email-geert+renesas@glider.be>
	<87wpyw6stl.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdX0WnQ61FrEmCq5_YCmvoh5NWk5br76+xr+DSXV0ocPcA@mail.gmail.com>
In-Reply-To: <CAMuHMdX0WnQ61FrEmCq5_YCmvoh5NWk5br76+xr+DSXV0ocPcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>

At Mon, 22 Jun 2015 11:05:47 +0200,
Geert Uytterhoeven wrote:
> 
> On Mon, Jun 22, 2015 at 10:41 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > Thank you for your patch
> > But, this patch was already posted/applied
> >
> > http://thread.gmane.org/gmane.linux.alsa.devel/140317
> 
> Ah, Google didn't find your patch, and it's not yet in
> sound-asoc/for-next.

Yeah, I see this warning also in build tests of Mark's latest pull
request.  Mark, was the fix patch already queued?


Takashi
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
