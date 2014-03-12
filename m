From: Paul Carpenter <paul@pcserviceselectronics.co.uk>
Date: Wed, 12 Mar 2014 08:39:34 +0000
Subject: Re: rcar-i2c: always reads a byte
Message-Id: <53201D46.9000306@pcserviceselectronics.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <531F3686.7050808@codethink.co.uk> <53201A83.7040605@gmx.de>
In-Reply-To: <53201A83.7040605@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Lawnick <ml.lawnick@gmx.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

Michael Lawnick wrote:
 > Hi,
 >
 > Ben Dooks schrieb:
 >> I have noticed the following behaviour with the i2c-rcar driver
 >> with the following single i2c_msg structure:
 >>
 >>     msg[0].addr = 0x12;
 >>     msg[0].flags = I2C_M_RD;
 >>     msg[0].len = 0;
 >>     msg[0].buf = data;
 >
 > isn't this illegal?
 > This should lead to 50% chance of blocked bus: After sending read-bit
 > the slave ACK's and puts first data bit onto SDL. If it is '0',

NO device should change the data line during SCL rising or SCL HIGH
this would cause STOP/START confusion.

The data line should be driven at detection of SCL falling (or just
after normally.

 > master
 > won't be able to signal stop nor arbitrate the bus for other transaction
 > until slave runs into internal timeout (*if* supported).

Master can signal STOP during SCL HIGH as normal.

 > Only 9 SCL toggles will be able to free bus again.

If there is not a short or other fault on SCL being held low, drive as
much as you like wont make any difference.

 > But maybe I'm missing something.

See above

 > KR
 > Michael

-- 
Paul Carpenter          | paul@pcserviceselectronics.co.uk
<http://www.pcserviceselectronics.co.uk/>    PC Services
<http://www.pcserviceselectronics.co.uk/pi/>  Raspberry Pi Add-ons
<http://www.pcserviceselectronics.co.uk/fonts/> Timing Diagram Font
