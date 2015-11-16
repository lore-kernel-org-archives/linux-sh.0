From: =?UTF-8?B?7KGw7LC97ZmY?= <charlescho64@gmail.com>
Date: Mon, 16 Nov 2015 06:58:55 +0000
Subject: Re: [R-CAR][Lager Board - Bringup with linux kernel4.3]
Message-Id: <CANi_qo1S7OHbRsCCpAn6ceoK+4e6Sn25nUBHG7mnHeb=3Kqqmg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CANi_qo3_YPLBNghrqu0JvQfyRTXJc5bUGhh-No9Dn2djgUoqMQ@mail.gmail.com>
In-Reply-To: <CANi_qo3_YPLBNghrqu0JvQfyRTXJc5bUGhh-No9Dn2djgUoqMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hello,

Thank you so much. I fixed with your advice.
I set console port as ttySC6 following with renesas's document about booting.
Anyway I got success booting and rootfs with NFS.



2015-11-12 19:35 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Thu, Nov 12, 2015 at 8:59 AM, 조창환 <charlescho64@gmail.com> wrote:
>>  I have problem during bring up R-CAR H2 Lager Board with linux4.3.
>>
>>  The step I did is below
>>
>>  1) downloaded linux and uboot from below link.
>>
>>  In kernel,
>>   git clone -b devel
>> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
>>
>>  In u-boot
>>  git clone -b renesas/bsp/rcar-gen2-1.8.0  git://git.denx.de/u-boot-sh.git
>>
>>  2) build
>>  In kernel,  I used kernel config file as "shmobile_defconfig" and
>> enable "DEBUG_LL"
>>  with cross-compiler
>> "gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf" ( cross_compiler
>> download site :
>> https://releases.linaro.org/15.02/components/toolchain/binaries/arm-linux-gnueabihf/gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz)
>>
>>  Build it  like below command and got zImage and dtb file(r8a7790-lager.dtb)
>>
>>  $make ARH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j10
>>
>>  In u-boot, I used config file as "lager_config" and build with
>> compiler used in kernel build like below. And then got "u-boot.srec"
>>
>>  $ make ARH=arm lager_config
>>  $ make ARH=arm CROSS_COMPILE=arm-linux-gnueabihf- all
>>
>>  3) Setting the environment for booting
>>
>>  The environment have been loading kernel via TFTP and rootfs via NFS.
>> And U-boot command are set with below.
>>
>>  > setenv bootcmd 'tftp 0x40007fc0 zImage; tftp 0x4f000000
>> r8a7790-lager.dtb; bootz 0x40007fc0 - 0x4f000000'
>>  > setenv bootargs 'console=ttySC6,38400 ignore_loglevel psci=enable
>> rw root=/dev/nfs rw nfsroot2.168.0.228:/nfsroot/lager,nfsvers=3
>> ip2.168.0.91:192.168.0.228:192.168.0.1:255.255.255.0:lager:eth0:::
>> vmalloc84M'
>
> The console device should be ttySC0, not ttySC6.
> Furthermore, is 38400 correct for your configuration? I'd expect 115200.
>
> Note that with Simon's current tree, there should be no need to specify
> a "console" parameter, unless you really want ttySC6 or 38400 baud.
>
> What does "psci=enable" do?
>
> Does the kernel boot with the default kernel command line?
>
>>  4) power on "R-CAR LAGER Board"
>>
>>  Lager board had hang before booting linux kernel with message "
>> Starting kernel ... " and "Uncompressing Linux... done, booting the
>> kernel."
>
> You said you are using "CONFIG_DEBUG_LL=y". Are the other config
> settings for early debugging correct?
>
> CONFIG_DEBUG_RCAR_GEN2_SCIF0=y
> CONFIG_DEBUG_LL_INCLUDE="debug/renesas-scif.S"
> CONFIG_DEBUG_UART_PHYS=0xe6e60000
>
> BTW, arch/arm/Kconfig.debug still assumes SCIF0 for debugging on r8a7790,
> while the console uses SCIFA0 these days. However, changing that makes sense
> only if U-Boot is also changed to uses SCIFA0, else pinctrl is not set up
> correctly. Perhaps U-Boot has been changed, and that's why it doesn't work?
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Happy Virus....
Chang Hwan, Cho
