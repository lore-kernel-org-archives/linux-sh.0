From: Simon Horman <horms@verge.net.au>
Date: Thu, 12 Dec 2013 12:11:16 +0000
Subject: Re: [PATCH v3] ARM: shmobile: koelsch: Add DU device
Message-Id: <20131212121113.GE18308@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1386379064-29668-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386379064-29668-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 11, 2013 at 06:45:37PM +0900, Magnus Damm wrote:
> On Sat, Dec 7, 2013 at 10:17 AM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > Only the LVDS output is currently supported.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  arch/arm/mach-shmobile/board-koelsch.c | 63 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >
> > Changes since v2:
> >
> > - Use koelsch instead of lager in structure names
> >
> > Changes since v1:
> >
> > - Rebased on top of renesas-devel-v3.13-rc2-20131202
> 
> Goes without saying, but:
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks for saying it.

I will queue this up.
