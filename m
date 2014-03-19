From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Mar 2014 15:33:40 +0000
Subject: Re: [PATCH/RFC 3/5] sh_eth: Simplify MDIO bus initialization and release
Message-Id: <5329B8D4.6020006@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395185156-6681-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395185156-6681-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 19.03.2014 19:28, Laurent Pinchart wrote:

>>> The network device passed to the sh_mdio_init and sh_mdio_release
>>> functions is only used to access the sh_eth_private instance. Pass it
>>> directly to those functions.

>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas@ideasonboard.com>
>>> ---
>>>
>>>    drivers/net/ethernet/renesas/sh_eth.c | 27 +++++++++------------------
>>>    1 file changed, 9 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/renesas/sh_eth.c
>>> b/drivers/net/ethernet/renesas/sh_eth.c index 7f7085e..55715f3 100644
>>> --- a/drivers/net/ethernet/renesas/sh_eth.c
>>> +++ b/drivers/net/ethernet/renesas/sh_eth.c
>>> @@ -2592,29 +2592,23 @@ static void sh_eth_tsu_init(struct sh_eth_private
>>> *mdp)
>>>    }
>>>
>>>    /* MDIO bus release function */
>>> -static int sh_mdio_release(struct net_device *ndev)
>>> +static int sh_mdio_release(struct sh_eth_private *mdp)
>>>   {
>>> -	struct mii_bus *bus = dev_get_drvdata(&ndev->dev);

>> I think you should have kept the variable, just changed the initializer, so
>> that repetitive 'mdp->mii_bus' derefs could be avoided.

> I've actually pondered about that, but given that mdp->mii_bus is used twice
> only I've decided to remove the local variable.

    Ah, then indeed not worth it, probably. I somehow managed to count 3 
times. :-)

>> [...]

>>> @@ -2654,10 +2648,9 @@ static int sh_mdio_init(struct net_device *ndev,
>>> int id,
>>>    		goto out_free_bus;
>>>    	}
>>>
>>> -	/* register mdio bus */
>>> -	if (ndev->dev.parent->of_node) {
>>> -		ret = of_mdiobus_register(mdp->mii_bus,
>>> -					  ndev->dev.parent->of_node);
>>> +	/* register MDIO bus */
>>> +	if (dev->of_node) {
>>> +		ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
>>
>> This change looks like it belongs to another, earlier patch, where you
>> introduce the 'dev' variable. Although... it seems to only be necessiated by
>> this patch, so you're probably right.

> That's also a question I've asked myself :-) Both options make sense, and I've
> decided to pick this one.

    Yes, I completely agree now.

WBR, Sergei

