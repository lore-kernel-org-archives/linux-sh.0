From: "Pietrek, Markus" <Markus.Pietrek@emtrion.de>
Date: Thu, 24 Dec 2009 09:50:31 +0000
Subject: AW: Probably cache synchronization issue on SH7723
Message-Id: <95F51F4B902CAC40AF459205F6322F0133E18561FF@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
References: <4B17B0D6.6020105@emtrion.de>
In-Reply-To: <4B17B0D6.6020105@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Matt,

> I'm assuming that if you set exec to 0 when vma = NULL then you still
> see the cache issues? In which case, this patch probably works because
> it's aggressively flushing the cache and unfortunately will be papering
> over the real bug.

With exec = 0, the cache issues are still present.

> What sort of workload do you have that triggers this bug? Did you say
> it
> was a graphics app? Is the app available anywhere? If I could reproduce
> it on my board it would make it easier for me to diagnose the bug.

The bug happens mostly on graphic applications like ts_test from the touch library libts or any Qt based application. There is a way to increase the probability to appear to almost 100% on my HiCO.DIMM7723 board when using nfsroot.

When booting by network, a lot of shared libraries have already been loaded before I can launch ts_test. So their pages might already been synchronized in the instruction/data cache. But if I mount the rootfs a second time and chroot into it and then start the application, it always crashes. The next calls might crash, but the third and later calls always works. To see the crash a second time I need to unmount the filesystem and mount it again.

BusyBox v1.12.4 (2009-12-09 12:43:33 CET) built-in shell (ash)
Enter 'help' for a list of built-in commands.

~ # mount -o nolock 192.168.2.11:/nfsroot/hico7723/rootfs /mnt
~ # chroot /mnt
~ # mount -a; mdev -s; . /etc/profile._tslib
BusyBox v1.12.4 (2009-12-09 12:43:33 CET) built-in shell (ash)
Enter 'help' for a list of built-in commands.
~ # ts_test
Segmentation fault
~ # ts_test
Illegal instruction
~ # ts_test
^Csignal 2 caught
~ # exit
~ # umount /mnt/proc; umount /mnt/sys; umount /mnt/tmp; umount /mnt/mnt; umount
/mnt/var/run; umount /mnt/var/log; umount /mnt
~ # mount -o nolock 192.168.2.11:/nfsroot/hico7723/rootfs /mnt
~ # chroot /mnt
~ # mount -a; mdev -s; . /etc/profile._tslib
BusyBox v1.12.4 (2009-12-09 12:43:33 CET) built-in shell (ash)
Enter 'help' for a list of built-in commands.
~ # ts_test
Inconsistency detected by ld.so: dynamic-link.h: 165: elf_get_dynamic_info: Assertion `info[9]->d_un.d_val = sizeof (Elf32_Rela)' failed!
~ # ts_test
^Csignal 2 caught
~ #


> If we can't find the cause of this bug soon I imagine that Paul will
> queue up some band-aid patch so that, whilst there will be a
> performance
> loss, at least things will work correctly ;-)

The loss might not be as big as having to use the cache in write-through mode ;-)



_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
