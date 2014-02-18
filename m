From: David Miller <davem@davemloft.net>
Date: Tue, 18 Feb 2014 23:13:17 +0000
Subject: Re: [PATCH v2] of_mdio: fix phy interrupt passing
Message-Id: <20140218.181317.1712776234149210938.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1392725818-558-1-git-send-email-ben.dooks@codethink.co.uk>
	<20140218161551.44A52C40517@trevor.secretlab.ca>
In-Reply-To: <20140218161551.44A52C40517@trevor.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@linaro.org
Cc: ben.dooks@codethink.co.uk, linux-kernel@lists.codethink.co.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com

From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 18 Feb 2014 16:15:51 +0000

> On Tue, 18 Feb 2014 12:16:58 +0000, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> The of_mdiobus_register_phy() is not setting phy->irq thus causing
>> some drivers to incorrectly assume that the PHY does not have an
>> IRQ associated with it. Not only do some drivers report no IRQ
>> they do not install an interrupt handler for the PHY.
>> 
>> Simplify the code setting irq and set the phy->irq at the same
>> time so that we cover the following issues, which should cover
>> all the cases the code will find:
>> 
>> - Set phy->irq if node has irq property and mdio->irq is NULL
>> - Set phy->irq if node has no irq and mdio->irq is not NULL
>> - Leave phy->irq as PHY_POLL default if none of the above
>> 
>> This fixes the issue:
>>  net eth0: attached PHY 1 (IRQ -1) to driver Micrel KSZ8041RNLI
>> 
>> to the correct:
>>  net eth0: attached PHY 1 (IRQ 416) to driver Micrel KSZ8041RNLI
>> 
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Looks okay to me
> 
> Reviewed-by: Grant Likely <grant.likely@linaro.org>

Applied, thanks.
