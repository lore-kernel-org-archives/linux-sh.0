From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 17 Mar 2014 11:35:13 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <2571058.sI0rr4BdJo@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Monday 17 March 2014 11:20:32 Ben Dooks wrote:
> On 15/03/14 11:19, Laurent Pinchart wrote:
> > On Friday 14 March 2014 19:00:05 Ben Dooks wrote:
> >> It seems the pm_rumtime work queue is causing the device to be suspended
> >> during initialisation,
> > 
> > Have you investigated through which call path(s) this happens ? If device
> > can be runtime suspended during their probe function despite calling
> > pm_runtime_resume() then I don't see the point of that function at all.
> > 
> >> thus the initialisation may not be able to access registers properly. Use
> >> pm_runtime_get_sync() and pm_runtime_put_sync() to ensure that the pm
> >> system does not suspend it during the probe() call.
> >> 
> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >> ---
> >> 
> >>   drivers/net/ethernet/renesas/sh_eth.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/drivers/net/ethernet/renesas/sh_eth.c
> >> b/drivers/net/ethernet/renesas/sh_eth.c index 4f76b5e..88aac2c 100644
> >> --- a/drivers/net/ethernet/renesas/sh_eth.c
> >> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> >> @@ -2870,6 +2870,7 @@ static int sh_eth_drv_probe(struct platform_device
> >> *pdev)
> >>   	mdp->pdev = pdev;
> >>   	pm_runtime_enable(&pdev->dev);
> >>   	pm_runtime_resume(&pdev->dev);
> >> +	pm_runtime_get_sync(&pdev->dev);
> > 
> > I believe pm_runtime_resume() isn't needed anymore if we call
> > pm_runtime_get_sync().
> > 
> >>   	if (pdev->dev.of_node)
> >>   		pd = sh_eth_parse_dt(&pdev->dev);
> >> @@ -2961,6 +2962,7 @@ static int sh_eth_drv_probe(struct platform_device
> >> *pdev)
> >>   	pr_info("Base address at 0x%x, %pM, IRQ %d.\n",
> >>   		(u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
> >> 
> >> +	pm_runtime_put_sync(&pdev->dev);
> >>   	platform_set_drvdata(pdev, ndev);
> >>   	
> >>   	return ret;
> 
> I will look at removing the pm_runtime_resume call as well in this patch.

Thank you. It would also be nice if you could find out what causes the PM 
runtime work queue to suspend the device. pm_runtime_resume() is documented as 
being the function to call at probe time. I'd like to know whether the problem 
comes from the PM runtime core itself, in which case the documentation should 
be updated or the PM runtime core should be fixed, or from operations 
performed by the sh-eth driver, in which case we might need a different fix in 
the driver.

-- 
Regards,

Laurent Pinchart

