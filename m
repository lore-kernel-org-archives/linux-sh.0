From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 18 Feb 2014 08:24:41 +0000
Subject: Re: [Linux-kernel] [PATCH] [PATCH v2] sh_eth: call of_mdiobus_register() to register phys
Message-Id: <530318C9.5040508@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 18/02/14 08:23, Ben Dooks wrote:
> On 17/02/14 21:09, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 02/17/2014 07:57 PM, Ben Dooks wrote:
>>
>>> If the sh_eth device is registered using OF, then the driver
>>> should call of_mdiobus_register() to register any PHYs connected
>>> to the system.
>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>
>>> --
>>> v2:
>>>     - allocate mdio->irq array at init time
>>
>>     Did this also fix something?
>>
>>>     - set devdata after succesful mdio registration
>>> ---
>>>   drivers/net/ethernet/renesas/sh_eth.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/renesas/sh_eth.c
>>> b/drivers/net/ethernet/renesas/sh_eth.c
>>> index 06970ac..1244509 100644
>>> --- a/drivers/net/ethernet/renesas/sh_eth.c
>>> +++ b/drivers/net/ethernet/renesas/sh_eth.c
>>> @@ -40,6 +40,7 @@
>>>   #include <linux/if_vlan.h>
>>>   #include <linux/clk.h>
>>>   #include <linux/sh_eth.h>
>>> +#include <linux/of_mdio.h>
>>>
>>>   #include "sh_eth.h"
>>>
>>> @@ -2638,6 +2639,18 @@ static int sh_mdio_init(struct net_device
>>> *ndev, int id,
>>>           goto out_free_bus;
>>>       }
>>>
>>> +    if (ndev->dev.parent->of_node) {
>>> +        ret = of_mdiobus_register(mdp->mii_bus,
>>> +                      ndev->dev.parent->of_node);
>>> +        if (ret != 0) {
>>
>>     Why not just (ret)?

Because of years of people complaining that an integer is not
a boolean. I'll change that in the next version of the patch.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
