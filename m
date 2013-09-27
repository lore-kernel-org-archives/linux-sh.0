From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Sep 2013 04:46:49 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: only enable used I2C interfaces in DT on all Renesas boards
Message-Id: <20130927044647.GA19749@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309261259490.11968@axis700.grange>
 <CANqRtoRNMOsRxN9qERungFxmw=e4v83Uy4JFxSMBj9Ldu8WNOQ@mail.gmail.com>
In-Reply-To: <CANqRtoRNMOsRxN9qERungFxmw=e4v83Uy4JFxSMBj9Ldu8WNOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, SH-Linux <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org

On Thu, Sep 26, 2013 at 05:10:58PM -0700, Magnus Damm wrote:
> On Thu, Sep 26, 2013 at 4:06 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Currently all I2C interfaces in all *.dtsi files for various Renesas SoCs
> > are enabled by default. Switch them all off and only enable populated I2C
> > interfaces in board-specific *.dts files.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> 
> Excellent, thank you!

Thanks, I will queue this up with supplied Acks for v3.13.
