From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 04 Dec 2009 10:51:55 +0000
Subject: Re: [PATCH] Fix too early disabling of the serial (SCI(F)) ports
Message-Id: <aec7e5c30912040251n7046dc1dgafda6f90c90746d4@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912011045150.4701@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912011045150.4701@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 4, 2009 at 1:45 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Dec 01, 2009 at 10:54:46AM +0100, Guennadi Liakhovetski wrote:
>> Currently serial ports on SH CPUs get disabled too early, because the
>> sci_tx_empty() routine claims to not be able to detect whether the
>> transmission has been completed and just always returns TIOCSER_TEMT. This
>> results in corrupt output of last characters if the port is not open for
>> reading at the same time. It is however possible to detect whether
>> transmission has been completed. Use the TEND bit of the status register
>> for this.
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> Applied, thanks.

I'm not sure if this is tested very well. My Migo-R board does not
boot anymore. Reverting this patch fixes the issue.

/ magnus

Freeing unused kernel memory: 3344k freed
irq 80: nobody cared (try booting with the "irqpoll" option)
Stack: (0x8f819c04 to 0x8f81a000)
9c00:          8c050e40 8c2828c0 8c331f6c 8c050fca 00000000 8c331f6c 8c331f6c
9c20: 8c051bea 8ea7d4a0 8c003d00 00000000 0000004f 8f819cf4 00000050 8c331f6c
9c40: 8c003aae 8c341b1c 00000050 8c0090ec 8ea7d920 8c003a80 400080f1 8c003d00
9c60: 00000000 40000000 00000000 00000000 8ea7d920 00000080 00000100 8c331f1c
9c80: 0000004f 8ea7d920 0000004f 00000000 8c003d00 8ea7d4a0 8f819cb8 8c003d12
9ca0: 8c04fb66 40000000 00000000 00000002 000018b0 ffffffff 8c051b84 8ea7d4a0
9cc0: 8c003d00 00000000 00000050 00000000 0000004f 8c331f1c 8c003aae 8c341b1c
9ce0: 0000004f 8c0090ec 8ea7d4a0 8c003a80 400080f1 00000000 00000000 40000000
9d00: 8c1e4080 00000000 0a0b4220 00000001 00000050 ffffffda 8c331f6c 8ea7d4a0
9d20: 00000050 00000000 8c003d00 8ea7d4a0 8f819d50 8c003d12 8c0503ce 40000000
9d40: 00000000 00000002 00001900 ffffffff 8c05072e 8c331f6c 00000000 00000050
9d60: 8c177580 00000020 fffffff4 8c1766b8 00000000 8c6cc540 8c6cc5bc 8f819da4
9d80: 8f819d94 8c6cc540 00000000 8c2ebab0 8c6cc540 8c2ebb70 8c2ebb84 8c2ebb9c
9da0: 8c2ebbb4 8c177080 8c176d20 8c1769c0 8c1767a0 8c173eec 00000000 8c6cc540
9dc0: 8c6cc580 fffffff4 00000000 8e932400 8e932440 8c174c52 00000001 8f832620
9de0: 8e93242c 8f832620 ffffffed 8e932400 8ea72c00 8e932440 8c160f80 8c15b6aa
9e00: 8e945a1c 00000000 00000000 8ea72c00 8e9459a0 8c15b940 00000001 8e9459a4
9e20: 8f832620 8f832620 00500001 8ea72c00 8e9459a0 8f43b804 00000002 00000000
9e40: 8c0a02b0 8f80f7a0 8f43cc94 8f832620 8f43b804 8c6ca864 00000000 8c0a0220
9e60: 00000000 8c09b198 8c0a0260 00000000 8f832660 8f43b804 8f832620 8c09b4d2
9e80: 00000026 ffffff9c 8f819ed4 00000003 8f831000 ffffffe9 8f832620 00000000
9ea0: 8f817660 8c0a9e28 00000000 00000000 40000000 8c003d00 8f819f14 00001b8e
9ec0: 00000000 00000002 00000000 00000000 8c01c500 8f80f7a0 8f43cc94 0000002d
9ee0: 8c32e638 8f819f04 00000000 8f401794 00000101 00000001 00000000 00000000
9f00: ffffffff 00000034 00000000 8c34eee0 00000000 8c34eecc 00000003 8c0b3bb0
9f20: 00000003 00000000 8f832620 8f81abc8 00000000 8f81abc0 00000000 8c09afe0
9f40: 00000000 fffff000 00000000 ffffff9c 00000002 00000000 8f831000 00000000
9f60: 8c002264 00000000 00000000 8c3748b8 8c374bb4 8c002060 8c374bb4 8c353278
9f80: 8c374bb4 8c002060 8c374bb4 8c004386 00000000 00000000 00000000 00000000
9fa0: 00000000 00000000 00000000 00000000 00000000 00000000 8c3531cc 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 8f819fa4 8c004380 00000000 40000000 00000000 00000000 00000000 00000000

Call trace:
 [<8c2828c0>] printk+0x0/0x28
 [<8c050fca>] note_interrupt+0xea/0x1a0
 [<8c051bea>] handle_level_irq+0xaa/0x100
 [<8c003d00>] raw_local_irq_restore+0x0/0x40
 [<8c003aae>] do_IRQ+0x2e/0x60
 [<8c0090ec>] ret_from_exception+0x0/0xc
 [<8c003a80>] do_IRQ+0x0/0x60
 [<8c003d00>] raw_local_irq_restore+0x0/0x40
 [<8c003d00>] raw_local_irq_restore+0x0/0x40
 [<8c003d12>] raw_local_irq_restore+0x12/0x40
 [<8c04fb66>] handle_IRQ_event+0x106/0x180
 [<8c051b84>] handle_level_irq+0x44/0x100
 [<8c003d00>] raw_local_irq_restore+0x0/0x40
 [<8c003aae>] do_IRQ+0x2e/0x60
 [<8c0090ec>] ret_from_exception+0x0/0xc
 [<8c003a80>] do_IRQ+0x0/0x60
 [<8c1e4080>] intc_mode_field+0x0/0x20
 [<8c003d00>] raw_local_irq_restore+0x0/0x40
 [<8c003d12>] raw_local_irq_restore+0x12/0x40
 [<8c0503ce>] __setup_irq+0x10e/0x380
 [<8c05072e>] request_threaded_irq+0xee/0x180
 [<8c177580>] sci_mpxed_interrupt+0x0/0x1a0
 [<8c1766b8>] sci_startup+0xb8/0x1a0
 [<8c177080>] sci_er_interrupt+0x0/0x500
 [<8c176d20>] sci_rx_interrupt+0x0/0x360
 [<8c1769c0>] sci_tx_interrupt+0x0/0x360
 [<8c1767a0>] sci_br_interrupt+0x0/0x220
 [<8c173eec>] uart_startup+0x4c/0x180
 [<8c174c52>] uart_open+0xd2/0x420
 [<8c160f80>] tty_ldisc_enable+0x0/0x40
 [<8c15b6aa>] tty_init_dev+0x6a/0x160
 [<8c15b940>] tty_open+0x1a0/0x500
 [<8c0a02b0>] chrdev_open+0x50/0x140
 [<8c0a0220>] cdev_put+0x0/0x40
 [<8c09b198>] __dentry_open+0x78/0x280
 [<8c0a0260>] chrdev_open+0x0/0x140
 [<8c09b4d2>] nameidata_to_filp+0x52/0x80
 [<8c0a9e28>] do_filp_open+0x4a8/0xa00
 [<8c003d00>] raw_local_irq_restore+0x0/0x40
 [<8c01c500>] emit_log_char+0x0/0x80
 [<8c0b3bb0>] alloc_fd+0x70/0x140
 [<8c09afe0>] do_sys_open+0x60/0x140
 [<8c002264>] init_post+0x24/0x160
 [<8c002060>] do_one_initcall+0x0/0x1e0
 [<8c353278>] kernel_init+0xac/0x130
 [<8c002060>] do_one_initcall+0x0/0x1e0
 [<8c004386>] kernel_thread_helper+0x6/0x20
 [<8c3531cc>] kernel_init+0x0/0x130
 [<8c004380>] kernel_thread_helper+0x0/0x20

handlers:
[<8c177580>] (sci_mpxed_interrupt+0x0/0x1a0)
Disabling IRQ #80
irq 80: nobody cared (try booting with the "irqpoll" option)
Stack: (0x8f819c18 to 0x8f81a000)
