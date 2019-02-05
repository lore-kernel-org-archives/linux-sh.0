From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Feb 2019 08:06:44 +0000
Subject: Re: [alsa-devel] [PATCH] ALSA: hda/ca0132: need CONFIG_PCI for compile
Message-Id: <875ztyk6u1.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877eeeka1n.wl-kuninori.morimoto.gx@renesas.com>
 <s5hzhraeko4.wl-tiwai@suse.de>
In-Reply-To: <s5hzhraeko4.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>


Forward to Renesas / SH ML

arch/sh need to be fixed pci_iounmap()

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > commit d99501b8575d ("ALSA: hda/ca0132 - Call pci_iounmap() instead of
> > iounmap()") started to use pci_iounmap() on ca0132, but then, it should
> > be depends on CONFIG_PCI.
> > Otherwise, non CONFIG_PCI compile will be failed, like below
> > 
> > 	linux/sound/pci/hda/patch_ca0132.c: In function 'ca0132_free':
> > 	linux/sound/pci/hda/patch_ca0132.c:8455:3: error: implicit\
> > 		declaration of function 'pci_iounmap'; did you mean\
> > 		'pcim_iounmap'? [-Werror=implicit-function-declaration]
> > 	pci_iounmap(codec->bus->pci, spec->mem_base);
> > 	^~~~~~~~~~~
> 
> No, the driver doesn't depend on PCI, it can be built and work fine
> without it, too.  The only problem is the broken pci_iounmap()
> implementation in sh.
> 
> We have added CONFIG_PCI check but obviously this isn't effective.
> It needs to be an explicit #ifdef, instead.  Will fix it.
> 
> Ideally it should be fixed in arch/sh side.  I tried to fix it, but it
> turned out to be much deeper than I thought, so I gave up scratching
> it for now.
> 
> 
> thanks,
> 
> Takashi
> 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  sound/pci/hda/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
> > index 4235907..03af159 100644
> > --- a/sound/pci/hda/Kconfig
> > +++ b/sound/pci/hda/Kconfig
> > @@ -171,6 +171,7 @@ comment "Set to Y if you want auto-loading the codec driver"
> >  
> >  config SND_HDA_CODEC_CA0132
> >  	tristate "Build Creative CA0132 codec support"
> > +	depends on CONFIG_PCI
> >  	help
> >  	  Say Y or M here to include Creative CA0132 codec support in
> >  	  snd-hda-intel driver.
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
