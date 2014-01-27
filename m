From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 27 Jan 2014 10:51:21 +0000
Subject: Re: [PATCH V3 0/3] ARM: shmobile: lager: Add USB support
Message-Id: <52E63A29.6030808@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 27/01/14 10:45, Valentine wrote:
> On 01/27/2014 02:31 PM, Magnus Damm wrote:
>> Hi Ben,
>>
>> On Mon, Jan 27, 2014 at 7:24 PM, Ben Dooks <ben.dooks@codethink.co.uk>
>> wrote:
>>> On 27/01/14 10:19, Magnus Damm wrote:
>>>>
>>>> Hi Valentine,
>>>>
>>>> On Mon, Jan 27, 2014 at 7:02 PM, Valentine
>>>> <valentine.barshak@cogentembedded.com> wrote:
>>>>>
>>>>> On 01/27/2014 01:59 PM, Ben Dooks wrote:
>>>>>>
>>>>>>
>>>>>> On 24/01/14 22:28, Valentine Barshak wrote:
>>>>>>>
>>>>>>>
>>>>>>> The first patch adds USBHS device and the rest add PCI USB host
>>>>>>> support
>>>>>>> to Lager board.
>>>>>>> The patches depend on the following commits:
>>>>>>> USBHS and PCI USB host:
>>>>>>> *
>>>>>>>
>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/comm=
it/?id=C8ba8115a21226fba3211085f570b128fa271e31
>>>>>>>
>>>>>>> *
>>>>>>>
>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?i=
d=C3e5d2985ef720cbbdc63546a5c545ac4450d96e
>>>>>>>
>>>>>>> PCI USB host:
>>>>>>> *
>>>>>>>
>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?=
h=3Dusb-next&id=103e127d1f8f985e8a662da6537ebc5e08902ee3
>>>>>>>
>>>>>>> *
>>>>>>>
>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?=
h=3Dusb-next&id=1Ae5799ef63176cc75ec10e545cb65f620a82747
>>>>>>>
>>>>>>> *
>>>>>>>
>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/=
?h=3Dpci/host-rcar&id=FB178d8b2fab3f2a9f203c13ffe80cfd6e01bdf1
>>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi, when doing this have you come across a problem where the OHCI
>>>>>> controller on USB0 fails to start with an initialisation error? I
>>>>>> think it is something to do with the bridge setup but have yet to
>>>>>> have enough time to look into this issue.
>>>>>>
>>>>>
>>>>> All PCI ports have worked fine for me.
>>>>> Please, check that the SW5/SW6 pins are set correctly on your board.
>>>>
>>>>
>>>> Thanks for your recommendation. From my side I must say that I
>>>> recommend against using USB0 for USB host unless you're sure about
>>>> your hardware settings. This to prevent driving VBUS incorrectly from
>>>> two hosts with the wrong cable. Normally micro type of connector is
>>>> used for USB Function, and on Lager the cable detection functionality
>>>> is missing. So due to missing cable detection implementation it is
>>>> probably much safer to just use USB0 for Function.
>>>>
>>>> If I may jump to a slightly different topic, but still USB PCI, then
>>>> let me ask if USB PCI been tested with LPAE enabled? I am asking
>>>> because Lager has 4 GiB or RAM over 40 bits of physical address space,
>>>> but the PCI host controller probably only allows for up to 1 GiB
>>>> physical address space.
>>>>
>>>> I suspect that this physical address space mismatch means that bounce
>>>> buffers will be needed for correct operation, but those seem to be
>>>> lacking from the upstream driver unless I'm mistaken. I believe USB
>>>> storage will be busted on Lager with LPAE enabled unless bounce
>>>> buffers are implemented. For a reference implementation, please grep
>>>> for "ixp4xx_needs_bounce".
>>>
>>>
>>> The host bridge cannot cope with all the memory in the normal
>>> address space, let alone the extended 40bit addressing. There
>>> needs to be something done about (a) iommu support and (b) if
>>> there is no iommu available limiting the DMA pool available for
>>> the OHCI and EHCI drivers.
>>
>> Thanks I'm hinting at that yes. =3D)
>>
>> I don't think DMA pool by itself is enough though, HIGHMEM is probably
>> used for cached disk contents so to also cover the USB storage case I
>> believe we need to use bounce buffers. I recall something similar was
>> needed for SM501 with local memory, I may be wrong about this case
>> though. As-is is probably not enough though.
>
> I have played with this a bit. I haven't seen any issues with HIGHMEM.
> As long as the kernel uses 1G/3G memory split (kernel/user-space) I have
> not seen any issues.

The issue is the AHB<>PCI bridge can only support a 1GiB mapping on the
Lager board. If you select the 2GiB window then you're force to align
the memory window to either the lower or top half of the 32bit space
and the legacy memory mapping straddles this.

> I have not tested the PAE yet. I planned to play more with it and send
> incremental patches
> for that later.
>
> Using bounce buffers with different memory model works fine for DMA
> transfers but it involves
> changes to the board-specific code which should limit DMA zone to just
> 1GB for all DMA
> allocations.
>
> Unfortunately ARM PCI doesn't seem to have specific DMA memory
> limitation support as PowerPC does.
> So I used platform notifiers to fix up DMA mask for PCI devices.

Interesting.


--=20
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
