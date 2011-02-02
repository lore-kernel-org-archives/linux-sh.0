From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Wed, 02 Feb 2011 23:46:10 +0000
Subject: Re: build error in ehci-hcd when disable PCI bus
Message-Id: <AANLkTikhJDu3fXa-N4s+HCf_c+gqB8tNfXe6ymkxwj8j@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D48D301.9080705@renesas.com>
In-Reply-To: <4D48D301.9080705@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Sorry, I got advice from you in other threads.

2011/2/3 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>:
> 2011/2/3 Paul Mundt <lethal@linux-sh.org>:
>> On Wed, Feb 02, 2011 at 12:44:01PM +0900, Yoshihiro Shimoda wrote:
>>> I found the build error when I am debugging other board.
>>> Also I can duplicate this issue on sdk7786 when the PCI bus is disabled.
>>> I tested linux-2.6.38-rc3.
>>> Do you think what souce code should I fix?
>>>
>>> ******* build Log *******
>>> In file included from drivers/usb/host/ehci-hcd.c:340:
>>> drivers/usb/host/ehci-sched.c: In function ?ehci_quirk_amd_L1?:
>>> drivers/usb/host/ehci-sched.c:1606: error: implicit declaration of func=
tion ?outb_p?
>>> drivers/usb/host/ehci-sched.c:1607: error: implicit declaration of func=
tion ?inb_p?
>>> drivers/usb/host/ehci-sched.c:1611: error: implicit declaration of func=
tion ?outl_p?
>>> drivers/usb/host/ehci-sched.c:1614: error: implicit declaration of func=
tion ?inl_p?
>>> make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
>>> **************************
>>>
>> When the PCI bus is disabled we don't really have any concept of PIO, so
>> PIO support and the associated accessors are explicitly disabled.
>>
>> The quirk this refers to looks like it may depend on PCI, and if not, it
>> certainly has a platform dependency that can be used to encapsulate it.
>>
>> The proper fix here is to fix ehci-sched.c, not re-introduce broken PIO
>> crap that wraps in to MMIO.
>
> Are these same to other devices?
> Some device driver depends on PIO.
>
> --
> Nobuhiro Iwamatsu
>



--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
