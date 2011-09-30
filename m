From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Sep 2011 08:08:17 +0000
Subject: Re: [PATCH 4/5] ARM: mach-shmobile: r8a7740: Add i2c support
Message-Id: <87pqiicv0y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8762kcqglg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762kcqglg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org


Hi Iwamatsu-san

Thank you for your check

> > +static void r8a7740_i2c_workaround(struct platform_device *pdev)
> > +{
> > +       struct resource *res;
> > +       void __iomem *reg;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res) {
> 
> if (unlikely(res = NULL)) {  ?
> Please check NULL.

Sorry. what is your opinion ?

if (!res) checks NULL I think.
or do you mean add "unlikely()" ?

Best regards
---
Kuninori Morimoto
