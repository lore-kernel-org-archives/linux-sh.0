From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 29 Jan 2014 17:05:12 +0000
Subject: Re: [PATCH RFC 0/2] ARM: shmobile: lager: Enable DMA bounce for PCI
Message-Id: <52E934C8.50900@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/29/2014 08:57 PM, Ben Dooks wrote:
> On 29/01/14 16:37, Valentine wrote:
>> On 01/29/2014 08:03 PM, Ben Dooks wrote:
>>> On 29/01/14 12:47, Valentine wrote:
>>>> On 01/29/2014 04:45 PM, Ben Dooks wrote:
>>>>> On 29/01/14 11:15, Valentine wrote:
>>>>>> On 01/29/2014 12:03 PM, Ben Dooks wrote:
>>>>>>> On 29/01/14 06:45, Simon Horman wrote:
>>>>>>>> On Tue, Jan 28, 2014 at 10:53:31PM +0400, Valentine Barshak wrote:
>>>>>>>>> This enables DMA bounce for PCI since the controller does
>>>>>>>>> not support more than 2G PCI-AHB memory window.
>>>>>>>>> The problems with DMA transfers can be observed when
>>>>>>>>> setting 2G/2G user/kernel memory split model
>>>>>>>>> (CONFIG_VMSPLIT_2G=y)
>>>>>>>>> These patches help to avoid it.
>>>>>>>>
>>>>>>>> Are these patches compatible with other user/kernel splits?
>>>>>>>
>>>>>>> PS, the bridge is only actually capable of seeing 1GiB of
>>>>>>> RAM due to alignment issues in the window. You can have either
>>>>>>> 0x4..0x8 or 0x8..0xc but not /both/. If you open the window to
>>>>>>> 2GiB then you can see either 0x0..0x8 or 0x8..0xF range.
>>>>>>>
>>>>>>
>>>>>> I don't think this is relater to the user/kernel space memory split.
>>>>>>
>>>>>> Currently the R-Car Gen2 PCI driver uses 0x40000000 - 0x7fffffff
>>>>>> PCI-AHB region. We can set it to 0x00000000 - 0x7fffffff,
>>>>>> but there's no RAM below 0x40000000 so no DMA access to that area is
>>>>>> actually legal from the PCI USB host driver.
>>>>>> So the change wouldn't give us much.
>>>>>
>>>>> Well, there's IO areas but probably not wanting to DMA to them anyway.
>>>>>
>>>>>> The 31-bit DMA mask takes care of forbidding any DMA transfers
>>>>>> to the area above 0x7fffffff.
>>>>>
>>>>> I will add this to our current patch series and see if it helps.
>>>>
>>>> Helps with what?
>>>>
>>>> I don't see any issues with the current patches.
>>>
>>> We're clearly not testing the same configurations, as all your patches
>>> either are not DT enabled or are for the non-multiplatform kernel
>>> builds. I've tried porting your DMA bounce changes to the
>>> multiplatform board-lager-reference.c file but that has not fixed
>>> the issue for me.
>>
>> Yes, my patches are not for the DT support. They have been around for quite
>> a while and my goal is to have them applied first and add DT later.
>>
>> You've probably done something wrong while trying to support multiplatform.
>> It looks like you're either missing the patches mentioned here:
>> http://marc.info/?l=linux-sh&m9060253506760&w=2
>> or you're not binding the PCI devices to the USB phy.
>> Do you have USB R-Car Gen2 phy driver enabled?
>> I don't see ehci/ochi probe being deferred until USB phy is ready.
>> That's why you see this error.
>>
>> Please, discard your own follow the steps from the link above.
>> I think you mentioned lately that you had tried the non-multiplatform
>> version
>> and it had not worked for you. Did you actually try it?
>>
>> Thanks,
>> Val.
>
> I have a local patch that forces the PHY on as soon as it gets
> probed by the device tree because I have not had the time to sort
> out the link between the DT and the PCI.

I don't think your approach will work because the USB phy is probed after the PCI host devices.

>
>> $ grep GEN2 out/test/.config
>> CONFIG_PCI_RCAR_GEN2=y
>> # CONFIG_PCI_RCAR_GEN2_ERRIRQ is not set
>> CONFIG_USB_RCAR_GEN2_PHY=y
>
> I /will/ go and check the driver is actually being probed in
> case there is an issue there.
>

Thanks,
Val.
