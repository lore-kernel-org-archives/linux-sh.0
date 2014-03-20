From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 20 Mar 2014 15:28:44 +0000
Subject: Re: [PATCH/RFC 1/5] sh_eth: Use the platform device for memory allocation
Message-Id: <532B092C.4080000@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395185156-6681-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395185156-6681-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 20-03-2014 17:43, Laurent Pinchart wrote:

>>> On 03/19/2014 02:25 AM, Laurent Pinchart wrote:
>>>> Memory allocated for the MDIO bus with the devm_kzalloc() API is
>>>> associated with the network device. While this will cause memory to be
>>>> freed at the right time, it doesn't allow allocating memory before the
>>>> network device is initialized.

>>>> Replace the network device with the parent platform device for memory
>>>> allocation to remove that dependency. This also improves consistency
>>>> with the other devm_* calls in the driver that all use the platform
>>>> device.

>>>> Signed-off-by: Laurent Pinchart
>>>> <laurent.pinchart+renesas@ideasonboard.com>
>>>> ---
>>>>
>>>>    drivers/net/ethernet/renesas/sh_eth.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)

>>>> diff --git a/drivers/net/ethernet/renesas/sh_eth.c
>>>> b/drivers/net/ethernet/renesas/sh_eth.c index be7211d..b80abb6 100644
>>>> --- a/drivers/net/ethernet/renesas/sh_eth.c
>>>> +++ b/drivers/net/ethernet/renesas/sh_eth.c
>>>> @@ -2615,10 +2615,10 @@ static int sh_mdio_init(struct net_device *ndev,
>>>> int id,>
>>>>
>>>>    	int ret, i;
>>>>    	struct bb_info *bitbang;
>>>>    	struct sh_eth_private *mdp = netdev_priv(ndev);

>>> I'd suggest to also declare:
>>> 	struct platform_device *pdev = &mdp->pdev;

>>> so that you could simplify 'mdev->pdev->name' derefs in the sprintf() call
>>> and to get rid of the 'id' parameter to sh_mdio_init() by using 'pdev->id'
>>> directly in the same call.

>> Good idea. I'll do that in patch 2/5 for v2.

> I meant 3/5, sorry.

    In fact, I think it would fit better in either this patch or a separate 
patch (at least removal of 'id' parameter probably deserves a separate patch).

WBR, Sergei

