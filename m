From: Simon Horman <horms@verge.net.au>
Date: Wed, 07 Nov 2012 05:57:05 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: r8a7779/marzen: usb support
Message-Id: <20121107055705.GE3675@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87liep4rwy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87liep4rwy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 07, 2012 at 07:32:23AM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Nov 06, 2012 at 06:00:12PM -0800, Kuninori Morimoto wrote:
> > 
> > Hi Simon
> > 
> > > > These are USB support patches for r8a7779/marzen board.
> > > > To use USB, it needs USB-phy driver
> > > > which is still not applied on USB maintainer's branch yet.
> > > > But I know there is ARM-platform patch time-limit soon.
> > > > So, I send these patches now.
> > > 
> > > Hi Morimoto-san,
> > > 
> > > I think that it is rather tricky for me to apply these changes
> > > before the USB-phy driver is applied. Can you let me know if that
> > > has happened /when that happens.
> > 
> > OK. I will
> 
> FWIW, r-car phy is in my tree and will be part of v3.8 merge window:
> 
> http://git.kernel.org/?p=linux/kernel/git/balbi/usb.git;a=commit;h89e52acc90c87484a109d6349eefe63cabb257

Thanks. In that case I will send a pull request to arm-soc
for the shmobile patches.
