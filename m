From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 22 Jun 2015 09:59:55 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: rsrc-card: Remove unused variable in rsrc_card_startup()
Message-Id: <s5hlhfc6p2c.wl-tiwai@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1434962073-9597-1-git-send-email-geert+renesas@glider.be>
	<87wpyw6stl.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdX0WnQ61FrEmCq5_YCmvoh5NWk5br76+xr+DSXV0ocPcA@mail.gmail.com>
	<s5hpp4o6pfc.wl-tiwai@suse.de>
	<20150622095637.GO14071@sirena.org.uk>
In-Reply-To: <20150622095637.GO14071@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>

At Mon, 22 Jun 2015 10:56:37 +0100,
Mark Brown wrote:
> 
> On Mon, Jun 22, 2015 at 11:52:07AM +0200, Takashi Iwai wrote:
> 
> > Yeah, I see this warning also in build tests of Mark's latest pull
> > request.  Mark, was the fix patch already queued?
> 
> I have no idea off the top of my head, it'll be in the pull request I
> sent you this morning.

Hm, I'm testing the tree with today's pull request, and hit this now.


Takashi
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
