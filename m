From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 08 Feb 2013 13:23:38 +0000
Subject: Re: [PATCH 0/3] MMCIF and SDHI for kzm9g- and armadillo800eva-reference
Message-Id: <CANqRtoSeB7Z8OGk0TuR-D8MkciXeWyRNGyjYxCpD4gQnBHLSwg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1302080017430.30556@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1302080017430.30556@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Guennadi,

Thanks a lot for your effort!

On Fri, Feb 8, 2013 at 8:31 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> These patches add SDHI and MMCIF interfaces to device trees for kzm9g- and
> armadillo800eva-reference boards. Without pinctrl in DT support interface
> pins, card-detect and regulator GPIOs cannot be used. These can be added,
> once pinctrl is available.

Looking good! This patch set very nice because it shows what is
possible with the current kernel. Without that people would have to
figure out the current state by themselves. From now on, please make
sure the board code is kept in sync with whatever bindings and
frameworks like PINCTRL that become available over time.

Cheers,

/ magnus
