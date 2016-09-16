From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 16 Sep 2016 19:12:18 +0000
Subject: Runtime failure running sh:qemu in -next due to 'sh: fix copy_from_user()'
Message-Id: <20160916191218.GA12104@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>

Hi,

I see the following runtime failure when running a 'sh' image with qemu in -next.

[ ... ]

sd 0:0:0:0: [sda] Attached SCSI disk
EXT2-fs (sda): warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem) on device 8:0.
Freeing unused kernel memory: 124K (8c48a000 - 8c4a9000)
This architecture does not have kernel memory protection.
random: fast init done
Starting logging: OK
usb 1-1: new full-speed USB device number 2 using sm501-usb
Initializing random number generator... done.
Starting network...
ip: OVERRUN: Invalid argument
ip: OVERRUN: Bad address
ip: OVERRUN: Bad address
ip: OVERRUN: Bad address
ip: OVERRUN: Bad address
[repeats until the test aborts]

Bisect points to commit 6e050503a150 ("sh: fix copy_from_user()"). Bisect log is
attached.

Guenter

# bad: [c96ee5192be2bd160b209e063647c0a504247805] Add linux-next specific files for 20160915
# good: [9395452b4aab7bc2475ef8935b4a4fb99d778d70] Linux 4.8-rc6
git bisect start 'HEAD' 'v4.8-rc6'
# bad: [b9382cef0c0edb556ce9914fef0c3ccc3288fe93] Merge remote-tracking branch 'crypto/master'
git bisect bad b9382cef0c0edb556ce9914fef0c3ccc3288fe93
# bad: [c2c9f3960657219312f95baa1f140f3e0f257ebf] Merge branch 'dmi/master'
git bisect bad c2c9f3960657219312f95baa1f140f3e0f257ebf
# bad: [d3b5a0406cf8b7f5c655639c1eadbbc65ba3a56c] Merge remote-tracking branch 'arm-soc/for-next'
git bisect bad d3b5a0406cf8b7f5c655639c1eadbbc65ba3a56c
# good: [cd42d7672665ef51ae895631ec79ba9b4801cc85] Merge branch 'next/dt64' into for-next
git bisect good cd42d7672665ef51ae895631ec79ba9b4801cc85
# bad: [84b017489a6a09ffc394efe637346b598cef68a5] Merge remote-tracking branch 'input-current/for-linus'
git bisect bad 84b017489a6a09ffc394efe637346b598cef68a5
# good: [440f895aa97f81a2bdc02993da5360a1f6da2fb5] drivers: net: phy: xgene: Fix 'remove' function
git bisect good 440f895aa97f81a2bdc02993da5360a1f6da2fb5
# good: [b8f26e880c8166604e0da741eccd9fe6d8e1b9fb] Merge tag 'for-linus-4.8b-rc6-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect good b8f26e880c8166604e0da741eccd9fe6d8e1b9fb
# bad: [77e5bdf9f7b2d20939c8d807f3e68778d6e1557a] Merge branch 'uaccess-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect bad 77e5bdf9f7b2d20939c8d807f3e68778d6e1557a
# good: [2e29f50ad5e23db37dde9be71410d95d50241ecd] nios2: fix __get_user()
git bisect good 2e29f50ad5e23db37dde9be71410d95d50241ecd
# good: [c6852389228df9fb3067f94f3b651de2a7921b36] sh64: failing __get_user() should zero
git bisect good c6852389228df9fb3067f94f3b651de2a7921b36
# bad: [c90a3bc5061d57e7931a9b7ad14784e1a0ed497d] m32r: fix __get_user()
git bisect bad c90a3bc5061d57e7931a9b7ad14784e1a0ed497d
# bad: [917400cecb4b52b5cde5417348322bb9c8272fa6] sparc32: fix copy_from_user()
git bisect bad 917400cecb4b52b5cde5417348322bb9c8272fa6
# bad: [6e050503a150b2126620c1a1e9b3a368fcd51eac] sh: fix copy_from_user()
git bisect bad 6e050503a150b2126620c1a1e9b3a368fcd51eac
# first bad commit: [6e050503a150b2126620c1a1e9b3a368fcd51eac] sh: fix copy_from_user()
