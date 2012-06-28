From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 28 Jun 2012 21:07:10 +0000
Subject: Re: [PATCH 0/1][RFC] ARM: shmobile: r8a7740: basic PM domain support
Message-Id: <201206282307.10203.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw9jlm4q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw9jlm4q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday, June 28, 2012, Kuninori Morimoto wrote:
> 
> Hi Rafael, Magnus
> 
> > In general I think it looks good for a V1, but I wonder about upcoming
> > patches for PM domain support for board-specific devices on the
> > Armadillo board. Do you have any other Armadillo-specific patch that
> > for instance hooks up the board specific LCDC device to the correct
> > power domain?
> > 
> > I recommend you to test during runtime with subsystem specific
> > interfaces - not only suspend-to-RAM. As an example, I believe the
> > LCDC can be powered on and off using some fbdev specific "blanking"
> > file in sysfs.
> 
> OK. now I created the incremental patches which enable USB/LCDC PM domain.
> Can I send these patches ? or should I wait until Rafael's tree became update ?

Actaully, please drop patch 1 (the RFC), rebase the rest so that they are
not based on this one and repost (preferably organized like I described in
my previous message).

And in the future, please never, _never_ base production patches on RFC ones.

Thanks,
Rafael
