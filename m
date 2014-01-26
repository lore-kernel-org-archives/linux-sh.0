From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 26 Jan 2014 15:33:05 +0000
Subject: Re: [PATCH 4/4] i2c: rcar: use devm_clk_get to ensure clock is properly ref-counted
Message-Id: <52E52AB1.7070309@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982298-23143-1-git-send-email-ben.dooks@codethink.co.uk> <1389982298-23143-5-git-send-email-ben.dooks@codethink.co.uk> <20140124171254.GE2629@katana>
In-Reply-To: <20140124171254.GE2629@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, horms+renesas@verge.net.au, linux-i2c@vger.kernel.org

On 24/01/14 17:12, Wolfram Sang wrote:
> On Fri, Jan 17, 2014 at 06:11:38PM +0000, Ben Dooks wrote:
>> The current i2c-rcar driver does clk_get() without a corresponding
>> clk_put(). Add the clk to the driver private data and then get it
>> with the devm functions so that it is released when the driver is
>> unbound.
>>
>
>>
>> +	priv->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(priv->clk)) {
>> +		dev_err(dev, "cannot get clock\n");
>> +		return -ENOENT;
>> +	}
>
> Return the error here?

Yes, will change this to be PTR_ERR(priv->clk) and re-send

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
