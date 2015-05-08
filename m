From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 08 May 2015 08:54:01 +0000
Subject: Re: [RFC] i2c-tools: i2ctransfer: add new tool
Message-Id: <20150508105401.223a8598@endymion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <1425053816-19804-1-git-send-email-wsa@the-dreams.de>
	<20150507220812.3776bb83@endymion.delvare>
In-Reply-To: <20150507220812.3776bb83@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org

On Thu, 7 May 2015 22:08:12 +0200, Jean Delvare wrote:
> Hi Wolfram,
> 
> On Fri, 27 Feb 2015 17:16:56 +0100, Wolfram Sang wrote:
> > This tool allows to construct and concat multiple I2C messages into one
> > single transfer. Its aim is to test I2C master controllers, and so there
> > is no SMBus fallback.
> > 
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> > 
> > I've been missing such a tool a number of times now, so I finally got around to
> > writing it myself. As with all I2C tools, it can be dangerous, but it can also
> > be very useful when developing. I am not sure if distros should supply it, I'll
> > leave that to Jean's experience. For embedded build systems, I think this
> > should be selectable. It is RFC for now because it needs broader testing and some
> > more beautification. However, I've been using it already to test the i2c_quirk
> > infrastructure and Renesas I2C controllers.
> 
> I took a very quick look today and I am fine with the general idea but
> one thing I don't like is the user interface. All parameters look the
> same even though they have very different meanings. It's very easy to
> get it wrong and guess what, at my very first attempt I managed to do
> exactly that. I was lucky enough that my incorrect syntax was not
> accepted by the tool, but with slightly different values it would have
> been accepted and and the tool would have performed something different
> from what I wanted to do. Possibly with tragic consequences.
> 
> So instead of:
> 
> # i2ctransfer 0 0x50 w 0x11 0xc0 0xbd= 0x51 r 1
> 
> I would have imagined something like:
> 
> # i2ctransfer 0 w@0x50 0x11 0xc0 0xbd= r@0x51 1
> 
> This at least avoids passing addresses as register values or
> vice-versa. What do you think? Or maybe it's just me being an idiot and
> other users would get it right even with your proposed syntax.
> 
> My alternative proposal leaves the potential problem of mixing length
> and register values. I am not necessarily a fan of passing the write
> length on the command line, but it is similar to the read commands, and
> I see it allows writing the same value to a whole register range with
> little effort, so it does have some value. So I guess it's OK.

Having slept over it, I came up with a 3rd proposal:

# i2ctransfer 0 w0x11@0x50 0xc0 0xbd= r1@0x51

That is, combining the slave address, direction and length into a
single parameter. The advantage is that this is all more explicit and
the risk of mixing up values is close to zero. Whether it is more or
less readable than the previous proposals is probably a matter of
taste. Also I suspect it would make the parsing and state machine more
simple, but that's only a nice side effect.

Wolfram (and others), please tell me what you think. I am not trying to
force my views here, just suggesting alternatives for your
consideration.

-- 
Jean Delvare
SUSE L3 Support
