From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 19 Mar 2014 15:56:02 +0000
Subject: Re: [PATCH/RFC 0/5] Fix the sh_eth race between open and MDIO bus registration
Message-Id: <5329BE12.4020104@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 19/03/14 16:48, Laurent Pinchart wrote:
> Hi Ben,
>
> On Wednesday 19 March 2014 16:45:01 Ben Dooks wrote:
>> On 19/03/14 16:06, Laurent Pinchart wrote:
>>> On Wednesday 19 March 2014 14:35:59 Geert Uytterhoeven wrote:
>>>> On Wed, Mar 19, 2014 at 11:07 AM, Laurent Pinchart wrote:
>>>>> On Wednesday 19 March 2014 10:14:53 Ben Dooks wrote:
>>>>>> On 19/03/14 08:41, Geert Uytterhoeven wrote:
>>>>>>> On Wed, Mar 19, 2014 at 12:25 AM, Laurent Pinchart wrote:
>>>>>>>> Laurent Pinchart (5):
>>>>>>>>      sh_eth: Use the platform device for memory allocation
>>>>>>>>      sh_eth: Use the platform device as the MDIO bus parent
>>>>>>>>      sh_eth: Simplify MDIO bus initialization and release
>>>>>>>>      sh_eth: Register MDIO bus before registering the network device
>>>>>>>>      sh_eth: Remove goto statements that jump straight to a return
>>>>>>>
>>>>>>> Thanks, the changes look fine to me, so
>>>>>>
>>>>>> I think the only issue I have is the re-parent of the MDIO device.
>>>>>>
>>>>>> My view also is that the probe should explicitly get a reference if it
>>>>>> is going to be created sub-devices.
>>>>>
>>>>> I'm not sure to follow you, could you please elaborate on that ? What
>>>>> should take a reference on what ?
>>>>
>>>> I think he means a runtime pm reference, and he is right.
>>>>
>>>> I gave your series a try on Koelsch. Now the clock is:
>>>>     1. enabled in sh_eth_drv_probe(),
>>>>     2. disabled from the worker thread,
>>>>     3. enabled and disabled in sh_eth_get_stats(),
>>>>     4. enabled in sh_eth_open() for nfsroot,
>>>>     5. disabled in sh_eth_close() on shutdown,
>>>>     6. enabled and disabled in sh_eth_get_stats().
>>>>
>>>> I wondered whether 2 could happen too soon, so I added msleep(2000) to
>>>> sh_eth_drv_probe(), just after the call to pm_runtime_resume(). Then it
>>>> fails to obtain the MAC address:
>>>>
>>>> sh-eth ee700000.ethernet: no valid MAC address supplied, using a random
>>>> one.
>>>>
>>>> Due to 4, the network hardware works, and it manages to receive an IP
>>>> address from my DHCP server. But as the MAC address is wrong, the IP
>>>> address is also wrong, and it hangs when trying to mount NFS.
>>>>
>>>> Applying Ben's "PATCH] sh_eth: ensure pm_runtime cannot suspend the
>>>> device during init" fixes this.
>>>
>>> I've investigated the issue. The pm_runtime_resume() call from the sh_eth
>>> probe function ends up calling rpm_resume() synchronously. The function
>>> resumes the device, and right before returning calls rpm_idle(dev,
>>> RPM_ASYNC). This queues a RPM_REQ_IDLE request, resulting in the device
>>> being suspended the next time the work queue is run.
>>>
>>> pm_runtime_resume() seem to be unsafe at probe time if the PM workqueue
>>> can run before the probe function is done with the device, which means
>>> pretty much everywhere as probe() usually calls functions that can sleep.
>>>
>>> I thus agree that a pm_runtime_get_sync() call is needed. The
>>> pm_runtime_put_sync() call at the end of the probe function could be
>>> replaced by a pm_runtime_put() call though. The PM runtime documentation
>>> should also be updated.
>>
>> Thanks, that validates what I saw but did not get time to fully
>> trace.
>>
>> I agree that pm_runtime_put() is probably a better option as we do
>> not need to ensure that the device is shut down immediately. I will
>> re-do the patch and submit it tonight.
>
> Thank you. Could you please also submit a patch that fixes the runtime PM
> documentation ? It doesn't have to be long, but driver writers should be
> warned of the potential pm_runtime_resume() issues. This should also help
> getting a reply from the runtime PM developers.

Yes, good idea.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
