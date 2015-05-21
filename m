From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 21 May 2015 16:27:52 +0000
Subject: Re: [PATCH 4/4 v2] ASoC: rsnd: spin lock for interrupt handler
Message-Id: <20150521161552.GT3140@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
 <87382qtwto.wl%kuninori.morimoto.gx@renesas.com>
 <20150521105940.GV21577@sirena.org.uk>
In-Reply-To: <20150521105940.GV21577@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org

On Thu, May 21, 2015 at 11:59:40AM +0100, Mark Brown wrote:
> On Thu, May 21, 2015 at 03:50:23AM +0000, Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Renesas R-Car driver interrupt handler was not locked before.
> > But now, SSI/SRC interrupt handler calls restart function
> > which should be called under spin lock.
> > Below error might happen witout this patch.
> 
> This looks fine but I guess it depends on patch 1 otherwise more errors
> will be introduced?
The 1st one looks good to me and was about to apply, but saw this and to
sync would you the 1st patch thru ASoC tree or fine with me applying that
one

-- 
~Vinod
