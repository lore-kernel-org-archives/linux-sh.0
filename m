From: Valentine <valentine.barshak@cogentembedded.com>
Date: Tue, 28 Jan 2014 18:34:58 +0000
Subject: Re: [PATCH V3 0/3] ARM: shmobile: lager: Add USB support
Message-Id: <52E7F852.9060706@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 01/27/2014 03:25 PM, Magnus Damm wrote:
> Hi Valentine,
>
> On Mon, Jan 27, 2014 at 7:45 PM, Valentine
> <valentine.barshak@cogentembedded.com> wrote:
>> On 01/27/2014 02:31 PM, Magnus Damm wrote:
>>>
>>> Hi Ben,
>>>
>>> On Mon, Jan 27, 2014 at 7:24 PM, Ben Dooks <ben.dooks@codethink.co.uk>
>>> wrote:
>>>>
>>>> On 27/01/14 10:19, Magnus Damm wrote:
>>>>>
>>>>>
>>>>> Hi Valentine,
>>>>>
>>>>> On Mon, Jan 27, 2014 at 7:02 PM, Valentine
>>>>> <valentine.barshak@cogentembedded.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 01/27/2014 01:59 PM, Ben Dooks wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 24/01/14 22:28, Valentine Barshak wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> The first patch adds USBHS device and the rest add PCI USB host
>>>>>>>> support
>>>>>>>> to Lager board.
>>>>>>>> The patches depend on the following commits:
>>>>>>>> USBHS and PCI USB host:
>>>>>>>> *
>>>>>>>>
>>>>>>>>
>>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/com=
mit/?id=C8ba8115a21226fba3211085f570b128fa271e31
>>>>>>>> *
>>>>>>>>
>>>>>>>>
>>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?=
id=C3e5d2985ef720cbbdc63546a5c545ac4450d96e
>>>>>>>> PCI USB host:
>>>>>>>> *
>>>>>>>>
>>>>>>>>
>>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/=
?h=3Dusb-next&id=103e127d1f8f985e8a662da6537ebc5e08902ee3
>>>>>>>> *
>>>>>>>>
>>>>>>>>
>>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/=
?h=3Dusb-next&id=1Ae5799ef63176cc75ec10e545cb65f620a82747
>>>>>>>> *
>>>>>>>>
>>>>>>>>
>>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit=
/?h=3Dpci/host-rcar&id=FB178d8b2fab3f2a9f203c13ffe80cfd6e01bdf1
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hi, when doing this have you come across a problem where the OHCI
>>>>>>> controller on USB0 fails to start with an initialisation error? I
>>>>>>> think it is something to do with the bridge setup but have yet to
>>>>>>> have enough time to look into this issue.
>>>>>>>
>>>>>>
>>>>>> All PCI ports have worked fine for me.
>>>>>> Please, check that the SW5/SW6 pins are set correctly on your board.
>>>>>
>>>>>
>>>>>
>>>>> Thanks for your recommendation. From my side I must say that I
>>>>> recommend against using USB0 for USB host unless you're sure about
>>>>> your hardware settings. This to prevent driving VBUS incorrectly from
>>>>> two hosts with the wrong cable. Normally micro type of connector is
>>>>> used for USB Function, and on Lager the cable detection functionality
>>>>> is missing. So due to missing cable detection implementation it is
>>>>> probably much safer to just use USB0 for Function.
>>>>>
>>>>> If I may jump to a slightly different topic, but still USB PCI, then
>>>>> let me ask if USB PCI been tested with LPAE enabled? I am asking
>>>>> because Lager has 4 GiB or RAM over 40 bits of physical address space,
>>>>> but the PCI host controller probably only allows for up to 1 GiB
>>>>> physical address space.
>>>>>
>>>>> I suspect that this physical address space mismatch means that bounce
>>>>> buffers will be needed for correct operation, but those seem to be
>>>>> lacking from the upstream driver unless I'm mistaken. I believe USB
>>>>> storage will be busted on Lager with LPAE enabled unless bounce
>>>>> buffers are implemented. For a reference implementation, please grep
>>>>> for "ixp4xx_needs_bounce".
>>>>
>>>>
>>>>
>>>> The host bridge cannot cope with all the memory in the normal
>>>> address space, let alone the extended 40bit addressing. There
>>>> needs to be something done about (a) iommu support and (b) if
>>>> there is no iommu available limiting the DMA pool available for
>>>> the OHCI and EHCI drivers.
>>>
>>>
>>> Thanks I'm hinting at that yes. =3D)
>>>
>>> I don't think DMA pool by itself is enough though, HIGHMEM is probably
>>> used for cached disk contents so to also cover the USB storage case I
>>> believe we need to use bounce buffers. I recall something similar was
>>> needed for SM501 with local memory, I may be wrong about this case
>>> though. As-is is probably not enough though.
>>
>>
>> I have played with this a bit. I haven't seen any issues with HIGHMEM.
>> As long as the kernel uses 1G/3G memory split (kernel/user-space) I have=
 not
>> seen any issues.
>
> Ok, thanks, I see. Can you please share your test cases with us?

I've been doing disk reads/writes with dd using direct flags and various
buffer sizes in parallel with memtest.

>
> My half-educated guess is that devices that do not use HIGHMEM will
> most likely function. Whatever serial ports and keyboards will be
> fine. USB storage will most likely fail if you stress test, and it is
> a pretty important feature IMO so I'd like to make sure that it is
> working as expected.
>
> If you have not tested USB storage yet, would it be possible for you
> to perform some basic testing?

Yes, I've been doing it with USB storage. HIGHMEM is not a problem
since USB storage driver copies everything to lowmem. Besides DMA
bouncing of HIGHMEM is not supported.

>
>> I have not tested the PAE yet. I planned to play more with it and send
>> incremental patches
>> for that later.
>
> The thing is that LPAE is needed to support all physical memory on the
> Lager board. So it's not really optional in my opinion.
>
> To be fair, actual board support for 4GiB of memory was added rather
> recently due to upstream ARM architecture code wasn't working as
> expected in some cases. I expect that the defconfig for Lager will
> enable LPAE. For multiplatform distro kernels this is something that
> the distribution will select. Regardless of setting we want the USB
> code to work as expected.
>
>> Using bounce buffers with different memory model works fine for DMA
>> transfers but it involves
>> changes to the board-specific code which should limit DMA zone to just 1=
GB
>> for all DMA
>> allocations.
>
> Uhm, I don't think this has anything to do with the DMA zone. You can
> write code that specifically allocates from DMA or DMA32 zones, but in
> case of general purpose OS disk caching we cannot select that. And if
> we could then all HIGHMEM would be pretty darn useless since we
> couldn't use it for disk caching. So HIGHMEM will be around -
> especially on 32-bit ARM and especially especially on systems that use
> LPAE. =3D)
>
>> Unfortunately ARM PCI doesn't seem to have specific DMA memory limitation
>> support as PowerPC does.
>> So I used platform notifiers to fix up DMA mask for PCI devices.
>
> Is this enough really? I think you can use the ixp4xx implementation
> as a reference to see how to make use of bounce buffer support on ARM.

This is exactly what ixp4xx is doing. I'll send RFC patches for you to test.
I also needed adjust the size of the default ARM coherent DMA pool since 25=
6K
was not enough for bouncing USB DMA buffers.

As I have said before I have not been able to see any problems so far with =
HIGHMEM.
Enabling LPAE doesn't seem to hard either. Besides we may want to revisit o=
ther
drivers that set 32-bit DMA mask for LPAE support as well.

The problems were observed with memory split other than 3G/1G user/kernel, =
when
more than 1G was available in lowmem for DMA.
>
> Thanks,
>
> / magnus
>

Thanks.
Val.
