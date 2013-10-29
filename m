From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 29 Oct 2013 06:45:39 +0000
Subject: Re: [PATCH 0/2 v4] ARM: shmobile: QSPI support for R8a7790
Message-Id: <87fvrk7eyb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1382408472-20315-1-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1382408472-20315-1-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> > 
> > Hi Simon,
> > 
> > Here's version number four(v4) of the patchs add QSPI support to R8a7790 SOC. 
> > This QSPI attaches to SPI Flash Memory (Spansion S25FL512SAGMFIG11 64Mb)
> > I have updated the patch of 0001 with setting MSTP917 on a line of its own.
> > These patches are based on the branch renesas "renesas-devel-v3.12-rc5-20131017"
> > and have tested on the Lager board.
> > The qspi patch is on topic/rspi (5ce0ba8 and cb52c67) in the SPI tree:
> > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> 
> Morimoto-san,
> 
> are you happy with this revision of this series?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Yes. you can add my Acked-by which was added on v1 patches

Best regards
---
Kuninori Morimoto
