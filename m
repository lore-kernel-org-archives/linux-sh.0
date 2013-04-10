From: Barry Song <21cnbao@gmail.com>
Date: Wed, 10 Apr 2013 14:00:52 +0000
Subject: Re: [PATCH 07/14] media: soc-camera: support deferred probing of clients
Message-Id: <CAGsJ_4wVx8qr1ge9g3ekmZd=BnYAmjOsSXSQh8Zsb=_NZOA9bQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <1348754853-28619-8-git-send-email-g.liakhovetski@gmx.de> <CAGsJ_4yUY6PE0NWZ9yaOLFmRb3O-HL55=w7Y6muwL0YbkJtP0Q@mail.gmail.com>
 <Pine.LNX.4.64.1304101358490.13557@axis700.grange> <CAGsJ_4xn_R7D7Uh0dJB7WuDQG3K_mZkMwYNtMDuHMhX+4oTk=Q@mail.gmail.com>
 <20130410135627.GD9243@opensource.wolfsonmicro.com>
In-Reply-To: <20130410135627.GD9243@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "renwei.wu" <renwei.wu@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, xiaomeng.hou@csr.com, zilong.wu@csr.com

2013/4/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Apr 10, 2013 at 09:53:20PM +0800, Barry Song wrote:
>> 2013/4/10 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
>
>> >> what about another possible way:
>> >> we let all host and i2c client driver probed in any order,
>
>> > This cannot work, because some I2C devices, e.g. sensors, need a clock
>> > signal from the camera interface to probe. Before the bridge driver has
>> > completed its probing and registered a suitable clock source with the
>> > v4l2-clk framework, sensors cannot be probed. And no, we don't want to
>> > fake successful probing without actually being able to talk to the
>> > hardware.
>
>> i'd say same dependency also exists on ASoC.  a "fake" successful
>> probing doesn't mean it should really begin to work if there is no
>> external trigger source.  ASoC has successfully done that by a machine
>> driver to connect all DAI.
>> a way is we put all things ready in their places, finally we connect
>> them together and launch the whole hardware flow.
>
> In the ASoC case the idea is that drivers should probe as far as they
> can with just the chip and then register with the core.  The machine
> driver defers probing until all components have probed and then runs
> through second stage initialisaton which pulls everything together.

yes. thanks for clarification, Mark. that is really what i want in
soc-camera too.
put all things in their places, and the final connector wait for
everyone and put them in the initialized status.

-barry
