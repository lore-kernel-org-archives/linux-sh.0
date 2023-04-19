Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AA5C77B73
	for <linux-sh@archiver.kernel.org>; Wed, 19 Apr 2023 07:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjDSH3J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 19 Apr 2023 03:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjDSH3I (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 19 Apr 2023 03:29:08 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2649F61B4
        for <linux-sh@vger.kernel.org>; Wed, 19 Apr 2023 00:29:06 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pp2FR-001kDN-1G; Wed, 19 Apr 2023 09:29:01 +0200
Received: from p5b13a017.dip0.t-ipconnect.de ([91.19.160.23] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pp2FQ-001cZu-QO; Wed, 19 Apr 2023 09:29:00 +0200
Message-ID: <b6ba777419f0d94c5f39cfc4698e2dd4f7319e16.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Fix J-core aic warning spam
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Date:   Wed, 19 Apr 2023 09:29:00 +0200
In-Reply-To: <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
         <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
         <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
         <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net>
         <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
         <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net>
         <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
         <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.23
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rob!

On Tue, 2023-04-18 at 16:19 -0500, Rob Landley wrote:
> (...)
> SH generic board support: scanning for interrupt controllers
> Initializing J-Core AIC
> ------------[ cut here ]------------
> error: virq16 is not allocated
> WARNING: CPU: 0 PID: 0 at kernel/irq/irqdomain.c:571
> irq_domain_associate+0x120/0x178
> 
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2 #1
> PC is at irq_domain_associate+0x120/0x178
> PR is at irq_domain_associate+0x120/0x178
> PC  : 10049b90 SP  : 103bdec0 SR  : 400001f1
> R0  : 0000001e R1  : 1042d024 R2  : 1042d024 R3  : 00000028
> R4  : 00000001 R5  : 0006f1ff R6  : 00000008 R7  : 103bde04
> R8  : 1200c000 R9  : 00000010 R10 : 00000000 R11 : 00000010
> R12 : 10049a70 R13 : 103bfcac R14 : 1030a398
> MACH: 00000000 MACL: 00057fa8 GBR : 00000000 PR  : 10049b90
> 
> Call trace:
>  [<100496f0>] __irq_domain_add+0x80/0x1dc
>  [<10049cd2>] irq_domain_create_legacy+0x46/0x68
>  [<10049a70>] irq_domain_associate+0x0/0x178
>  [<104517da>] aic_irq_of_init+0x82/0xd8
>  [<1020ab90>] of_iomap+0x0/0x30
>  [<1031df1c>] _printk+0x0/0x24
>  [<1045630c>] of_irq_init+0xe4/0x228
>  [<100a5a10>] kfree+0x0/0x250
>  [<10042376>] vprintk_emit+0xde/0x1fc
>  [<1004239c>] vprintk_emit+0x104/0x1fc
>  [<10309940>] strlen+0x0/0x60
>  [<100424a6>] vprintk_default+0x12/0x20
>  [<10309940>] strlen+0x0/0x60
>  [<10002a2c>] arch_local_save_flags+0x0/0x8
>  [<1031df1c>] _printk+0x0/0x24
>  [<104456f8>] init_IRQ+0x14/0x28
>  [<10309940>] strlen+0x0/0x60
>  [<10002a2c>] arch_local_save_flags+0x0/0x8
>  [<1031df1c>] _printk+0x0/0x24
>  [<1044394c>] start_kernel+0x3b8/0x73c
>  [<1044320c>] unknown_bootoption+0x0/0x170
>  [<1000202a>] _stext+0x2a/0x34
> 
> Code:
>   10049b8a:  mov.l     10049bd8 <irq_domain_associate+0x168/0x178>, r4  !
> 10393da0 <0x10393da0>
>   10049b8c:  jsr       @r1
>   10049b8e:  mov       r11, r5
> ->10049b90:  trapa     #62
>   10049b92:  bra       10049b0e
>   10049b94:  mov       #-22, r12
>   10049b96:  mov.l     10049bd0 <irq_domain_associate+0x160/0x178>, r1  !
> 1031da2c <__warn_printk+0x0/0x38>
>   10049b98:  mov.l     10049bdc <irq_domain_associate+0x16c/0x178>, r4  !
> 10393dc0 <0x10393dc0>
>   10049b9a:  jsr       @r1
> 
> ---[ end trace 0000000000000000 ]---
> (...)
> rcu: srcu_init: Setting srcu_struct sizes based on contention.
> Initializing J-Core PIT at (ptrval) IRQ 16
> clocksource: jcore_pit_cs: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:
> 1911260446 ns
> sched_clock: 32 bits at 1000MHz, resolution 1ns, wraps every 2147483647ns
> Local J-Core PIT init on cpu 0
> SH generic board support: scanning for clk providers
> Calibrating delay loop... 30.31 BogoMIPS (lpj=151552)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
> CPU: J2
> rcu: Hierarchical SRCU implementation.
> printk: bootconsole [uartlite_a0] printing thread started
> smp: Bringing up secondary CPUs ...
> J2 SMP: requested start of cpu 1
> Local J-Core PIT init on cpu 1
> smp: Brought up 1 node, 2 CPUs
> SMP: Total of 2 processors activated (61.03 BogoMIPS).
> devtmpfs: initialized
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:
> 19112604462750000 ns
> futex hash table entries: 512 (order: 1, 8192 bytes, linear)
> NET: Registered PF_NETLINK/PF_ROUTE protocol family
> clocksource: Switched to clocksource jcore_pit_cs
> NET: Registered PF_INET protocol family
> IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
> tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
> Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> TCP established hash table entries: 1024 (order: 0, 4096 bytes, linear)
> TCP bind hash table entries: 1024 (order: 1, 8192 bytes, linear)
> TCP: Hash tables configured (established 1024 bind 1024)
> UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
> UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
> NET: Registered PF_UNIX/PF_LOCAL protocol family
> workingset: timestamp_bits=30 max_order=15 bucket_order=0
> squashfs: version 4.0 (2009/01/31) Phillip Lougher
> printk: console [ttyUL0] enabled
> printk: bootconsole [uartlite_a0] disabled
> printk: console [ttyUL0] printing thread started
> printk: bootconsole [uartlite_a0] printing thread stopped
> loop: module loaded
> jcore_spi abcd0040.spi: Runtime PM disabled, clock forced on.
> mmc_spi spi0.0: SD/MMC host mmc0, no DMA, no WP, no poweroff, cd polling
> NET: Registered PF_INET6 protocol family
> Segment Routing with IPv6
> In-situ OAM (IOAM) with IPv6
> NET: Registered PF_PACKET protocol family
> printk: console [netcon0] enabled
> netconsole: network logging started
> printk: console [netcon0] printing thread started
> mmc0: host does not support reading read-only switch, assuming write-enable
> mmc0: new SDHC card on SPI
> mmcblk0: mmc0:0000 SK32G 29.7 GiB
>  mmcblk0: p1
> devtmpfs: mounted
> Freeing unused kernel image (initmem) memory: 728K
> This architecture does not have kernel memory protection.
> Run /init as init process
> ifconfig: ioctl 8916: No such device
> sntp: sendto: Network unreachable
> sntp: time.google.com:123: Try again
> [?7hType exit when done.
> #

So, this definitely shows that we're missing the call to irq_alloc_descs() which means that the
original patch does not just address noisy boot messages but actually fixes the missing allocation
of IRQ descriptors which is why you're seeing all these error messages.

Thus, I would suggest adjusting the patch title and description as well as making the allocation
failure a fatal error as Geert suggested.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
