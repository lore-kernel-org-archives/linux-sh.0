From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 29 Jan 2014 12:47:56 +0000
Subject: Re: [PATCH RFC 0/2] ARM: shmobile: lager: Enable DMA bounce for PCI
Message-Id: <52E8F87C.1070101@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/29/2014 04:45 PM, Ben Dooks wrote:
> On 29/01/14 11:15, Valentine wrote:
>> On 01/29/2014 12:03 PM, Ben Dooks wrote:
>>> On 29/01/14 06:45, Simon Horman wrote:
>>>> On Tue, Jan 28, 2014 at 10:53:31PM +0400, Valentine Barshak wrote:
>>>>> This enables DMA bounce for PCI since the controller does
>>>>> not support more than 2G PCI-AHB memory window.
>>>>> The problems with DMA transfers can be observed when
>>>>> setting 2G/2G user/kernel memory split model
>>>>> (CONFIG_VMSPLIT_2G=y)
>>>>> These patches help to avoid it.
>>>>
>>>> Are these patches compatible with other user/kernel splits?
>>>
>>> PS, the bridge is only actually capable of seeing 1GiB of
>>> RAM due to alignment issues in the window. You can have either
>>> 0x4..0x8 or 0x8..0xc but not /both/. If you open the window to
>>> 2GiB then you can see either 0x0..0x8 or 0x8..0xF range.
>>>
>>
>> I don't think this is relater to the user/kernel space memory split.
>>
>> Currently the R-Car Gen2 PCI driver uses 0x40000000 - 0x7fffffff
>> PCI-AHB region. We can set it to 0x00000000 - 0x7fffffff,
>> but there's no RAM below 0x40000000 so no DMA access to that area is
>> actually legal from the PCI USB host driver.
>> So the change wouldn't give us much.
>
> Well, there's IO areas but probably not wanting to DMA to them anyway.
>
>> The 31-bit DMA mask takes care of forbidding any DMA transfers
>> to the area above 0x7fffffff.
>
> I will add this to our current patch series and see if it helps.

Helps with what?

I don't see any issues with the current patches.

Thanks,
Val.
