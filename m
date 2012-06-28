From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 28 Jun 2012 20:56:31 +0000
Subject: Re: [PATCH][rework] ARM: shmobile: patch set rework
Message-Id: <201206282256.31743.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87hatzlm7x.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hatzlm7x.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, June 25, 2012, Magnus Damm wrote:
> Hi Morimoto-san,
> 
> On Mon, Jun 25, 2012 at 7:28 PM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> >
> > Hi Rafael, Magnus
> > Cc Simon
> >
> > These are rework patch set which are not included on latest rafael's tree.
> > (and additional patch)
> > I separated each patches to become independent as much as possible.
> 
> Thanks for splitting out your patches!
> 
> > My previous patch set tried to sharing "gpio" and "DMAEngine" definitions on top.
> > This patch set still try to sharing it, but it was on last patches.
> 
> Good plan. I like when you prioritize adding hardware support over
> moving around code. =)
> 
> > gpio/DMAEngine sharing patch were separated as "add common xxx",
> > and "use common xxx".
> > I hope it is good fit for rafael's branch control
> 
> Looks fine to me, but I will let Rafael decide about that.
> 
> > 1st "PM domain" patch is new one.
> > It adds very basic PM domain support for Armadillo
> >
> > Kuninori Morimoto (1):
> >      ARM: shmobile: r8a7740: basic PM domain support
> 
> I believe this one needs more work. So I prefer holding off on this
> for a while, alternatively including it in some topic branch for
> incremental fixing and possible rebase,
> 
> > Kuninori Morimoto (2):
> >      ARM: shmobile: armadillo800eva: enable FSI-WM8978 sound
> >      ARM: shmobile: armadillo800eva: enable FSI-HDMI sound
> >
> > Kuninori Morimoto (3):
> >      ARM: shmobile: sh73a0: add USB clock support
> >      ARM: shmobile: kzm9g: enable USB func
> >      ARM: shmobile: kzm9g: enable MicroSD
> >
> > Kuninori Morimoto (6):
> >      ARM: shmobile: r8a7740: add DMAEngine support for FSI
> >      ARM: shmobile: r8a7740: add DMAEngine support for SDHI
> >      ARM: shmobile: r8a7740: add DMAEngine support for USB
> >      ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
> >      ARM: shmobile: armadillo800eva: enable DMAEngine on SDHI
> >      ARM: shmobile: armadillo800eva: enable DMAEngine on USB
> >
> > Kuninori Morimoto (3):
> >      ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
> >      ARM: shmobile: kzm9g: enable DMAEngine on FSI
> >      ARM: shmobile: kzm9g: enable DMAEngine on MMCIF
> >
> > Kuninori Morimoto (5):
> >      ARM: shmobile: add common extra gpio functions
> >      ARM: shmobile: use common extra gpio functions on ap4evb
> >      ARM: shmobile: use common extra gpio functions on g4evm
> >      ARM: shmobile: use common extra gpio functions on mackrel
> >      ARM: shmobile: use common extra gpio functions on armadillo800eva
> >
> > Kuninori Morimoto (4):
> >      ARM: shmobile: add common DMAEngine definitions
> >      ARM: shmobile: use common DMAEngine definitions on r8a7740
> >      ARM: shmobile: use common DMAEngine definitions on sh7372
> >      ARM: shmobile: use common DMAEngine definitions on sh73a0
> 
> These all look fine to me. Thanks for reposting your patches.
> 
> Rafael, please feel free to include my acked-by and pick up unless you
> or someone else thinks differently.
> 
> Morimoto-san, in general I'm happy with you resending your patches
> like this time,

Sorry to say that, but it totally doesn't work for me.

I'd prefer it to be a single patch series organized so that:
(1) Patches that multiple SoCs depend on go first
    (e.g. "ARM: shmobile: add common extra gpio functions" above).
(2) Patches that only one SoC depends on, but that touch files common to
    multiple boards go next
    (e.g. "ARM: shmobile: use common DMAEngine definitions on r8a7740" above).
(3) Patches that touch only one individual board go last
    (e.g. "ARM: shmobile: use common extra gpio functions on mackrel" above).

Pretty much any other ordering adds work for me and causes a lot of pain if
things don't apply cleanly to the branches I'm using (which is the case this
time).

Thanks,
Rafael


