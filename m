From: Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>
Date: Wed, 10 Sep 2014 01:21:39 +0000
Subject: Re: [PATCH 0/5] arm: shmobile: Lager Add USB and SATA support
Message-Id: <540FA7A3.3080607@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Hiep-san,

Can you check as CONFIG_CPU_FREQ is not set?

When you perform a benchmark, you should check a /sys/devices/system/cpu/cp=
u0/cpufreq/scaling_governor
setup of your userland.

Thank you,
Sakato.

(2014/09/09 19:48), =E3=82=AB=E3=82=AA=E3=80=80=E3=83=9F=E3=83=B3=E3=80=80=
=E3=83=92=E3=82=A7=E3=83=83=E3=83=97 wrote:
> Hello,
>=20
> We are testing Serial-ATA driver on linux uptream-v3.17-rc2 on Lager(R8a7=
790 SoC),
> On this version Serial-ATA's Writing speed on HDD is about 42.61MB/s.
> This writing speed|| seems good, but on Upstream-v3.16-rc5 the writing sp=
eed was up to 66MB/s,
> Please see it when you have time.
>=20
> Best Regards,
> Jinso/Cao Minh Hiep.
>=20
>=20
>=20
>=20
>=20
>=20
> On 12/18/2013 09:44 PM, Valentine Barshak wrote:
>> I've decided to bundle USB and SATA patches together, since I've done SA=
TA on top of USB.
>> Most of the SATA/USBHS/PCI USB host support patches for Lager are availa=
ble in the respective
>> susbsystem git trees (for 3.14) but are still missing from the Renesas t=
ree.
>>
>> So, in order to test these, the following patches from other subsystem t=
rees are needed:
>> USB:
>> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=
=3Dpci/host-rcar&id=FB178d8b2fab3f2a9f203c13ffe80cfd6e01bdf1
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?=
id=C8ba8115a21226fba3211085f570b128fa271e31
>> https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dn=
ext&id=C3e5d2985ef720cbbdc63546a5c545ac4450d96e
>> https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3D=
usb-next&id=103e127d1f8f985e8a662da6537ebc5e08902ee3
>> https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3D=
usb-next&id=1Ae5799ef63176cc75ec10e545cb65f620a82747
>>
>> SATA:
>> https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Df=
or-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
>>
>> The USB channel 0 (CN6) is configured as PCI USB host if USB_RENESAS_USB=
HS_UDC is disabled.
>> Otherwise it is configured as USBHS device.
>> Please note that the following switches have to be set correctly as well:
>> PCI USB Host: SW5 - pin1;    SW6 - pin1
>> USBHS device: SW5 - neutral; SW6 - pin3
>>
>> Valentine Barshak (5):
>>    arm: shmobile: r8a7790: Add PCI USB host clock support
>>    arm: shmobile: r8a7790: Add SATA clock
>>    arm: shmobile: lager: Add USBHS support
>>    arm: shmobile: lager: Add internal PCI support
>>    arm: shmobile: lager: Add SATA support
>>
>>   arch/arm/mach-shmobile/board-lager.c   | 203 +++++++++++++++++++++++++=
++++++++
>>   arch/arm/mach-shmobile/clock-r8a7790.c |  25 +++-
>>   2 files changed, 227 insertions(+), 1 deletion(-)
>>
>=20
>=20
