From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 29 Jan 2014 09:36:50 +0000
Subject: Re: [PATCH V3 0/3] ARM: shmobile: lager: Add USB support
Message-Id: <52E8CBB2.6000108@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/29/2014 12:40 PM, Ben Dooks wrote:
> On 28/01/14 21:37, Valentine wrote:
>> On 01/27/2014 04:17 PM, Ben Dooks wrote:
>>> On 27/01/14 10:02, Valentine wrote:
>>>> On 01/27/2014 01:59 PM, Ben Dooks wrote:
>>>>> On 24/01/14
>>>
>>> [snip]
>>>
>>>>> Hi, when doing this have you come across a problem where the OHCI
>>>>> controller on USB0 fails to start with an initialisation error? I
>>>>> think it is something to do with the bridge setup but have yet to
>>>>> have enough time to look into this issue.
>>>>>
>>>>
>>>> All PCI ports have worked fine for me.
>>>> Please, check that the SW5/SW6 pins are set correctly on your board.
>>>
>>> SW5 is at position 1
>>> SW6 is at position 1
>>>
>>
>> If the issue doesn't happen on other busses this is most likely
>> port misconfiguration issue. Looks like the USB phy channel 0 is not
>> configured properly.
>> Please, make sure that you have all the patches
>> noted in the cover-letter applied and that you're using the latest
>> devel tag from the renesas git.
>
> Thanks. I am currently in the middle of trying to sort out merging
> together what we do have to just get the DT support going on the
> Lager board. This is making re-basing quite difficult as our tree
> is in the region of 60 patches over Simon's devel tree!
>
> I am going to have to push working on this out to at-least next week
> when hopefully we will have a new kernel to start working on with
> some of these patches merged.
>
> It is weird, since the OHCI driver dies with what looks like a failure
> to DMA memory.

Could you please share the full kernel log?

Thanks,
Val.

>
>

