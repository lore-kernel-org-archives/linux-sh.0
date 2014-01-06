From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Jan 2014 05:22:47 +0000
Subject: Re: [PATCH V2 3/5] arm: shmobile: r7s72100: add nodes for i2c controllers to dtsi
Message-Id: <20140106052247.GB24653@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-4-git-send-email-wsa@the-dreams.de>
 <20131227042747.GB6161@katana>
In-Reply-To: <20131227042747.GB6161@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 27, 2013 at 05:27:47AM +0100, Wolfram Sang wrote:
> On Wed, Dec 18, 2013 at 10:31:59PM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> > 
> > I decided to put the pinmuxing into the dtsi file since there is only
> > one pinmux posiibility which one probably wants to have when using the
> > bus.
> > 
> > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> > Acked-by: Magnus Damm <damm@opensource.se>
> 
> Simon, I think you could pull in these patches, too. My series does not
> really depend on the pinctrl stuff. I2C pins are function group 1 and
> thus activated by default if the bootloader doesn't do weird things.
> Actually, I coded the PFC stuff after the driver was finished :)

That seems reasonable.

Could you send a series which contains the patches you would like
queued up? Please base it on the latest devel tag, currently
renesas-devel-v3.13-rc5-20131230, without other patches applied.
