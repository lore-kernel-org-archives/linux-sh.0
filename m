From: youling257 <youling257@gmail.com>
Date: Mon, 04 Nov 2019 07:26:53 +0000
Subject: Re: ALSA: pcm: use dma_can_mmap() to check if a device supports dma_mmap_*
Message-Id: <9e41aba3-c8ba-1d54-d693-fb822c58925f@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <20190808160005.10325-6-hch@lst.de>
References: <CAOzgRdYSaaF6OkXGME2=fn1dfTbpyt_GqEs=10oXH=V6SudfyA@mail.gmail.com>
In-Reply-To: <CAOzgRdYSaaF6OkXGME2=fn1dfTbpyt_GqEs=10oXH=V6SudfyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@lst.de
Cc: linux-xtensa@linux-xtensa.org, monstr@monstr.eu, vladimir.murzin@arm.com, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, tiwai@suse.de, linuxppc-dev@lists.ozlabs.org, deller@gmx.de, x86@kernel.org, linux-kernel@vger.kernel.org, gregkh@google.com

This patch cause oops on android mainline kernel about gadget audio_source.

Androidx86 run on android mainline kernel.


[ 385.104963] android_work: sent uevent USB_STATE=CONNECTED

[ 385.109006] android_work: sent uevent USB_STATE=DISCONNECTED

[ 385.182024] android_work: sent uevent USB_STATE=CONNECTED

[ 385.184737] configfs-gadget gadget: high-speed config #1: b

[ 385.184921] android_work: sent uevent USB_STATE=CONFIGURED

[ 385.285268] BUG: kernel NULL pointer dereference, address: 
0000000000000220

[ 385.285339] #PF: supervisor read access in kernel mode

[ 385.285374] #PF: error_code(0x0000) - not-present page

[ 385.285436] PGD 80000000791e6067 P4D 80000000791e6067 PUD 0

[ 385.285473] Oops: 0000 [#1] PREEMPT SMP PTI

[ 385.285509] CPU: 0 PID: 5780 Comm: Binder:1383_5 Tainted: G O

5.4.0-rc6-android-x86_64+ #1

[ 385.285571] Hardware name: Insyde ONDA Tablet/ONDA Tablet, BIOS

ONDA.D890HBBNR0A 03/11/2015

[ 385.285639] RIP: 0010:dma_can_mmap+0x5/0x30

[ 385.285675] Code: 74 11 e9 ae 98 b2 00 48 8b 05 9f 40 94 01 48 85 c0

75 e3 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44

00 00 <48> 8b 87 20 02 00 00 48 85 c0 74 09 48 83 78 10 00 0f 95 c0 c3

48

[ 385.285762] RSP: 0018:ffffb39443b63b78 EFLAGS: 00010246

[ 385.285797] RAX: 0000000000000001 RBX: ffffa28b91756600 RCX: 
0000000000000040

[ 385.285857] RDX: ffffffffb62b2a00 RSI: 0000000000000000 RDI: 
0000000000000000

[ 385.285917] RBP: ffffa28bac69f800 R08: ffffffffb63141b0 R09: 
ffffa28bf9a34a88

[ 385.285952] R10: ffffffffb62b2be0 R11: ffffffffb62b2bd0 R12: 
0000000000000008

[ 385.286013] R13: 0000000000000000 R14: ffffa28bacd736a8 R15: 
ffffa28bacd736c8

[ 385.286076] FS: 0000000000000000(0000) GS:ffffa28bfb600000(0063)

knlGS:00000000f5d81970

[ 385.286110] CS: 0010 DS: 002b ES: 002b CR0: 0000000080050033

[ 385.286171] CR2: 0000000000000220 CR3: 000000007b2f6000 CR4: 
00000000001006f0

[ 385.286232] Call Trace:

[ 385.286275] snd_pcm_hw_constraints_complete+0x3e/0x1f0

[ 385.286314] snd_pcm_open_substream+0x94/0x140

[ 385.286377] snd_pcm_open+0xf0/0x240

[ 385.286416] ? wake_up_q+0x60/0x60

[ 385.286460] snd_pcm_playback_open+0x3d/0x60

[ 385.286533] chrdev_open+0xa2/0x1c0

[ 385.286574] ? cdev_put.part.0+0x20/0x20

[ 385.286615] do_dentry_open+0x13a/0x380

[ 385.286686] path_openat+0x588/0x15d0

[ 385.286728] do_filp_open+0x91/0x100

[ 385.286769] ? __check_object_size+0x136/0x147

[ 385.286840] do_sys_open+0x184/0x280

[ 385.286880] ? handle_mm_fault+0xd7/0x1c0

[ 385.286920] do_fast_syscall_32+0x8e/0x250

[ 385.286992] entry_SYSENTER_compat+0x7c/0x8e


[ 385.287302] CR2: 0000000000000220

[ 385.287391] ---[ end trace 73ffcefcbbe2b9a0 ]---

[ 385.296269] RIP: 0010:dma_can_mmap+0x5/0x30

[ 385.296337] Code: 74 11 e9 ae 98 b2 00 48 8b 05 9f 40 94 01 48 85 c0

75 e3 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44

00 00 <48> 8b 87 20 02 00 00 48 85 c0 74 09 48 83 78 10 00 0f 95 c0 c3

48

[ 385.296407] RSP: 0018:ffffb39443b63b78 EFLAGS: 00010246

[ 385.296477] RAX: 0000000000000001 RBX: ffffa28b91756600 RCX: 
0000000000000040

[ 385.296516] RDX: ffffffffb62b2a00 RSI: 0000000000000000 RDI: 
0000000000000000

[ 385.296584] RBP: ffffa28bac69f800 R08: ffffffffb63141b0 R09: 
ffffa28bf9a34a88

[ 385.296654] R10: ffffffffb62b2be0 R11: ffffffffb62b2bd0 R12: 
0000000000000008

[ 385.296693] R13: 0000000000000000 R14: ffffa28bacd736a8 R15: 
ffffa28bacd736c8

[ 385.296761] FS: 0000000000000000(0000) GS:ffffa28bfb600000(0063)

knlGS:00000000f5d81970

[ 385.296830] CS: 0010 DS: 002b ES: 002b CR0: 0000000080050033

[ 385.296867] CR2: 0000000000000220 CR3: 000000007b2f6000 CR4: 
00000000001006f0

[ 385.296936] Kernel panic - not syncing: Fatal exception

[ 385.296985] Kernel Offset: 0x33e00000 from 0xffffffff81000000

(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

[ 385.305185] Rebooting in 5 seconds..


Revert it no the oops.
