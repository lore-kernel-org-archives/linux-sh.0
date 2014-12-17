From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Dec 2014 14:28:02 +0000
Subject: Re: [PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load address
Message-Id: <CANqRtoSdRD3jiJ7uL1wdxyaEAzU4EAYfaDEq_REkusE+CtMS0A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094214.7039.68681.sendpatchset@w520>
In-Reply-To: <20141217094214.7039.68681.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Dec 17, 2014 at 10:35 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Dec 17, 2014 at 2:08 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> Do you boot a zImage or a uImage?
>>
>> uImage built from zImage with appended DTB.
>>
>> These 4 steps actually:
>> rm arch/arm/boot/zImage
>> make -j 9 ARCH=arm CROSS_COMPILE=_ dtbs zImage
>> cat arch/arm/boot/dts/sh73a0-kzm9g.dtb >> arch/arm/boot/zImage
>> make -j 9 ARCH=arm CROSS_COMPILE=_ LOADADDR=0x48008000 uImage
>
> Thanks, that works!
> But the machine lost 128 MiB of RAM, compared to adjusting the "reg" property
> of the memory node :-(

Huh, I wasn't aware that we also loose memory!?

I suppose we need to update the code to allow registering memory below
the kernel load address.

>>> I usually use a zImage with appended DTB on kzm9g. It fails as before:
>
>>> Uncompressing Linux... done, booting the kernel.
>>> Booting Linux on physical CPU 0x0
>>> Linux version 3.18.0-kzm9g-multiplatform-11069-g3086a70162bdec42
>>> (geert@ramsan) (gcc version 4.9.0 (GCC) ) #274 SMP Wed Dec 17 13:28:08
>>> CET 2014
>>> CPU: ARMv7 Processor [412fc098] revision 8 (ARMv7), crc5387d
>>> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>>> Machine model: KZM-A9-GT
>>> bootconsole [earlycon0] enabled
>>> debug: ignoring loglevel setting.
>>> Memory policy: Data cache writealloc
>>> On node 0 totalpages: 124928
>>> free_area_init_node: node 0, pgdat c058f640, node_mem_map df428000
>>>   Normal zone: 976 pages used for memmap
>>>   Normal zone: 0 pages reserved
>>>   Normal zone: 124928 pages, LIFO batch:31
>>
>> Wow, earlycon. Luxury. =)
>
> Noh, a necessity when developing ;-)

Yeah, I need to look into how to make use of your new bits!

>> The string above says "kzm9g-multiplatform". Did you try legacy or DT
>> reference without CCF?
>
> Yes, they both work (with zImage and appended DTB), as before.

Good!

>>> When trying with a uImage with the "new" load address i.e.
>>>
>>> make ARCH=arm LOADADDR=0x48008000 uImage
>>>
>>> it still fails:
>
>>> ## Flattened Device Tree blob at 50000000
>>>    Booting using the fdt blob at 0x50000000
>>>    Loading Kernel Image ... OK
>>> OK
>>>    Loading Device Tree to 417f8000, end 417ff7be ... OK
>
> Aarghl, u-Boot copied the DT below 0x48000000. That's why it fails:
>
>>> Unable to handle kernel paging request at virtual address b97f8000
>
> Hence no choice but to use uImage+DTB.

The kernel seems to want to get pointers to data it can access directly. =)

>> You seem to be using "bootm 0x43000000 - 0x50000000".
>> In my case I simply use "bootp; bootm". I also tend to use appended
>
> My DHCP server (OpenWRT dnsmasq) doesn't provide TFTP/NFS
> information to its clients.

OpenWRT and dnsmasq is nice, but for development purpose I tend to use
the DHCP server from ISC.

>> DTB and compile-in the command line to rely on the boot loader as
>> little as ever possible.
>
> Indeed.
>
>> One thing that bit me for quite some time was when handling the case
>> CONFIG_AUTO_ZRELADDR=n. I built the zImage using my steps above but I
>> did not pass the LOADADDR when building the zImage - so the
>> "zreladdr-y" value in Makefile.boot was still the default value which
>> ended up in the kernel image. What I mistakenly ended up doing was to
>> only adjust the uImage load address. And your bootm line above has
>> even more magic to it - so you may have 3 different versions... =)
>
> I usually use zImage, which is better for multiplatform.
> In theory the same multiplatform zImage should boot on all machines.

Right, my default case is zImage as well. On broken boot loaders I
tend to stick with whatever (almost) works. =)

Cheers,

/ magnus
