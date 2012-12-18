From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Dec 2012 00:05:05 +0000
Subject: Re: [PATCH 0/2] Preliminary Armadillo DT support
Message-Id: <20121218000504.GD7146@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355666066-25649-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1355666066-25649-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 17, 2012 at 12:23:44PM +0100, Bastian Hecht wrote:
> Hi,
> 
> >
> > Preliminary Armadillo800eva DT support itself is very good.
> > But I guess these patches kill off "current" Armadillo800eva users who are using many devices ?
> >
> > How about this ?
> >   1) add new file like board-armadillo800eva-dt.c for DT support
> >   2) keep adding new DT suuport on board-armadillo800eva-dt.c
> >   3) If board-armadillo800eva-dt.c has full-support,
> >      remove old board-armadillo800eva.c
> >
> 
> Sounds like a plan!
> Yes this looks like the way Simon has made up his kzm9g reference
> implementation. So I suppose we want this extra board file in the
> mainline until 3) happens?

Yes, I think that is the plan.

Could you please call the new file "-reference" to be consistent with
kam9g? You may or may not also need to have a "-reference" .dts and
.dtsi files.

Strictly speaking board-armadillo800eva.c already uses DT,
albeit in a very minimal way. This is the reason I would like to
avoid using "-dt" in the new file names.
