From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Mar 2013 01:56:42 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: Add R-Car M1A Bock-W support
Message-Id: <87y5dl79nt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5e3pra9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5e3pra9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > But does the mach-type file really get updated these days? When was
> > the last time anyone updated that file with updates from the web
> > interface?
> 
> The last commit to upstream that added anything to mach-type is
> dated the 26th of April 2012 and was included in v3.4-rc4.
> 
> > I recall last year trying to use an already existing mach-type for
> > KZM9D but that was removed and I was requested to use DT instead.
> 
> That is my recollection too.
> 
> Surely we need to initialise the board using DT.  Even if it is a very
> minimal DT initialisation that hooks into C code. And even if
> ARM_APPENDED_DTB is needed due to boot loader limitations.

Yes, my R-Car M1 v2 patch is using DT,
and mach-type is no longer needed

Subject: [PATCH 0/3 v2] ARM: shmobile: add R8A7778 Bock-W board support
Date: Tue, 12 Mar 2013 01:25:40 -0700 (PDT)


Best regards
---
Kuninori Morimoto
