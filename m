From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 26 Jan 2014 15:32:45 +0000
Subject: Re: [PATCH 3/4] i2c: rcar: do not print error if device nacks transfer
Message-Id: <52E52A9D.20608@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982298-23143-1-git-send-email-ben.dooks@codethink.co.uk> <1389982298-23143-4-git-send-email-ben.dooks@codethink.co.uk> <20140124171112.GD2629@katana>
In-Reply-To: <20140124171112.GD2629@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, horms+renesas@verge.net.au, linux-i2c@vger.kernel.org

On 24/01/14 17:11, Wolfram Sang wrote:
> On Fri, Jan 17, 2014 at 06:11:37PM +0000, Ben Dooks wrote:
>> The i2c-rcar driver currently prints an error message if the master_xfer
>> callback fails. However if the bus is being probed then lots of NAKs
>> will be generated, causing the output of a number of errors printed.
>>
>> To solve this, disable the print if the error is not -EREMOTEIO.
>
> Basically OK. Yet, according to 'fault-codes" it should be -ENXIO. May
> be a good time to fix this as well.
>
> Also, you might want to print for -EIO only? Or do you want to see
> -EAGAIN, too?

Ok, although the change to the error code should probably be a separate
patch instead of modifying this one.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
