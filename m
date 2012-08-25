From: Simon Horman <horms@verge.net.au>
Date: Sat, 25 Aug 2012 06:58:24 +0000
Subject: Re: [PATCH v2 5/6] ARM: mach-shmobile: Kota2: Use leds-pwm + rmob-tpu-pwm
Message-Id: <20120825065824.GH29755@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 24, 2012 at 04:40:22PM +0200, Laurent Pinchart wrote:
> Instead of using the LED-specific TPU PWM driver, switch to the generic
> TPU PWM driver with leds-pwm.

Magnus,

is there any chance of anyone testing this on a Kota2 board.
It would be nice to apply it with a view to removing the
leds-renesas-tpu driver.
