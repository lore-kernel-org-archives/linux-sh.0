From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Jul 2014 09:45:06 +0000
Subject: Re: renesas-drivers-2014-07-07-v3.16-rc4
Message-Id: <20140708094504.GB7253@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVTOabkGyJW-jRxXjtGHdA0W=APoiMYWAtvP3y_auqXKg@mail.gmail.com>
In-Reply-To: <CAMuHMdVTOabkGyJW-jRxXjtGHdA0W=APoiMYWAtvP3y_auqXKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 07, 2014 at 07:55:26PM -0700, Kuninori Morimoto wrote:
> 
> Hi Geert, Simon
> 
> > > > Today's version is based on renesas-devel-v3.16-rc4-20140707, and contains
> > > > the following for-next branches:
> > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git#asoc/for-next
> > > 
> > > I had a merge conflict due to commit 7635dd189e6f3d8fb007c7a2e3bf93957a82d009
> > > ("local: ASoC: rsnd: fixup rsnd_gen_dma_addr() for Gen1") in Simon's tree.
> > > I assume this was fixed differently in the sound-asoc tree, so I reverted the
> > > local fix in Simon's tree. Is that correct?
> > 
> > I suspect so. Morimoto-san, can you double-check.
> 
> Yes, it is correct !

Thanks, I'll drop the local fix from devel once it shows up
in an rc release (and I get a conflict).
