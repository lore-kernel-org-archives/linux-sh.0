From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 27 Feb 2015 10:44:16 +0000
Subject: Re: [PATCH 0/3] [RESEND] Add DU external pixel clocks to DT
Message-Id: <1757153.ttd1kk0EQE@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1424942483-10910-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424942483-10910-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Friday 27 February 2015 10:49:47 Simon Horman wrote:
> On Thu, Feb 26, 2015 at 11:21:20AM +0200, Laurent Pinchart wrote:
> > Hello,
> > 
> > These three patches add the DU external pixel clocks to DT for the Marzen,
> > Lager and Koelsch boards. They have been posted previously, and now that
> > the corresponding DT bindings have been accepted and appeared in
> > v4.0-rc1, they can be merged.
> > 
> > Laurent Pinchart (3):
> >   ARM: shmobile: marzen: Add DU external pixel clock to DT
> >   ARM: shmobile: lager: Add DU external pixel clocks to DT
> >   ARM: shmobile: koelsch: Add DU external pixel clocks to DT
> >  
> >  arch/arm/boot/dts/r8a7779-marzen.dts  |  9 +++++++++
> >  arch/arm/boot/dts/r8a7790-lager.dts   | 21 +++++++++++++++++++++
> >  arch/arm/boot/dts/r8a7791-koelsch.dts | 19 +++++++++++++++++++
> >  3 files changed, 49 insertions(+)
> 
> Thanks, I have queued these up.
> 
> BTW, if you could CC me on patches that are for me to pick up
> then my life would be just ever so slightly easier.

Sure, I will.

-- 
Regards,

Laurent Pinchart

