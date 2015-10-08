From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 08 Oct 2015 14:51:30 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Wait for IRQs completion when freeing channel
Message-Id: <561682F2.3070206@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/08/2015 04:22 PM, Laurent Pinchart wrote:
> Hi Vinod,
> 
> On Monday 05 October 2015 15:11:55 Vinod Koul wrote:
>> On Tue, Sep 15, 2015 at 12:11:33AM +0000, Kuninori Morimoto wrote:
>>> Hi Laurent
>>>
>>>> When freeing channel resources we need to ensure that no IRQ will occur
>>>> for the given channel. In order to do so the driver stops the hardware,
>>>> but an IRQ handler could still be running, especially given that the
>>>> channel IRQ is threaded. Fix it by waiting for pending IRQs completion
>>>> with synchronize_irq()
>>>>
>>>> Signed-off-by: Laurent Pinchart
>>>> <laurent.pinchart+renesas@ideasonboard.com>
>>>> ---
>>>>
>>>>  drivers/dma/sh/rcar-dmac.c | 37 +++++++++++++++++++------------------
>>>>  1 file changed, 19 insertions(+), 18 deletions(-)
>>>>
>>>> Hi Morimoto-san,
>>>>
>>>> This patch is compile-tested only. Would you be able to check if it
>>>> fixes the issue you've reported with SDHI and rcar-dmac ?
>>>
>>> Thanks. I will ask to BSP team
>>
>> Patch looks okay, but if we get this confirmation it would be great.
> 
> I've just received a report that the patch has been successfully tested to get 
> rid of the oops, but it introduced another issue in that synchronize_irq() 
> gets called from non-sleeptable context through terminate_all(). 
> 
> The DMA engine API states that
> 
>    * device_terminate_all
>      - Aborts all the pending and ongoing transfers on the channel
>      - This command should operate synchronously on the channel,
>        terminating right away all the channels
> 
> I wonder how to interpret "synchronously" here, should terminate_all() wait 
> for termination to be complete ? In that case it wouldn't be valid to call it 
> from non-sleepable context.

We need to extend the DMAengine API to allow synchronization. The issue is
not only the IRQ itself but also the tasklet that can be scheduled from the
IRQ. Since we in some cases (e.g. audio underrun) call terminate_all() from
within the completion callback that runs in the in the tasklet we can't
synchronize to the tasklet in dmaengine_terminate_all(). We need a separate
API call to handle this. And then maybe have a helper like
dmaengine_terminate_all_sync() that terminates and synchronizes. And in
cases where terminate_all is called from a context where it can't
synchronize the new API needs to be called separately before freeing the
resources.

I've talked about this in the past here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067155.html

- Lars

