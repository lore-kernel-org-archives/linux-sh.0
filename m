From: Simon Horman <horms@verge.net.au>
Date: Fri, 23 Jan 2015 04:23:00 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: kzm9g-reference: Add missing i2c devices
Message-Id: <20150123042259.GD17548@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1420573329-12762-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420573329-12762-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 22, 2015 at 11:53:50AM +0900, Simon Horman wrote:
> On Thu, Jan 08, 2015 at 08:55:50AM +0900, Simon Horman wrote:
> > On Tue, Jan 06, 2015 at 08:42:03PM +0100, Geert Uytterhoeven wrote:
> > > 	Hi Simon, Magnus,
> > > 
> > > This patch series adds i2c devices that are supported by kzm9g-legacy
> > > but missing on kzm9g-reference (and -multiplatform).
> > > 
> > > The first patch ("ARM: shmobile: sh73a0 dtsi: Set control-parent for
> > > all irqpin nodes") is a prerequisite to avoid causing an interrupt
> > > storm when accessing the adxl345 accelerometer through
> > > /dev/input/event1, which requires a power-cycle to recover from.
> > > 
> > > Parts of this series and of the individual patches were written by
> > > Laurent Pinchart.
> > > 
> > > Thanks for applying!
> > 
> > Thanks, done.
> 
> For the record: Olof has asked for review comments for the BSC driver and
> binding patches. Accordingly I have dropped them, and these patches which
> depend on them, from next.
> 
> This dependency may be due to the way the branches are arranged, rather
> than actual dependencies of the code. But regardless I am dropping all
> effected branches for now.

I have now had a chance to re-examine these patches and it seems
to me that they do not depend on the BSC driver (or anything else).
With that in mind I have queued them up in the dt-for-v3.21 branch
as part of renesas-devel-20150123-v3.19-rc5.

Please take a moment to see if what I have done makes sense to you.

For reference this covers the following patches which comprised this series:

Geert Uytterhoeven (4):
  ARM: shmobile: kzm9g-reference dts: Sort i2c0 children by unit address
  ARM: shmobile: kzm9g-reference dts: Add ak8975 magnetometer node
  ARM: shmobile: kzm9g-reference dts: Add adxl345 accelerometer node
  ARM: shmobile: kzm9g-reference dts: Add r2025sd rtc node

Laurent Pinchart (2):
  ARM: shmobile: sh73a0 dtsi: Set control-parent for all irqpin nodes
  ARM: shmobile: kzm9g-reference dts: Add st1232 touchscreen node
