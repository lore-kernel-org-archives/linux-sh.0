Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	LONGWORDS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BC6C433EF
	for <linux-sh@archiver.kernel.org>; Thu, 16 Sep 2021 12:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB4A60F26
	for <linux-sh@archiver.kernel.org>; Thu, 16 Sep 2021 12:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbhIPMHi (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbhIPMHg (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 16 Sep 2021 08:07:36 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3019DC061764
        for <linux-sh@vger.kernel.org>; Thu, 16 Sep 2021 05:06:16 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id z62so5840516vsz.9
        for <linux-sh@vger.kernel.org>; Thu, 16 Sep 2021 05:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5UL/xozUpE+qQ5p1w6FbzHdw42Dyfa73IMjcTE5EdA=;
        b=IAF70Wv00OuftgUZ5UIxcUZ9/GqHn3yB4Xzm4y5liq2VFPfGuMOAitCNrPSzCqAS5Z
         kEg+KY/pJG/7hBLi9LYod0HFWWJcPVOJPZ0lLWdUWtfqpjMajJVc6lvHeIbjWsyomPt+
         TYeYSQM/9AecJ96neZ1zdc/FyefEY6OMa8OAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5UL/xozUpE+qQ5p1w6FbzHdw42Dyfa73IMjcTE5EdA=;
        b=0IBYbVhjgjhUivfA62if313nG6Bz4849gERIg5GZFEfHQ1kK4aQaHlyWxnI78msbmP
         190h2C0LQO89BEZJW4a6w0KargLo8OCjoeNxUbxcgi1eRAZkap4P7TQMJqUNPCHPFfCm
         tFjSqOExpttSNJs59ahddc+T2+pln/QjZVf7852r+PNl1MCR1bZiTSRrzkO9xpVEGPya
         SzLxKa6oa+gkN91lvefNnlLSFGdEPveKNAaubMzgzBY0SjnVK6GqBtvK8rJsvTdrtr6C
         MHK/3M5EKw17oWrjJ8DXRc9MWnvIMpg2jAVQHwkduT7axJ9AMzw/kotVxF4TcP1XNzeK
         00AQ==
X-Gm-Message-State: AOAM5328+YL04vFwVz/EySeDDwMeMDHziTjLFhGKvCDWp2yFk4d3WeZM
        w9QKq/+eaO86KfCHchtmSjhscP7F+YVRkqOOGV1trw==
X-Google-Smtp-Source: ABdhPJzwtXBNinoO6mto3WAROebVHf0ybSLBse9r0Rkv0YDxF0jFHxJegCQ/IOaQUBLbXAbXbaR/2kTzuvqK1xdlf08=
X-Received: by 2002:a67:f60f:: with SMTP id k15mr3711481vso.9.1631793975133;
 Thu, 16 Sep 2021 05:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
In-Reply-To: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 16 Sep 2021 21:06:04 +0900
Message-ID: <CAFr9PXkCu0KyYXn4gPMfB0Kh3-a9m4z4T-z0siToXamKn3=DGw@mail.gmail.com>
Subject: Re: [PATCH] sh: pgtable-3level: Fix cast to pointer from integer of
 different size
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Linux-sh list <linux-sh@vger.kernel.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, 15 Sept 2021 at 22:52, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Anyone with e.g. a Migo-R or Ecovec to boot-test?

Tested-by: Daniel Palmer <daniel@thingy.jp>

--- Massive boot log from an ecovec ---

Bytes transferred = 25788416 (1898000 hex)
## Booting kernel from Legacy Image at 89000000 ...
  Image Name:   Linux-5.15.0-rc1
  Image Type:   SuperH Linux Kernel Image (gzip compressed)
  Data Size:    3175191 Bytes =  3 MB
  Load Address: 88001000
  Entry Point:  88002000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK
Linux version 5.15.0-rc1 (daniel@shiro)
(sh4-buildroot-linux-gnu-gcc.br_real (Buildroot
2021.02-715-g5e3799213236) 10.3.0, GNU ld (GNU Binutils) 2.36.1) #6
Thu Sep 16 21
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000000
... LOADER_TYPE       - 00000000
... INITRD_START      - 00000000
... INITRD_SIZE       - 00000000
Memory limited to 248MB
Booting machvec: R0P7724 (EcoVec)
initrd disabled
Zone ranges:
 Normal   [mem 0x0000000008000000-0x00000000177fffff]
Movable zone start for each node
Early memory node ranges
 node   0: [mem 0x0000000008000000-0x00000000177fffff]
Initmem setup node 0 [mem 0x0000000008000000-0x00000000177fffff]
Built 1 zonelists, mobility grouping on.  Total pages: 62930
Kernel command line: console=tty0, console=ttySC0,115200
phram.phram=rootfs,0x8a000000,32Mi memmap=32M$0x8a000000
root=/dev/mmcblk0 ro rootwait mem=248M memchunk.vpu=8mm
Unknown command line parameters: memmap=32M$0x8a000000
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
Sorting __ex_table...
mem auto-init: stack:off, heap alloc:off, heap free:off
PVR=10300b00 CVR=7144040d PRR=00002200
I-cache : n_ways=4 n_sets=256 way_incr=8192
I-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
D-cache : n_ways=4 n_sets=256 way_incr=8192
D-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
S-cache : n_ways=4 n_sets=2048 way_incr=65536
S-cache : entry_mask=0x0000ffe0 alias_mask=0x0000f000 n_aliases=16
virtual kernel memory layout:
   fixmap  : 0xdffd7000 - 0xdffff000   ( 160 kB)
   vmalloc : 0xc0000000 - 0xdffd5000   ( 511 MB)
   lowmem  : 0x88000000 - 0x97800000   ( 248 MB) (cached)
           : 0xa0000000 - 0xc0000000   ( 512 MB) (uncached)
     .init : 0x884eb000 - 0x8850a000   ( 124 kB)
     .data : 0x883ab8e8 - 0x884ea3ec   (1274 kB)
     .text : 0x88001000 - 0x883ab8e8   (3754 kB)
Memory: 246224K/253952K available (3750K kernel code, 266K rwdata,
1004K rodata, 124K init, 89K bss, 7724K reserved, 0K cma-reserved)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS: 8, nr_irqs: 8, preallocated irqs: 0
intc: Registered controller 'sh7724' with 83 IRQs
random: get_random_bytes called from start_kernel+0x3d6/0x740 with crng_init=0
Console: colour dummy device 80x25
printk: console [tty0] enabled
sh-cmt-32.0: ch0: used for clock events
sh-cmt-32.0: ch0: used for periodic clock events
sh-cmt-32.0: ch0: used as clock source
clocksource: sh-cmt-32.0: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 466616319891357 ns
sh-tmu.0: ch0: used for clock events
sh-tmu.0: ch0: used for periodic clock events
sh-tmu.0: ch1: used as clock source
clocksource: sh-tmu.0: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 183481014613 ns
sched_clock: 32 bits at 250 Hz, resolution 4000000ns, wraps every
8589934590000000ns
Calibrating delay loop (skipped)... 499.99 BogoMIPS PRESET (lpj=999999)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
CPU: SH7724
Performance Events: sh4a support registered
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 7645041785100000 ns
futex hash table entries: 256 (order: -1, 3072 bytes, linear)
pinctrl core: initialized pinctrl subsystem
NET: Registered PF_NETLINK/PF_ROUTE protocol family
DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
vpu: forcing memory chunk size to 0x00800000
veu0: forcing memory chunk size to 0x00400000
sh-pfc pfc-sh7724: sh7724_pfc handling gpio 0 -> 179
sh-pfc pfc-sh7724: sh7724_pfc handling gpio 180 -> 486
sh-pfc pfc-sh7724: sh7724_pfc support registered
HW Breakpoints: SH-4A UBC support registered
sh-pfc pfc-sh7724: Use of GPIO API for function requests is
deprecated, convert to pinctrl
USB1 function is selected
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
mc: Linux media interface: v0.10
videodev: Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
<giometti@linux.it>
PTP clock support registered
sh_cmt sh-cmt-32.0: kept as earlytimer
sh_tmu sh-tmu.0: kept as earlytimer
sh_tmu sh-tmu.1: ch0: used for clock events
sh_tmu sh-tmu.1: ch1: used as clock source
clocksource: sh-tmu.1: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 183481014613 ns
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource sh-tmu.0
sh_tmu sh-tmu.0: ch0: used for oneshot clock events
NET: Registered PF_INET protocol family
IP idents hash table entries: 4096 (order: 3, 32768 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
TCP established hash table entries: 2048 (order: 1, 8192 bytes, linear)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes, linear)
TCP: Hash tables configured (established 2048 bind 2048)
UDP hash table entries: 256 (order: 0, 4096 bytes, linear)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes, linear)
sq: Registering store queue API.
unable to read sh_eth MAC address
workingset: timestamp_bits=14 max_order=16 bucket_order=2
squashfs: version 4.0 (2009/01/31) Phillip Lougher
Console: switching to colour frame buffer device 100x30
sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: registered
sh_mobile_lcdc_fb.0/mainlcd as 800x480 16bpp.
SuperH (H)SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xffe00000 (irq = 80, base_baud = 0) is a scif
printk: console [ttySC0] enabled
sh-sci.1: ttySC1 at MMIO 0xffe10000 (irq = 81, base_baud = 0) is a scif
sh-sci.2: ttySC2 at MMIO 0xffe20000 (irq = 82, base_baud = 0) is a scif
sh-sci.3: ttySC3 at MMIO 0xa4e30000 (irq = 56, base_baud = 0) is a scifa
sh-sci.4: ttySC4 at MMIO 0xa4e40000 (irq = 88, base_baud = 0) is a scifa
sh-sci.5: ttySC5 at MMIO 0xa4e50000 (irq = 109, base_baud = 0) is a scifa
physmap-flash physmap-flash.0: physmap platform flash device: [mem
0x00000000-0x03ffffff]
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank.
Manufacturer ID 0x000001 Chip ID 0x002301
Amd/Fujitsu Extended Query Table at 0x0040
 Amd/Fujitsu Extended Query version 1.3.
number of CFI chips: 1
Creating 2 MTD partitions on "physmap-flash.0":
0x000000000000-0x000000500000 : "boot loader"
0x000000500000-0x000004000000 : "free-area"
phram: rootfs device: 0x2000000 at 0x8a000000 for erasesize 0x1000
SMSC LAN8700: probe of sh7724-ether-0:1f failed with error -22
libphy: sh_mii: probed
sh-eth sh7724-ether.0 eth0: Base address at 0xa4600000,
00:00:87:6c:1d:c2, IRQ 91.
r8a66597_hcd r8a66597_hcd.0: USB Host Controller
r8a66597_hcd r8a66597_hcd.0: new USB bus registered, assigned bus number 1
r8a66597_hcd r8a66597_hcd.0: irq 65, io base 0xa4d80000
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.15
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: USB Host Controller
usb usb1: Manufacturer: Linux 5.15.0-rc1 r8a66597_hcd
usb usb1: SerialNumber: r8a66597_hcd
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
sh-rtc sh-rtc: registered as rtc0
sh-rtc sh-rtc: hctosys: unable to read the hardware clock
renesas-ceu renesas-ceu.0: Renesas Capture Engine Unit renesas-ceu.0
renesas-ceu renesas-ceu.1: Renesas Capture Engine Unit renesas-ceu.1
cpufreq: SuperH CPU frequency driver.
cpufreq: cpufreq_online: ->get() failed
sh_mmcif sh_mmcif.0: Platform OCR mask is ignored
heartbeat: version 0.1.2 loaded
ALSA device list:
 No soundcards found.
sh_mmcif sh_mmcif.0: Chip version 0x0000, clock rate 83MHz
sh_mobile_sdhi sh_mobile_sdhi.0: mmc0 base at 0x04ce0000, max clock rate 83 MHz
Waiting for root device /dev/mmcblk0...
random: fast init done
usb 1-1: new full-speed USB device number 2 using r8a66597_hcd
mmc0: new SDHC card at address fb83
mmcblk0: mmc0:fb83 SE08G 7.22 GiB
VFS: Mounted root (squashfs filesystem) readonly on device 179:0.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 124K
This architecture does not have kernel memory protection.
Run /sbin/init as init process
usb 1-1: New USB device found, idVendor=10c4, idProduct=ea60, bcdDevice= 1.00
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: CP2102 USB to UART Bridge Controller
usb 1-1: Manufacturer: Silicon Labs
usb 1-1: SerialNumber: 0001
NET: Registered PF_UNIX/PF_LOCAL protocol family
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Starting mdev... OK
usbcore: registered new interface driver cp210x
usbserial: USB Serial support registered for cp210x
cp210x 1-1:1.0: cp210x converter detected
usb 1-1: cp210x converter now attached to ttyUSB0
Saving random seed: SKIP (read-only file system detected)
Starting haveged: haveged: command socket is listening at fd 3
OK
Starting network: Generic PHY sh7724-ether-0:1f: attached PHY driver
(mii_bus:phy_addr=sh7724-ether-0:1f, irq=POLL)
sh-eth sh7724-ether.0 eth0: Link is Up - 100Mbps/Full - flow control off
udhcpc: started, v1.33.0
NET: Registered PF_PACKET protocol family
udhcpc: sending discover
udhcpc: sending select for 192.168.3.251
udhcpc: lease of 192.168.3.251 obtained, lease time 3600
deleting routers
adding dns 192.168.3.1
adding dns 192.168.3.2
OK
Starting openntpd: -s option no longer works and will be removed soon.
Please reconfigure to use constraints or trusted servers.
constraint configured without libtls support
constraint configured without libtls support
constraint configured without libtls support
OK
No persistent location to store SSH host keys. New keys will be
generated at each boot. Are you sure this is what you want to do?
Starting dropbear sshd: NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
OK
Starting nodectrl: OK
Starting tlwbe_heartbeat: random: python3: uninitialized urandom read
(24 bytes read)
random: crng init done
CN12 SD/MMC Vdd: incomplete constraints, leaving on
OK

Welcome to Buildroot
ecovec24 login: sh4life
$ cat /proc/cpuinfo
machine         : R0P7724 (EcoVec)
processor       : 0
cpu family      : sh4a
cpu type        : SH7724
cut             : 11.x
cpu flags       : fpu perfctr llsc l2
cache type      : split (harvard)
icache size     : 32KiB (4-way)
dcache size     : 32KiB (4-way)
scache size     : 256KiB (4-way)
address sizes   : 29 bits physical
bogomips        : 499.99
$
