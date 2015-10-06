From: Simon Horman <horms@verge.net.au>
Date: Tue, 06 Oct 2015 00:50:58 +0000
Subject: Re: [PATCH 0/3] Basic GPIO support for r8a7795
Message-Id: <20151006005058.GD12506@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1441035401-5843-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1441035401-5843-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 05, 2015 at 11:20:15AM +0200, Ulrich Hecht wrote:
> On Mon, Oct 5, 2015 at 4:27 AM, Simon Horman <horms@verge.net.au> wrote:
> > I have taken the liberty of:
> >
> > * rebasing and updating this patch set on top of
> >   "[PATCH v10 00/07] Renesas R-Car H3 (r8a7795) integration patches V10"
> > * Updating the patch set to to once again have clock-output-names using the
> >   following update below provided to me by Geert - hopefully that
> >   merry-go-round has now paused for v4.4.
> > * Updating the clock definition order by folding in
> >   "arm64: dts: r8a7795: add GPIO clocks"
> >
> > I would greatly appreciate if you and any other interested parties could
> > review the result which can be found in the topic/r8a7795-gpio-v1.rebase2
> > branch of the renesas tree.  If you find any problems please repost the
> > patch set at your earliest convenience.
> 
> Thanks a lot, codewise that looks perfect to me.  I believe, however,
> that in "arm64: dts: r8a7795: add GPIO clocks" there is a
> "Signed-off-by: " missing before Morimoto-san's name.  Should I
> add/repost that, or is it easier if you touched it up in your branch?

Sorry about that Morimoto-san.

I suggest we fix that the next time either of us have to update
the patches as there are several topic branches sitting on top
of this one so I think its best to batch respinning them.
