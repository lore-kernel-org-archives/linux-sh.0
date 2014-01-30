From: Valentine <valentine.barshak@cogentembedded.com>
Date: Thu, 30 Jan 2014 00:08:44 +0000
Subject: Re: [PATCH V3 0/3] ARM: shmobile: lager: Add USB support
Message-Id: <52E9980C.8040205@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/30/2014 03:39 AM, Magnus Damm wrote:
> Hi Valentine,
>
> Thanks a lot for your efforts.
>
> On Wed, Jan 29, 2014 at 3:34 AM, Valentine
> <valentine.barshak@cogentembedded.com> wrote:
>> On 01/27/2014 03:25 PM, Magnus Damm wrote:
>>> On Mon, Jan 27, 2014 at 7:45 PM, Valentine
>>> <valentine.barshak@cogentembedded.com> wrote:
>>>> On 01/27/2014 02:31 PM, Magnus Damm wrote:
>>>>> I don't think DMA pool by itself is enough though, HIGHMEM is probably
>>>>> used for cached disk contents so to also cover the USB storage case I
>>>>> believe we need to use bounce buffers. I recall something similar was
>>>>> needed for SM501 with local memory, I may be wrong about this case
>>>>> though. As-is is probably not enough though.
>>>>
>>>> I have played with this a bit. I haven't seen any issues with HIGHMEM.
>>>> As long as the kernel uses 1G/3G memory split (kernel/user-space) I have
>>>> not
>>>> seen any issues.
>>>
>>> Ok, thanks, I see. Can you please share your test cases with us?
>>
>>
>> I've been doing disk reads/writes with dd using direct flags and various
>> buffer sizes in parallel with memtest.
>
> The "direct flag" thing here sticks out a bit. Have you tried using a
> file system?

Yes, I actually switched to direct after I had tested without it,
I did some extensive copying back and forth from one USB storage to another
and stuff like that with some memory consuming processes in the background.

>
>>> My half-educated guess is that devices that do not use HIGHMEM will
>>> most likely function. Whatever serial ports and keyboards will be
>>> fine. USB storage will most likely fail if you stress test, and it is
>>> a pretty important feature IMO so I'd like to make sure that it is
>>> working as expected.
>>>
>>> If you have not tested USB storage yet, would it be possible for you
>>> to perform some basic testing?
>>
>>
>> Yes, I've been doing it with USB storage. HIGHMEM is not a problem
>> since USB storage driver copies everything to lowmem. Besides DMA
>> bouncing of HIGHMEM is not supported.
>
> I see. Can you point out where this code is located to I can have a look?

grep -r  "HIGHMEM" arch/arm/common/dmabounce.c
# dev_err(dev, "DMA buffer bouncing of HIGHMEM pages is not supported\n");

>
>>>> I have not tested the PAE yet. I planned to play more with it and send
>>>> incremental patches
>>>> for that later.
>>>
>>>
>>> The thing is that LPAE is needed to support all physical memory on the
>>> Lager board. So it's not really optional in my opinion.
>>>
>>> To be fair, actual board support for 4GiB of memory was added rather
>>> recently due to upstream ARM architecture code wasn't working as
>>> expected in some cases. I expect that the defconfig for Lager will
>>> enable LPAE. For multiplatform distro kernels this is something that
>>> the distribution will select. Regardless of setting we want the USB
>>> code to work as expected.
>>>
>>>> Using bounce buffers with different memory model works fine for DMA
>>>> transfers but it involves
>>>> changes to the board-specific code which should limit DMA zone to just
>>>> 1GB
>>>> for all DMA
>>>> allocations.
>>>
>>>
>>> Uhm, I don't think this has anything to do with the DMA zone. You can
>>> write code that specifically allocates from DMA or DMA32 zones, but in
>>> case of general purpose OS disk caching we cannot select that. And if
>>> we could then all HIGHMEM would be pretty darn useless since we
>>> couldn't use it for disk caching. So HIGHMEM will be around -
>>> especially on 32-bit ARM and especially especially on systems that use
>>> LPAE. =)
>>>
>>>> Unfortunately ARM PCI doesn't seem to have specific DMA memory limitation
>>>> support as PowerPC does.
>>>> So I used platform notifiers to fix up DMA mask for PCI devices.
>>>
>>>
>>> Is this enough really? I think you can use the ixp4xx implementation
>>> as a reference to see how to make use of bounce buffer support on ARM.
>>
>>
>> This is exactly what ixp4xx is doing. I'll send RFC patches for you to test.
>> I also needed adjust the size of the default ARM coherent DMA pool since
>> 256K
>> was not enough for bouncing USB DMA buffers.
>
> Thanks for your work on that!
>
>> As I have said before I have not been able to see any problems so far with
>> HIGHMEM.
>> Enabling LPAE doesn't seem to hard either. Besides we may want to revisit
>> other
>> drivers that set 32-bit DMA mask for LPAE support as well.
>>
>> The problems were observed with memory split other than 3G/1G user/kernel,
>> when
>> more than 1G was available in lowmem for DMA.
>
> I'm not so concerned about the user/kernel split, but I understand
> that it may affect things. My main concern is that HIGHMEM should be
> handled correctly at this point.

Haven't seen any problems with HIGHMEM (and no dmabounce) so far.
AFAIU, the USB storage protocol copies all data from HIGHMEM to the internal
buffer before the transfer:
drivers/usb/storage/protocol.c:unsigned int usb_stor_access_xfer_buf(unsigned char *buffer,

>
> Thanks,
>
> / magnus
>

Thanks,
Val.

