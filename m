From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 02 Jul 2012 19:53:04 +0000
Subject: Re: [PATCH][rework] ARM: shmobile: patch set rework
Message-Id: <201207022153.04541.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87hatzlm7x.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hatzlm7x.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, July 02, 2012, Kuninori Morimoto wrote:
> 
> Hi Rafael
> 
> > I've already merged your entire seres doing some manula adjustments
> > wherever the changes depended on the new PM domain code.  Please
> > check the 'next' branch of the renesas.git tree and let me know if
> > anything is missing or wrong.
> 
> Thank you for accepting my patches.
> Yes. Its are correctly included in my quick check.
> 
> > > ------- for rafael/soc ----------------------------------
> > > Kuninori Morimoto (1):
> > >       [PATCH 1/1] ARM: shmobile: shareing extra gpio setting functions
> > > 
> > >  arch/arm/mach-shmobile/board-ap4evb.c      |   19 +--------------
> > >  arch/arm/mach-shmobile/board-g4evm.c       |   18 ---------------
> > >  arch/arm/mach-shmobile/board-mackerel.c    |   30 +------------------------
> > >  arch/arm/mach-shmobile/include/mach/gpio.h |   32 ++++++++++++++++++++++++++++
> > >  4 files changed, 36 insertions(+), 63 deletions(-)
> > 
> > No, that should be split into 4 patches, such that patch 1 will change
> > arch/arm/mach-shmobile/include/mach/gpio.h only and the other patches will
> > change the respective board files.  You've done the split already, haven't you?
> (snip)
> > [PATCH 1/16] ARM: shmobile: add common DMAEngine definitions
> > [PATCH 2/16] ARM: shmobile: add common extra gpio functions
> > [PATCH 3/16] ARM: shmobile: r8a7740: add DMAEngine support for FSI
> > [PATCH 4/16] ARM: shmobile: r8a7740: add DMAEngine support for SDHI
> > [PATCH 5/16] ARM: shmobile: r8a7740: add DMAEngine support for USB
> > [PATCH 6/16] ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
> > [PATCH 7/16] ARM: shmobile: sh73a0: add USB clock support
> > [PATCH 8/16] ARM: shmobile: armadillo800eva: enable FSI-WM8978 sound
> > [PATCH 9/16] ARM: shmobile: armadillo800eva: enable FSI-HDMI sound
> > [PATCH 10/16] ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
> > [PATCH 11/16] ARM: shmobile: armadillo800eva: enable DMAEngine on SDHI
> > [PATCH 12/16] ARM: shmobile: armadillo800eva: enable DMAEngine on USB
> > [PATCH 13/16] ARM: shmobile: kzm9g: enable DMAEngine on FSI
> > [PATCH 14/16] ARM: shmobile: kzm9g: enable DMAEngine on MMCIF
> > [PATCH 15/16] ARM: shmobile: kzm9g: enable USB func
> > [PATCH 16/16] ARM: shmobile: kzm9g: enable MicroSD
> > 
> > next time?  That will be _way_ easier for me to handle and generally quite
> > clean, and you can always add a [0/16] message explaining what's going on.
> 
> Sorry it was my English misunderstanding.
> I will do that.
> 
> I think [PATCH 1/16] and [PATCH 2/16] should be separated into 4 patches for each CPU.
> Is this correct ?
> 
> But I still have question about this.
> What it difference between above style and my original patch set
> (= 10 Jun 2012 / [PATCH 0/27] ARM: shmobile: resend patch set)?
> 
> There are patch name issue now, and 1st/2nd were bugfix patches,
> but...

If I remember correctly, there were patches in there that touch
several boards at a time along with a common header.  And there
were patches that required some adjustments, as far as I can say.

Anyway, the format is suitable for me.

Thanks,
Rafael
