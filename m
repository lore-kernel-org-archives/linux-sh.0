From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Nov 2015 00:13:20 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: r8a7793 GOSE board HDMI prototype
Message-Id: <20151125001320.GC20596@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20151116091515.20711.14784.sendpatchset@little-apple>
In-Reply-To: <20151116091515.20711.14784.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 24, 2015 at 12:05:30PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Tue, Nov 24, 2015 at 11:53 AM, Simon Horman <horms@verge.net.au> wrote:
> > Hi Magnus,
> >
> > On Mon, Nov 16, 2015 at 06:15:15PM +0900, Magnus Damm wrote:
> >> ARM: shmobile: r8a7793 GOSE board HDMI prototype
> >>
> >> [PATCH 01/02] ARM: shmobile: r8a7793: Add DU node to device tree
> >> [PATCH 02/02] ARM: shmobile: r8a7793: gose: HDMI prototype hack
> >>
> >> These patches include HDMI prototype support for the r8a7793 GOSE board.
> >> No special merge time dependencies exist, however for correct run time
> >> operation v4.4-rc1 is recommended and in particular the patch
> >> "drm: rcar-du: Add support for the R8A7793 DU".
> >>
> >> Tested with the modetest utility on the r8a7793 GOSE board.
> >> # modetest -M rcar-du -c
> >> # modetest -M rcar-du -s 33:1280x720@AR24
> >>
> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >
> > It would help me somewhat if you could prefix prototype patches with
> > RFC or PATCH/RFC. Thanks.
> 
> Yeah, I agree - sorry for constantly forgetting about the RFC portion.
> 
> This particular series actually had the first patch as "ready to merge
> upstream" while the second one is a prototype that depends on I2C
> which I think is missing for r8a7793.
> 
> Would it be possible for you to pick up the first patch and prioritise
> I2C over other devices on r8a7793? That way I can easily redo patch
> 2/2 and we get working HDMI upstream.

Sure, I'll look at queuing up patch 1/2.

However, a scheme where a series labeled prototype contains a patch ready
to merge and one not ready to merge is a little hard for me to follow.
I know its tedious but it would help in future if RFC and ready-to-merge
patches were in separate series and RFC were tags used. Thanks :)
