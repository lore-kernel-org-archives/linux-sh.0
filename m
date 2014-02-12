From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 12 Feb 2014 06:13:22 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: lager: add SDHI0/2 support on DTS
Message-Id: <87zjlw97ul.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r47fb9tc.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87r47fb9tc.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

> > +       vcc_sdhi2: regulator@3 {
> > +               compatible = "regulator-fixed";
> > +
> > +               regulator-name = "SDHI0 Vcc";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +
> > +               gpio = <&gpio5 25 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> > +       };
> > +
> > +       vccq_sdhi2: regulator@4 {
> > +               compatible = "regulator-gpio";
> > +
> > +               regulator-name = "SDHI0 VccQ";
> 
> After some testing I can see that "regulator-name" contains a typo
> above. Please use SDHI2 as name for SDHI2 devices, not SDHI0. =)

Grr...
Thank you for pointing it
I will send v2 patch

Best regards
---
Kuninori Morimoto

