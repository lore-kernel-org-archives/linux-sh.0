From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Jun 2014 09:26:59 +0000
Subject: Re: [PATCH 01/10] ARM: shmobile: r8a7790: add DVC support on DTSI
Message-Id: <87r42lntax.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uouy3zl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uouy3zl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Geert

> > > I guess,
> > > above patch (78a29b8be588ecf7b2a7ee8d2b7e12f325730caa) adds
> > > "MSTP10 entries" to r8a7790.dtsi.
> > > This patch adds DVC entries to "sound node"
> > > which didn't have it.
> > 
> > Bummer. Too much identical context in DTS files, confusing human beings
> > (and sometimes patch/git am)...
> 
> It happens. Please let me know if there is anything I can do to help.

Sorry, this patch title itself was very confusable.
So, how about this ?

 - ARM: shmobile: r8a7790: add DVC support on DTSI
 + ARM: shmobile: r8a7790: add DVC support to sound node on DTSI
