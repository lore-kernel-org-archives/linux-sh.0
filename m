From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 02 Apr 2013 00:13:10 +0000
Subject: Re: [PATCH 3/3 v2] ARM: shmobile: bockw: add SMSC ethernet support
Message-Id: <87zjxh6b8t.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
 <87bo9z56k8.wl%kuninori.morimoto.gx@renesas.com>
 <515982A8.3090307@cogentembedded.com>
In-Reply-To: <515982A8.3090307@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Sergei, Simon

> >   	chosen {
> > -		bootargs = "console=ttySC0,115200 ignore_loglevel";
> > +		bootargs = "console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs";
> >   	};
> >
> >   	memory {
> 
>     In my opinion, modifying .dts file should be done in a separate patch.
(snip)
> >   # CONFIG_SCHED_DEBUG is not set
> >   # CONFIG_DEBUG_BUGVERBOSE is not set
> >   # CONFIG_FTRACE is not set
> >   # CONFIG_ARM_UNWIND is not set
> > -CONFIG_KEYS=y
> > -CONFIG_CRYPTO=y
> >   CONFIG_AVERAGE=y
> 
>     In my opinion, modifying bockw_defconfig should be done in a separate 
> patch. Mixing everything up in a signle patch is a bad practice.

It depends on LTSI backport / upstreaming I believe.
I need Simon's opinion

Best regards
---
Kuninori Morimoto
