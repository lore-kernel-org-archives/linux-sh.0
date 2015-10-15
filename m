From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 15 Oct 2015 17:15:38 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Wait for IRQs completion when freeing channel
Message-Id: <561FDF3A.6080103@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/15/2015 07:04 PM, Laurent Pinchart wrote:
> On Wednesday 14 October 2015 13:02:22 Lars-Peter Clausen wrote:
>> On 10/14/2015 12:50 PM, Vinod Koul wrote:
>>> On Thu, Oct 08, 2015 at 04:51:30PM +0200, Lars-Peter Clausen wrote:
>>>>> The DMA engine API states that
>>>>>
>>>>>    * device_terminate_all
>>>>>    
>>>>>      - Aborts all the pending and ongoing transfers on the channel
>>>>>      - This command should operate synchronously on the channel,
>>>>>      
>>>>>        terminating right away all the channels
>>>>>
>>>>> I wonder how to interpret "synchronously" here, should terminate_all()
>>>>> wait for termination to be complete ? In that case it wouldn't be valid
>>>>> to call it from non-sleepable context.
>>>>
>>>> We need to extend the DMAengine API to allow synchronization. The issue
>>>> is not only the IRQ itself but also the tasklet that can be scheduled
>>>> from the IRQ. Since we in some cases (e.g. audio underrun) call
>>>> terminate_all() from within the completion callback that runs in the in
>>>> the tasklet we can't synchronize to the tasklet in
>>>> dmaengine_terminate_all(). We need a separate API call to handle this.
>>>> And then maybe have a helper like dmaengine_terminate_all_sync() that
>>>> terminates and synchronizes. And in cases where terminate_all is called
>>>> from a context where it can't synchronize the new API needs to be called
>>>> separately before freeing the resources.
>>>
>>> Right now the terminate_all() is intended for syncronous behaviour which
>>> prevents it from being invoked in the callback.
>>
>> That does not match reality though. Which means the documentation is wrong.
>> Pretty much all drivers implement a non-synchronous terminate function and
>> there are users that rely on this.
> 
> Most notably audio drivers seem to call terminate_all() from a non-sleepable 
> context.
> 
> "We" (volunteers needed...) need to fix the API, the callers and the drivers. 
> In the meantime I'll resubmit this patch without making terminate_all() 
> synchronous to avoid introducing breakages.

I've started working on it. The plan is to introduce a separate per driver
device_synchronize() callback which should make sure that all callbacks have
finished running. Then introduce a dmaengine_terminate_all_async() which
does what dmaengine_terminate_all() does at the moment. A user of this
function needs to make sure to call dmaengine_synchronize() before freeing
any memory accessed by the DMA transfer itself or in the complete callback.

That part is basically done and I've updated a few drivers where I have
access to a device.

The final step then is to make dmaengine_terminate_all() synchronous by
making it call both the device_terminate_all() and device_synchronize()
callback. This will require careful review of all existing
dmaengine_terminate_all() callers to make sure that they can handle
synchronization (which might sleep).

- Lars

