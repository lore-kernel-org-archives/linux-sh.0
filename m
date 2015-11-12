From: =?UTF-8?B?7KGw7LC97ZmY?= <charlescho64@gmail.com>
Date: Thu, 12 Nov 2015 07:59:54 +0000
Subject: Re: [R-CAR][Lager Board - Bringup with linux kernel4.3]
Message-Id: <CANi_qo3_YPLBNghrqu0JvQfyRTXJc5bUGhh-No9Dn2djgUoqMQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

 Hello...

 I have problem during bring up R-CAR H2 Lager Board with linux4.3.

 The step I did is below

 1) downloaded linux and uboot from below link.

 In kernel,
  git clone -b devel
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

 In u-boot
 git clone -b renesas/bsp/rcar-gen2-1.8.0  git://git.denx.de/u-boot-sh.git

 2) build
 In kernel,  I used kernel config file as "shmobile_defconfig" and
enable "DEBUG_LL"
 with cross-compiler
"gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf" ( cross_compiler
download site :
https://releases.linaro.org/15.02/components/toolchain/binaries/arm-linux-gnueabihf/gcc-linaro-4.9-2015.02-3-x86_64_arm-linux-gnueabihf.tar.xz)

 Build it  like below command and got zImage and dtb file(r8a7790-lager.dtb)

 $make ARH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j10

 In u-boot, I used config file as "lager_config" and build with
compiler used in kernel build like below. And then got "u-boot.srec"

 $ make ARH=arm lager_config
 $ make ARH=arm CROSS_COMPILE=arm-linux-gnueabihf- all

 3) Setting the environment for booting

 The environment have been loading kernel via TFTP and rootfs via NFS.
And U-boot command are set with below.

 > setenv bootcmd 'tftp 0x40007fc0 zImage; tftp 0x4f000000
r8a7790-lager.dtb; bootz 0x40007fc0 - 0x4f000000'
 > setenv bootargs 'console=ttySC6,38400 ignore_loglevel psci=enable
rw root=/dev/nfs rw nfsroot2.168.0.228:/nfsroot/lager,nfsvers=3
ip2.168.0.91:192.168.0.228:192.168.0.1:255.255.255.0:lager:eth0:::
vmalloc84M'


 4) power on "R-CAR LAGER Board"

 Lager board had hang before booting linux kernel with message "
Starting kernel ... " and "Uncompressing Linux... done, booting the
kernel."

 -----------------------------------------------------------------------------------------------------------------------
 sh_eth Waiting for PHY auto negotiation to complete.. done
 sh_eth: 100Base/Full
 Using sh_eth device
 TFTP from server 192.168.0.228; our IP address is 192.168.0.91
 Filename 'zImage'.
 Load address: 0x40007fc0
 Loading: #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #################################################################
          #
          1.4 MiB/s
 done
 Bytes transferred = 3332784 (32dab0 hex)
 sh_eth:1 is connected to sh_eth.  Reconnecting to sh_eth
 sh_eth Waiting for PHY auto negotiation to complete.. done
 sh_eth: 100Base/Full
 Using sh_eth device
 TFTP from server 192.168.0.228; our IP address is 192.168.0.91
 Filename 'r8a7790-lager.dtb'.
 Load address: 0x4f000000
 Loading: #########
          1.3 MiB/s
 done
 Bytes transferred = 44077 (ac2d hex)
 ## Flattened Device Tree blob at 4f000000
    Booting using the fdt blob at 0x4f000000
    Loading Device Tree to 40ef2000, end 40effc2c ... OK

 Starting kernel ...

 Uncompressing Linux... done, booting the kernel.
 ------------------------------------------------------------------------------------------------

 Anybody help me to bring up "Lager board"

 Thanks.

 BR

 --
 Happy Virus....
 Chang Hwan, Cho
