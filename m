From: Simon Horman <horms@verge.net.au>
Date: Tue, 15 Dec 2015 04:14:49 +0000
Subject: Re: [PATCH v2 0/9] i2c: add generic support for timing parameters in DT
Message-Id: <20151215041448.GA32397@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
 <20151214100026.GD1733@katana>
In-Reply-To: <20151214100026.GD1733@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Mon, Dec 14, 2015 at 11:00:26AM +0100, Wolfram Sang wrote:
> On Tue, Dec 08, 2015 at 10:37:44AM +0100, Wolfram Sang wrote:
> > Here is a patch series adding better DT support for timing parameters like the
> > raise time or the fall time which are generic for the I2C subsystem. There is a
> > core function for parsing and an implementation for the RCar driver how to use
> > it.
> > 
> > I added people of the designware and rk3x driver to CC because they might be
> > interested in this new function. They provided the basis for this series, so it
> > should be easy to convert them.
> > 
> > Please have a look, test, comment...
> > 
> > Thanks,
> > 
> >     Wolfram
> 
> Applied patches 1-5 to for-next with the change Andy suggested, thanks!
> 
> Simon, you can pick up patches 6-9 now, I'd think.

Thanks for letting me know, I have done so.
