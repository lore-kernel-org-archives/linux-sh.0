From: Simon Horman <horms@verge.net.au>
Date: Fri, 05 Apr 2013 07:38:35 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: add AS3711 PMIC platform data on kzm9g
Message-Id: <20130405073834.GA22306@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360689333-13525-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360689333-13525-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 13, 2013 at 10:10:56AM +0900, Simon Horman wrote:
> On Tue, Feb 12, 2013 at 04:53:28PM -0800, Kuninori Morimoto wrote:
> > 
> > Hi Guennadi
> > 
> > > KZM9G uses an AS3711 PMIC to supply power to the CPU and the LCD backlight.
> > > The PMIC on the board is pre-programmed to supply correct voltages to the
> > > CPU, power supply to the backlight has to be turned on at run-time. The
> > > latter is currently performed by a hard-coded I2C command sequence in the
> > > board file. This patch removes the backlight hack and instead adds an I2C
> > > device to instantiate the AS3711 MFD driver, which will add a regulator
> > > device to dynamically adjust CPU voltages and a backlight device.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > ---
> > >  arch/arm/mach-shmobile/board-kzm9g.c |  193 ++++++++++++++++++++++++---------
> > >  1 files changed, 140 insertions(+), 53 deletions(-)
> > 
> > Is it possible to update defconfig ?
> > This patch or additional patch.
> 
> An additional patch please.

I have queued-up this patch in the boards-kzm9g branch.
