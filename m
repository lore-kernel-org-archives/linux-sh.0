From: Simon Horman <horms@verge.net.au>
Date: Thu, 10 Dec 2015 05:00:10 +0000
Subject: Re: [PATCH v2 0/9] i2c: add generic support for timing parameters in DT
Message-Id: <20151210050009.GE6964@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Tue, Dec 08, 2015 at 10:37:44AM +0100, Wolfram Sang wrote:
> Here is a patch series adding better DT support for timing parameters like the
> raise time or the fall time which are generic for the I2C subsystem. There is a
> core function for parsing and an implementation for the RCar driver how to use
> it.
> 
> I added people of the designware and rk3x driver to CC because they might be
> interested in this new function. They provided the basis for this series, so it
> should be easy to convert them.
> 
> Please have a look, test, comment...
> 
> Thanks,
> 
>     Wolfram
> 
> Changes since V1:
> * switched from DT properties to device properties
> * that means no dependency on OF and rename of the parsing function
> * removed a superfluous comment
> * adapted the RCar driver to the changes
> * added Rob's ack
> 
> Changes since RFC:
> * better tested
> * added documentation for the new function and the new struct
> * reworded some commit messages slightly
> * moved the new property in the dtsi above the "status" property
> 
> Wolfram Sang (9):
>   i2c: document generic DT bindings for timing parameters
>   i2c: add generic routine to parse DT for timing information
>   i2c: rcar: refactor probe function a little
>   i2c: rcar: switch to i2c generic dt parsing
>   i2c: rcar: honor additional i2c timings from DT
>   ARM: shmobile: r8a7790: dtsi: add internal delay for i2c IPs
>   ARM: shmobile: r8a7791: dtsi: add internal delay for i2c IPs
>   ARM: shmobile: r8a7794: dtsi: add internal delay for i2c IPs
>   arm64: renesas: r8a7795: add internal delay for i2c IPs

I have marked the ARM and arm64 patches as deferred pending
acceptance of the driver patches.
