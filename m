From: Simon Horman <horms@verge.net.au>
Date: Fri, 14 Nov 2014 03:02:36 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: koelsch dts: Drop console= bootargs parameter
Message-Id: <20141114030235.GA28000@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592918-25138-1-git-send-email-geert+renesas@glider.be>
 <1414592918-25138-4-git-send-email-geert+renesas@glider.be>
 <42870768.kOpZNjp1qs@avalon>
 <CAMuHMdUOX845FFaNkEan9c+fRrsSk4q0gXUeknTn-MK5JAYWGg@mail.gmail.com>
In-Reply-To: <CAMuHMdUOX845FFaNkEan9c+fRrsSk4q0gXUeknTn-MK5JAYWGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Oct 30, 2014 at 12:03:22PM +0100, Geert Uytterhoeven wrote:
> On Thu, Oct 30, 2014 at 11:44 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Wednesday 29 October 2014 15:28:38 Geert Uytterhoeven wrote:
> >> Since commit 595c6a4bb77f0096 ("ARM: shmobile: koelsch: Remove legacy C
> >> board code"), koelsch is restricted to booting from DT, so
> >> chosen/stdout-path is always used, and we can drop the "console="
> >> parameter from chosen/bootargs.
> >
> > I'm curious, how is the baud rate now selected ?
> 
> >From an earlier response for kzm9d:
> 
> "I forgot emev is the only supported SoC not using sh-sci.
>  drivers/tty/serial/sh-sci.c:serial_console_setup() defaults to 115200 baud,
>  while serial8250_console_setup() defaults to 9600 baud."

Hi Geert,

while backporting this and similar changes for other boards
to v3.14/LTSI-3.14 I noticed that koelsch, alt and ape6evm-reference
come up without a console. Which is not ideal.

I am wondering if you have any thoughts on why this may occur.
My wild stab in the dark is some interaction with PM.

For reference my backport is the backport/v3.14.23/snapshot2.wip1 tag in my
renesas-backports tree. At the very top it includes reversions of the
backports of the troublesome patches.
