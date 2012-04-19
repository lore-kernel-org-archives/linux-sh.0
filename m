From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Apr 2012 08:57:26 +0000
Subject: Re: [PATCH 3/6] spi: spi-sh-msiof: do not manage PM clocks manually
Message-Id: <CANqRtoQ6BO2KXr7D7tSmyRkHxT6EbNQQU+YQBYLfkBMAYrjqJw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204181324590.30514@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204181324590.30514@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 18, 2012 at 8:28 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On sh-mobile platforms the bus clock frequency for the MSIOF unit is
> obtained from the same clock, as the one, that runtime power-manages the
> controller. The MSIOF driver has to access that clock directly,
> bypassing the runtime PM framework, to get its frequency, but it
> shouldn't enable or disable it.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Usually I don't say this, but here's a NAK!

The driver is fine as-is, please don't remove the clk_enable() and
clk_disable() calls. We want the driver to tell the clock framework
that it should keep the clock frequency fixed while the clock is
enabled, so if you remove the clk_enable() and clk_disable() calls you
also remove this way of notification.

Cheers,

/ magnus
