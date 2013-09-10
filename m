From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 10 Sep 2013 22:49:49 +0000
Subject: Re: [PATCH 3/5] i2c: rcar: add Device Tree support
Message-Id: <CANqRtoRXByHeJP==qbk-VH7HgGBN9MWE1eE1nL88jfYhF1uOXg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
	<1378742120-11135-4-git-send-email-g.liakhovetski@gmx.de>
	<CANqRtoTrCwd=+m6SPO2TqvvSjEO-m4uMrChxSYs_ZxniA-7dwQ@mail.gmail.com>
	<1460028.QECHppQ2H2@avalon>
In-Reply-To: <1460028.QECHppQ2H2@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, "Simon Horman [Horms]" <horms@verge.net.au>

Hi Laurent,

On Wed, Sep 11, 2013 at 7:46 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Wednesday 11 September 2013 07:40:54 Magnus Damm wrote:
>> Hi Guennadi,
>>
>> [CC Simon, Laurent]
>>
>> On Tue, Sep 10, 2013 at 12:55 AM, Guennadi Liakhovetski wrote:
>> > This patch adds Device Tree support to the i2c-rcar driver and respective
>> > documentation.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>> > ---
>> >
>> >  Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   22 +++++++++++++++
>> >  drivers/i2c/busses/i2c-rcar.c                      |   20 ++++++++++++++-
>> >  2 files changed, 40 insertions(+), 2 deletions(-)
>> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-rcar.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
>> > b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt new file mode 100644
>> > index 0000000..b3c030b
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
>> > @@ -0,0 +1,22 @@
>> > +I2C for R-Car platforms
>> > +
>> > +Required properties:
>> > +- compatible: Must be one of
>> > +       "renesas,i2c-rcar"
>> > +       "renesas,i2c-rcar-h1"
>> > +       "renesas,i2c-rcar-h2"
>>
>> Is this following the same style as other DT patches? It looks to me
>> that you may want to use r8a7779 and r8a7790 instead of h1 and h2.
>>
>> Simon, Laurent, what do you think about this?
>
> I think that should be "renesas,i2c-r8a7779" and "renesas,i2c-r8a7790", yes.

Thanks for your comments. I recall that r8a7790 has a bunch of
channels and at least two types of i2c controllers. I wonder what the
proper naming would be then...

/ magnus
