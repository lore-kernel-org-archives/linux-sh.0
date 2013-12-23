From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 23 Dec 2013 11:18:18 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: r8a779x: Add more clocks to DT
Message-Id: <1692195.i7u6Bgxa8Z@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1387468266-13625-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387468266-13625-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Monday 23 December 2013 09:48:01 Simon Horman wrote:
> Laurent, Magnus,
> 
> these all seem pretty clean.
> Shall I queue them up?

I believe the patches are ready to be queued up.

> On Thu, Dec 19, 2013 at 04:51:00PM +0100, Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch set adds the MSIOF, QSPI and SSI clocks to DT for the r8a7790
> > and r8a7791 SoCs.
> > 
> > Laurent Pinchart (6):
> >   ARM: shmobile: r8a7790: Add MSIOF clocks in device tree
> >   ARM: shmobile: r8a7791: Add MSIOF clocks in device tree
> >   ARM: shmobile: r8a7790: Add QSPI module clock in device tree
> >   ARM: shmobile: r8a7791: Add QSPI module clock in device tree
> >   ARM: shmobile: r8a7790: Add SSI clocks in device tree
> >   ARM: shmobile: r8a7791: Add SSI clocks in device tree
> >  
> >  arch/arm/boot/dts/r8a7790.dtsi            | 48 +++++++++++++++++++++-----
> >  arch/arm/boot/dts/r8a7791.dtsi            | 52 +++++++++++++++++++-------
> >  include/dt-bindings/clock/r8a7790-clock.h | 20 ++++++++++++
> >  include/dt-bindings/clock/r8a7791-clock.h | 19 +++++++++++
> >  4 files changed, 120 insertions(+), 19 deletions(-)

-- 
Regards,

Laurent Pinchart

