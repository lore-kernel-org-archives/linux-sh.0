From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Apr 2013 22:23:06 +0000
Subject: Re: [PATCH v3] irqchip: renesas-intc-irqpin: DT binding for sense bitfield width
Message-Id: <CANqRtoS7fkYd8iX3yAh7xoTNR39UiquWooUSr8+BjbBSUNozFQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1304081002190.29945@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1304081002190.29945@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Guennadi,

On Mon, Apr 8, 2013 at 5:08 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Most Renesas irqpin controllers have 4-bit sense fields, however, some
> have different widths. This patch adds a DT binding to optionally
> specify such non-standard values.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> v3: move the code to a common location, where device configuration
> parameters are retrieved

Thanks for rearranging the code, this looks good to me.

Acked-by: Magnus Damm <damm@opensource.se>

To be clear, I prefer your approach over a per-SoC compatible string.

In general I think a per-SoC compatible string is nice in theory, but
I don't think it is correct to use it to describe a change in a IP
block that just happens to included in the SoC. Instead the version of
the IP block shall be used with the compatible value. In some cases it
may not be easy to retrieve such a version.

The per-SoC compatible string may look good but they come with at
least two drawbacks. Either
1) the driver has to be updated for each new SoC even though the
device IP the driver is handling hasn't changed which leads to
1.1) more need for pointless per-SoC compatible string patches to be
merged and tracked and back ported
and
1.2) less chance of running a standard distro lacking per-SoC
compatible string but has actual code for support
or
2) to ship soon the per-SoC DT will use SoC compatible strings
matching other SoC names which works but is even more confusing.

For the INTC irqpin case I believe this approach with a single
property is the best.

Thanks,

/ magnus
