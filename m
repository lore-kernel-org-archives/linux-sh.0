From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Jul 2013 16:44:14 +0000
Subject: Re: [PATCH 1/4] net: smsc911x: add support for a reset GPIO
Message-Id: <Pine.LNX.4.64.1307231843480.19465@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1374595924-12338-1-git-send-email-g.liakhovetski@gmx.de>
 <1374595924-12338-2-git-send-email-g.liakhovetski@gmx.de>
 <CAOMZO5AzEgkyRz0N0a3CSS7sWEatT3ZQX9eku1fH6hzheh0ARA@mail.gmail.com>
In-Reply-To: <CAOMZO5AzEgkyRz0N0a3CSS7sWEatT3ZQX9eku1fH6hzheh0ARA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Steve Glendinning <steve.glendinning@shawell.net>, netdev@vger.kernel.org

On Tue, 23 Jul 2013, Fabio Estevam wrote:

> On Tue, Jul 23, 2013 at 1:12 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> 
> > +       if (pdata->config.reset_gpio_config & SMSC911X_RESET_GPIO_VALID) {
> > +               /* Take the chip out of hard reset */
> > +               unsigned long flags = (pdata->config.reset_gpio_config ^
> > +                                      GPIOF_INIT_HIGH) & 0xf;
> > +               retval = gpio_request_one(pdata->config.reset_gpio,
> 
> If you use devm_gpio_request_one() here, then you can simplify your
> code by not having to call gpio_free.

Oops, sure, will update, thanks.

Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
