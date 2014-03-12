From: Michael Lawnick <ml.lawnick@gmx.de>
Date: Wed, 12 Mar 2014 08:27:47 +0000
Subject: Re: rcar-i2c: always reads a byte
Message-Id: <53201A83.7040605@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <531F3686.7050808@codethink.co.uk>
In-Reply-To: <531F3686.7050808-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi,

Ben Dooks schrieb:
> I have noticed the following behaviour with the i2c-rcar driver
> with the following single i2c_msg structure:
>
> 	msg[0].addr = 0x12;
> 	msg[0].flags = I2C_M_RD;
> 	msg[0].len = 0;
> 	msg[0].buf = data;

isn't this illegal?
This should lead to 50% chance of blocked bus: After sending read-bit 
the slave ACK's and puts first data bit onto SDL. If it is '0', master 
won't be able to signal stop nor arbitrate the bus for other transaction 
until slave runs into internal timeout (*if* supported).
Only 9 SCL toggles will be able to free bus again.

But maybe I'm missing something.

KR
Michael

