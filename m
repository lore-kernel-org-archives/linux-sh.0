From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Dec 2014 12:20:22 +0000
Subject: Re: [PATCH] ARM: shmobile: lager dts: Drop console= bootargs parameter
Message-Id: <20141204122021.GC21778@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1417541988-28799-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1417541988-28799-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 02, 2014 at 10:52:48PM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Tuesday 02 December 2014 18:39:48 Geert Uytterhoeven wrote:
> > Since commit FIXME ("ARM: shmobile: lager: Remove legacy board support"),
> > lager is restricted to booting from DT, so chosen/stdout-path is always
> > used, and we can drop the "console=" parameter from chosen/bootargs.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> > ---
> > This depends on "[PATCH 2/5] ARM: shmobile: lager: Remove legacy board
> > support" by Laurent Pinchart, and allows to simplify his "[PATCH 4/5] ARM:
> > shmobile: lager: Rename SCIFA[01] serial ports to ttySC[01]".
> 
> Does it imply your ack on the series ? :-)

I have queued up the version of this patch which Laurent rebased.
