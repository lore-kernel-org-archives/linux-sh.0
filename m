From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 10 Nov 2008 10:38:40 +0000
Subject: Re: repeated oops under load on SH4 system
Message-Id: <49180F30.6070502@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fd0635d10811040431l45e7b41fvee0a78650b15bacc@mail.gmail.com>
In-Reply-To: <fd0635d10811040431l45e7b41fvee0a78650b15bacc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Mon, Nov 10, 2008 at 05:11:59PM +0900, Paul Mundt wrote:
>> On Mon, Nov 10, 2008 at 05:06:23PM +0900, Paul Mundt wrote:
>>> On Tue, Nov 04, 2008 at 09:31:44PM +0900, CHIKAMA Masaki wrote:
>>>> Hello all.
>>>>
>>>> I've got repeated oops message  under a load on kernel 2.6.26.7.
>>>> It happens once or twice per a week with the below message.
>>>>
>>>>> Unable to handle kernel paging request at virtual address dfff0700
>>>>> Unable to handle kernel paging request at virtual address dfff1000
>>>>> Unable to handle kernel paging request at virtual address dfff0a00
>>>> I have been gotten this message from around kernel 2.6.23. I didn't
>>>> test before it.
>>>> My hardware is mach-landisk with attached .config.
>>>> The root file system is on nfs server.
>>>> Please let me know if  you need more information to investigating the problem.
>>>> Could somebody give me a hint to resolve the issue ?
>>>>
>>>> Thanks in advance.
>>>>
>>> This suggests you are getting a TLB miss on various fixmap entries. Based
>>> on your call chain, these are related to the cache colouring in the page
>>> copying. update_mmu_cache() specifically faults the translation in, so
>>> you should not be making it all the way up to the TLB miss handler in the
>>> first place. This points to something evicting the entry from the TLB
>>> during your copy, which while it is not something I have seen in
>>> practice, is interesting to know that it remains a possibility under
>>> other workloads. A simple but expensive fix for this would be blowing out
>>> the TLB and speculatively bumping up the UTLB replace boundary prior to
>>> pre-faulting the fixmap translation. I'll look at this some more over the
>>> next couple days and send you a patch for testing.
>> Now I remember where I saw this before.. try this patch:
>>
>> http://marc.info/?l=linux-sh&m0400865707505&w=2
>>
>> There was never any feedback on it, and I was not able to reproduce the
>> issues.
> 
> Updated version, against current git:

I had a just similar problem today, too. When I used sh7785lcr board,
it output following log.
But a problem did not occur when I used this patch.
Thank you very much!

config:
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_STORAGE=m

log:
Badness at 8800cd7a [verbose debug info unavailable]

Pid : 2652, Comm:         runscript.sh
PC is at from_device+0x2e/0x7c
PC  : 8800cd7a SP  : 8fb1fcfc SR  : 400081f0 TEA : c002dae4    Not tainted
R0  : 80000000 R1  : 00000001 R2  : feedbeef R3  : ffffffff
R4  : dffef6e4 R5  : dffef6e4 R6  : 00000004 R7  : 0000000c
R8  : 80000000 R9  : 00000004 R10 : dffef6e4 R11 : 8fb1fe08
R12 : 883065c4 R13 : 8f834080 R14 : 8fb1fcfc
MACH: 00000000 MACL: 00000000 GBR : 29748450 PR  : 8800cd66

Call trace:
[<880060c6>] handle_unaligned_ins+0x102/0x1ac
[<8800651e>] handle_unaligned_access+0x3ae/0x3f2
[<8800ce30>] handle_trapped_io+0x68/0x94
[<8800e0bc>] do_page_fault+0x138/0x2f0
[<881b623c>] rh_timer_func+0x0/0x18
[<881b61fc>] usb_hcd_poll_rh_status+0x130/0x170
[<881b6246>] rh_timer_func+0xa/0x18
[<881b623c>] rh_timer_func+0x0/0x18
[<8803cca2>] __rcu_process_callbacks+0x126/0x1d4
[<8803cd68>] rcu_process_callbacks+0x18/0x38
[<8801aa32>] _local_bh_enable+0x42/0x5c
[<8801aae6>] __do_softirq+0x9a/0xcc
[<8801ab50>] do_softirq+0x38/0x70
[<8801aefa>] irq_exit+0x32/0x58
[<8801af00>] irq_exit+0x38/0x58
[<880070e0>] ret_from_exception+0x0/0x8
[<880070e0>] ret_from_exception+0x0/0x8
[<8814a626>] copy_page+0x12/0x4c
[<8800ea92>] copy_user_highpage+0xf2/0x18c
[<8801028c>] sub_preempt_count+0x0/0x74
[<8804be0a>] do_wp_page+0x296/0x490
[<8804c27e>] handle_mm_fault+0x27a/0x5c0
[<88251030>] __down_read+0x40/0x12c
[<8800e042>] do_page_fault+0xbe/0x2f0
[<88010114>] pick_next_task_fair+0x84/0xa8
[<880070e0>] ret_from_exception+0x0/0x8
[<8801fffa>] do_sigaction+0xde/0x158
[<8802001c>] do_sigaction+0x100/0x158
[<88022c52>] sys_rt_sigaction+0x4e/0x90
[<880070e0>] ret_from_exception+0x0/0x8
[<880070e0>] ret_from_exception+0x0/0x8

Thanks,
Yoshihiro Shimoda
