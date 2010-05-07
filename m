From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 May 2010 11:34:54 +0000
Subject: Re: [PATCH] sh: modify pinmux for SH7757 2nd cut
Message-Id: <20100507113453.GA14948@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4BE3DC84.4070203@renesas.com>
In-Reply-To: <4BE3DC84.4070203@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 07, 2010 at 08:24:46PM +0900, Yoshihiro Shimoda wrote:
> Paul Mundt wrote:
> > If the 1st cut has already shipped, then the 2nd cut will have to be
> > added as a new CPU by itself. We managed to dodge this bullet for 7786 at
> > least by never supporting the 90nm version, but we would have obviously
> > been in the same situation there as well of adding a new CPU subtype to
> > account for the lack of consistency between silicon revisions.
> 
> Thank you very much for your comment.
> I will ask my boss about this plan.
> Would you wait to apply the today's patches?
> 
The serial one shouldn't matter one way or the other, but if you're
planning on respinning the series then of course I can just deal with
that then as well.
