From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 08 Dec 2009 07:13:02 +0000
Subject: Re: [PATCH 5/5] sh: dmaengine support for sh7724
Message-Id: <20091208071302.GA23814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange> <Pine.LNX.4.64.0912041942330.3981@axis700.grange> <e9c3a7c20912071702h1aea2026kff22db99a221f6c4@mail.gmail.com>
In-Reply-To: <e9c3a7c20912071702h1aea2026kff22db99a221f6c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams@intel.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Mon, Dec 07, 2009 at 06:02:24PM -0700, Dan Williams wrote:
> On Fri, Dec 4, 2009 at 11:45 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Add a dmaengine platform device to sh7724, fix DMA channel interrupt numbers.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >
> > With this patch dmatest works with channels 0-5, channels 6-11 still don't
> > work for some reason... So, feel free to discard it for now, if a complete
> > fix would be preferred.
> 
> Does this patch limit operation to channels 0-5?  I leave this one for
> Paul to disposition.
> 
There are 6 channels per controller, so the fact that the second
controller isn't working could either be cause the driver needs more work
to handle multiple controllers properly, or there could be a pinmux issue
that hasn't been resolved yet for DMAC1. Both of these cases require the
driver to be a bit smarter, but as Guennadi is presently working on these
things, doing them incrementally is ok with me. If this gets DMAC0
working at least where it wasn't before, it's certainly worth applying.
DMAC1 seems to have more problems than just wrong interrupt numbers, so
this isn't going to cause any regressions there either.

Acked-by: Paul Mundt <lethal@linux-sh.org>
