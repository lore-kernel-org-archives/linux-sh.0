From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 29 Nov 2013 13:53:43 +0000
Subject: Re: [PATCH 01/03] pinctrl: sh-pfc: r7s72100 SCIF2 port3 support
Message-Id: <1644283.pjijxmSWPQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20131127080606.18384.45103.sendpatchset@w520> <20131127080621.18384.85008.sendpatchset@w520> <CACRpkdbUvitwMQ+YjMonCZAJR_9VZMai_4etZE091vDHdFWZmA@mail.gmail.com>
In-Reply-To: <CACRpkdbUvitwMQ+YjMonCZAJR_9VZMai_4etZE091vDHdFWZmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>

Hi Linus,

On Friday 29 November 2013 11:29:51 Linus Walleij wrote:
> On Wed, Nov 27, 2013 at 9:06 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Add support for SCIF2 port3 pin functions SCK, TXD and RXD to the
> > r7s72100 PINCTRL code. There are two possible pins that can be used
> > for TXD (Port 3 Pin 0 Function 6 and Port 3 Pin 1 Function 4) and
> > because of that are the data pins broken out in separate TXD and RXD.
> > 
> > This format is similar to other sh-pfc code, but a following patch
> > converts this to less verbose and less readable code.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Regarding this and other PFC patches: Laurent can you help me
> out with collecting the patches for my pinctrl tree and send me
> a pull request when it's all tested together, like you did in the
> last kernel cycle?

Sure, will do.

-- 
Regards,

Laurent Pinchart

