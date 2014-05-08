From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 May 2014 00:15:33 +0000
Subject: Re: [PATCH 7/7] ASoC: rsnd: remove compatibility code
Message-Id: <87bnv9nn19.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
	<87ioqc20ei.wl%kuninori.morimoto.gx@gmail.com>
	<20140414190327.GE25182@sirena.org.uk>
In-Reply-To: <20140414190327.GE25182@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org


Hi Mark

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Now, all platform is using new style rsnd_dai_platform_info.
> > Keeping compatibility is no longer needed.
> > We can cleanup code.
> 
> This and the previous patch both look good.

1) - 5) remove old style audio settings from platform, and
6) - 7) remove compatibility (= old style) code from driver.

Kuninori Morimoto (7):
      1) ARM: shmobile: r8a7778: remove old style audio clock
      2) ARM: shmobile: r8a7790: remove old style audio clock
      3) ARM: shmobile: bockw: remove old style audio clock
      4) ARM: shmobile: bockw: switch to use dai info for R-Car sound
      5) ARM: shmobile: lager: switch to use dai info for R-Car sound
      6) ASoC: rsnd: remove old clock style support
      7) ASoC: rsnd: remove compatibility code

Now, 1) - 5) are accepted by ARM maintainer.
Can you please re-check 6) - 7) ?

-- from Simon ---------

Patches 1 and 2 are included in the renesas-clock-for-v3.16 tag of the
clocks-for-v3.16 branch of my renesas tree. This has been accepted by Olof.

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock-for-v3.16

Patches 3 - 5 are included in the renesas-boards-for-v3.16 tag of
the boards-for-v3.16 branch of my renesas tree. This has also been accepted
by Olof.

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.16


Mark, I think it would be cleanest if you pulled the above two branches.
If you prefer a single tag that includes both of the above (albeit with
other stuff that has also been accepted by Olof) then I suggest the
renesas-next-v3.15-rc1-20140416 tag of the next branch of my renesas tree.

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-next-v3.15-rc1-20140416

-------------------------
