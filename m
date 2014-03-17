From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Mar 2014 12:56:00 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <5326F0E0.4090102@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 17/03/14 11:53, Laurent Pinchart wrote:
> Hi Ben,
>
> On Monday 17 March 2014 11:40:11 Ben Dooks wrote:
>> On 17/03/14 11:35, Laurent Pinchart wrote:
>>> On Monday 17 March 2014 11:20:32 Ben Dooks wrote:
>>>> On 15/03/14 11:19, Laurent Pinchart wrote:
>>>>> On Friday 14 March 2014 19:00:05 Ben Dooks wrote:
>>>>>> It seems the pm_rumtime work queue is causing the device to be
>>>>>> suspended during initialisation,
>>>>>
>>>>> Have you investigated through which call path(s) this happens ? If
>>>>> device can be runtime suspended during their probe function despite
>>>>> calling pm_runtime_resume() then I don't see the point of that function
>>>>> at all.
>>>>>
>>>>>> thus the initialisation may not be able to access registers properly.
>>>>>> Use pm_runtime_get_sync() and pm_runtime_put_sync() to ensure that the
>>>>>> pm system does not suspend it during the probe() call.
>>>>>>
>>>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>>> ---
>>>>>>
>>>>>>     drivers/net/ethernet/renesas/sh_eth.c | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/net/ethernet/renesas/sh_eth.c
>>>>>> b/drivers/net/ethernet/renesas/sh_eth.c index 4f76b5e..88aac2c 100644
>>>>>> --- a/drivers/net/ethernet/renesas/sh_eth.c
>>>>>> +++ b/drivers/net/ethernet/renesas/sh_eth.c
>>>>>> @@ -2870,6 +2870,7 @@ static int sh_eth_drv_probe(struct
>>>>>> platform_device *pdev)
>>>>>>     	mdp->pdev = pdev;
>>>>>>     	pm_runtime_enable(&pdev->dev);
>>>>>>     	pm_runtime_resume(&pdev->dev);
>>>>>> +   	pm_runtime_get_sync(&pdev->dev);
>>>>>
>>>>> I believe pm_runtime_resume() isn't needed anymore if we call
>>>>> pm_runtime_get_sync().
>>>>>
>>>>>>     	if (pdev->dev.of_node)
>>>>>>     		pd = sh_eth_parse_dt(&pdev->dev);
>>>>>> @@ -2961,6 +2962,7 @@ static int sh_eth_drv_probe(struct
>>>>>> platform_device *pdev)
>>>>>>     	pr_info("Base address at 0x%x, %pM, IRQ %d.\n",
>>>>>>     		(u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
>>>>>>
>>>>>> +   	pm_runtime_put_sync(&pdev->dev);
>>>>>>     	platform_set_drvdata(pdev, ndev);
>>>>>>     	
>>>>>>     	return ret;
>>>>
>>>> I will look at removing the pm_runtime_resume call as well in this patch.
>>>
>>> Thank you. It would also be nice if you could find out what causes the PM
>>> runtime work queue to suspend the device. pm_runtime_resume() is
>>> documented as being the function to call at probe time. I'd like to know
>>> whether the problem comes from the PM runtime core itself, in which case
>>> the documentation should be updated or the PM runtime core should be
>>> fixed, or from operations performed by the sh-eth driver, in which case
>>> we might need a different fix in the driver.
>>
>> I'm not entirely sure, pm_runtime_resume() seems like something to call
>> during a resume operation. It probably does not increment device use
>> count, and thus the pm worker thread is allowed to re-suspend the device
>> when it runs.
>
> Yes, but why does it do so ? The runtime PM work queue doesn't seem to go
> through devices to try and suspend them, it seems to only process delayed
> work. What queues the work that makes runtime PM suspend the device ?
>
>> pm_runtime_get_sync() is the right thing to do as we are dealing with
>> access device registers during the probe and thus should ensure the
>> device does not get shutdown until the probe has finished.
>
> pm_runtime_resume() is documented as being the function to call in the probe
> handler. I'd like to get a clarification on this from the runtime PM
> developers. If the documentation is wrong it needs to be fixed.

Hmm, wonder if it works for things that take a long time to run,
or for things that create and probe sub-devices such as the phy?

I annotated the clk-mstp.c driver to test for removal of the eth
clock and the culprit in this case was a pm thread running
before the device finished probing and suspending. I do not have
the exact debug output as I deleted it after looking in to it.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
