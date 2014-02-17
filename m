From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Feb 2014 08:04:07 +0000
Subject: Re: [PATCH 3/6] i2c: rcar: do not print error if device nacks transfer
Message-Id: <5301C277.7020808@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk> <1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk> <20140216094655.GA2644@katana>
In-Reply-To: <20140216094655.GA2644@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@lists.codethink.co.uk, Simon Horman <horms+renesas@verge.net.au>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

On 16/02/14 09:46, Wolfram Sang wrote:
> On Sun, Jan 26, 2014 at 04:05:34PM +0000, Ben Dooks wrote:
>> The i2c-rcar driver currently prints an error message if the master_xfer
>> callback fails. However if the bus is being probed then lots of NAKs
>> will be generated, causing the output of a number of errors printed.
>>
>> To solve this, disable the print if the error is not -EREMOTEIO.
>>
>> An example of running i2cdetect:
>
> So, after this patch i2cdetect runs fine for you? I assume you are
> working with the lager/r8a7790 board? With koelsch/r8a7791, it stalls
> the bus :(

It runs fine most of the time, however I've seen some issues with the
bus locking up. However it seems to be random and affects either of
bus 2 or bus 3 randomly. Once the bus does lock up then there is no
possibility of further transfers.

I am trying to put together a breakout board to get at the signals
involved as they are all pretty much only available on high-density
connectors.

I hope to have a look at this before the end of the week and see if
there is a fix for this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
