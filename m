From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 28 Mar 2014 08:30:42 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <6506478.py2Axu25u1@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon> <20140328072827.GY17250@pengutronix.de> <CAMuHMdUaywK4JiiKgr=6=kFoQKQuuh=+_-ThYECr53U1cuVNLA@mail.gmail.com>
In-Reply-To: <CAMuHMdUaywK4JiiKgr=6=kFoQKQuuh=+_-ThYECr53U1cuVNLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robherring2@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, devicetree-spec@vger.kernel.org

On Friday 28 March 2014 09:09:23 Geert Uytterhoeven wrote:
> 
> On the Renesas SoCs, where this thread started, you also have different
> types of IP blocks providing similar functionality on the same SoC.
> E.g. 3 types of serial ports, 2 types of i2c, (at least) 2 types of spi...
> Hence one more level of confusion (is SoC serial0 the first serial port of
> type A, B, or C?).

The 'serial' aliases are defined to refer to UARTs only, there is no debate
about that.

	Arnd
