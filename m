From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Mon, 07 Feb 2011 08:22:55 +0000
Subject: Re: [RFC,PATCH 1/3] Add a common struct clk
Message-Id: <201102071622.56163.jeremy.kerr@canonical.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800158.458894385837.1.gpush@pororo>
	<AANLkTim1S9zpebn3yj1fBZTtOkqj2FLwhYWBZ2HXJajR@mail.gmail.com>
In-Reply-To: <AANLkTim1S9zpebn3yj1fBZTtOkqj2FLwhYWBZ2HXJajR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Dima,

> > +int clk_prepare(struct clk *clk)
> > +{
> > +       int ret = 0;
> > +
> > +       if (!clk->ops->prepare)
> > +               return 0;
> > +
> > +       mutex_lock(&clk->prepare_lock);
> > +       if (clk->prepare_count = 0)
> > +               ret = clk->ops->prepare(clk);
> > +
> > +       if (!ret)
> > +               clk->prepare_count++;
> > +       mutex_unlock(&clk->prepare_lock);
> > +
> > +       return 0;
> 
> return ret;

Good catch, thanks.


Jeremy
