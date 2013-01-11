From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Jan 2013 03:53:20 +0000
Subject: Re: Current SuperH board can't boot
Message-Id: <87txqo4bpv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vcb44gaq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vcb44gaq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Michel

Thank you for your quick response.

> Could you please try with CONFIG_DEBUG_VM, CONFIG_DEBUG_VM_RB,
> loglevel=8 boot option, and the following patch which I hope may give
> us some useful debug information ?

Please check, this is my commands

> git checkout b4265f12340f809447b9a48055e88c444b480c89
> patch -p1 < your-patch
> make menuconfig
> grep CONFIG_DEBUG_VM .config
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_RB=y


-------- kernel log ------------------
...
asoc-simple-card asoc-simple-card.0:  da7210-hifi <-> fsib-dai mapping ok
Sending DHCP requests ..libphy: sh-eth-0:1f - Link is Up - 100/Full
., OK
IP-Config: Got DHCP answer from 192.168.10.77, my address is 192.168.10.119
IP-Config: Complete:
     device=eth0, addr2.168.10.119, mask%5.255.255.0, gw2.168.10.77
     host2.168.10.119, domain=example.org, nis-domain=(none)
     bootserver2.168.10.77, rootserver2.168.10.77, rootpath=/opt/tftpboot/rootfs_ms7724se
     nameserver02.168.10.77ALSA device list:
  #0: FSIB-DA7210
VFS: Mounted root (nfs filesystem) on device 0:9.
Freeing unused kernel memory: 136k freed
show_vm_unmapped_area_info: 0 1000 [29555555;7c000000) 0 0
unmapped_area: found 29555555
Kernel panic - not syncing: No init found.  Try passing init= option to kernel. See Linux Documentation/init.txt for guidance.
Stack: (0x8f029f3c to 0x8f02a000)
9f20:                                                                882b2fa6
9f40: 8f029f4c 00000000 8836ad68 882b3030 8f029f54 00000000 00000000 00000000
9f60: 8f029f84 882af03c 8f029f90 00000000 00000000 00000000 00000000 00000000
9f80: 88002050 883dd36c 883dd2e0 00140173 88003a78 8f029f9c 00000000 00000000
9fa0: 00000000 00000000 00000000 00000000 00000000 00000000 882aef98 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 8f029fa4 88003a70 00000000 40008000 00000000 00000000 00000000 00000000

Call trace:
 [<882b2fa6>] dump_stack+0xe/0x1c
 [<882b3030>] panic+0x7c/0x1b8
 [<882af03c>] kernel_init+0xa4/0xf8
 [<88002050>] run_init_process+0x0/0x24
 [<88003a78>] kernel_thread_helper+0x8/0x14
 [<882aef98>] kernel_init+0x0/0xf8
 [<88003a70>] kernel_thread_helper+0x0/0x14

1 lock held by init/1:
 #0:  (panic_lock){......}, at: [<882b2fde>] panic+0x2a/0x1b8
------------------------------

Best regards
---
Kuninori Morimoto
