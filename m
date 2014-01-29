From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 29 Jan 2014 09:21:49 +0000
Subject: Re: [PATCH 1/3] arm: shmobile: lager: Add USBHS support
Message-Id: <52E8C82D.40908@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387548804-20829-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387548804-20829-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/29/2014 10:11 AM, Simon Horman wrote:
> On Mon, Jan 27, 2014 at 07:26:53PM +0900, Magnus Damm wrote:
>> Hi Valentine,
>>
>> On Sat, Jan 25, 2014 at 8:05 AM, Valentine
>> <valentine.barshak@cogentembedded.com> wrote:
>>> On 01/24/2014 08:40 AM, Magnus Damm wrote:
>>>>
>>>> Hi Valentine,
>>>>
>>>
>>> Hi Magnus,
>>>
>>>
>>>> On Sat, Jan 18, 2014 at 3:31 AM, Valentine
>>>> <valentine.barshak@cogentembedded.com> wrote:
>>>>>
>>>>> On 01/15/2014 04:39 PM, Magnus Damm wrote:
>>>>>>
>>>>>>
>>>>>> On Fri, Dec 20, 2013 at 11:13 PM, Valentine Barshak
>>>>>> <valentine.barshak@cogentembedded.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> This adds USBHS PHY and registers USBHS device if the driver is
>>>>>>> enabled.
>>>>>>>
>>>>>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>>>>>> ---
>>>>>>>     arch/arm/mach-shmobile/board-lager.c | 117
>>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 117 insertions(+)
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi Valentine,
>>>>>
>>>>>
>>>>>
>>>>> Magnus, Simon,
>>>>>
>>>>>
>>>>>>
>>>>>> Thanks for this USB function patch. I'd like to switch focus to USB
>>>>>> function soon.
>>>>>>
>>>>>> By the way, I'm happy to see that SATA platform device support is
>>>>>> picked up by Simon. I intend to give your SATA DTS patches a go later
>>>>>> this week, they should be ready to queue up rather soon I believe.
>>>>>>
>>>>>> Would it be possible for you to update your USB function platform
>>>>>> device patches for Lager and Koelsch? I'd like to merge those after
>>>>>> SATA, and the platform device files shouldn't change now so USB can go
>>>>>> next now unless I'm mistaken. Please send a complete per-board series
>>>>>> for USB function so patch pick up and testing gets easy - same style
>>>>>> as SATA would be great.
>>>>>
>>>>>
>>>>>
>>>>> Just respinned the USB series for Lager and Koelsch.
>>>>> I did not include defconfig changes yet.
>>>>
>>>>
>>>> Thanks!
>>>>
>>>>> I think we need to enable kernel modules in the defconfig first,
>>>>> so that multiple USB gadgets can be selected as modules.
>>>>
>>>>
>>>> I agree that for testing something is needed., but perhaps a simple
>>>> composite device is enough?
>>>>
>>>> In general I think the USB gadget kernel configuration is something
>>>> that it is left for the distributions to select since it depends on
>>>> each use case. Also, using modules is fine but I also think there is
>>>> some configfs interface that can be used to configure the USB gadget
>>>> during run time.
>>>
>>>
>>> I've sent a couple of patches that enable modules for lager and koelsch.
>>> I think this is useful even if we decide to go with composite gadget.
>>
>> Ok, thanks, I will duck and let Simon decide about this!
>
> I think it would be better to wait until we need modules
> before turning them on.
>

Well, you may never need them and have everything built-in.

Thought you might want modules for USB gadgets.
What configuration do you propose for the USBHS gadget?
Do you want me to add composite gadget built-in?

Thanks,
Val.
