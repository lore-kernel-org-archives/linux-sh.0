From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Wed, 13 May 2015 07:51:57 +0000
Subject: Re: [Bug Report] PM: Warning messages
Message-Id: <5553029D.3080404@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <5552F449.6030509@jinso.co.jp>
In-Reply-To: <5552F449.6030509@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Geert-san,
Thanks for your replying.

On 2015年05月13日 16:23, Geert Uytterhoeven wrote:
> Hi Hiep-san,
>
> On Wed, May 13, 2015 at 8:50 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
>> We are testing Linux upstream version-4.1-rc2 on Koelsch and Lager.
>> We found Warning messages of PM after resuming system.
>> The Warning messages is showed as below:
>>
>> "WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572
>> irq_set_irq_wake+0x9c/0xf8()
>> Unbalanced IRQ 26 wake disable
>> CPU: 0 PID: 1697 Comm: bash Tainted: G W 4.1.0-rc2 #59
>> Hardware name: Generic R8A7791 (Flattened Device Tree)
>> Backtrace:
>> [<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
>> r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
>> [<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
>> [<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
>> r5:00000009 r4:ee2d1c98
>> [<c00271dc>] (warn_slowpath_common) from [<c00272fc>]
>> (warn_slowpath_fmt+0x38/0x40)
>> r9:00000000 r8:00000000 r7:00000010 r6:0000001a r5:ee8dda00 r4:00000000
>> [<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>]
>> (irq_set_irq_wake+0x9c/0xf8)
>> ..."
>>
>> Testing method:
>> # echo enabled >
>> /sys/devices/platform/e6c40000.serial/tty/ttySC0/power/wakeup
>> # echo mem > /sys/power/state
>> # Resuming system by a key from keyboard.
>>
>> We'd like to report this problem first.
>> There are no warning messages at version v4.0 stable.
>> so we are looking for the error patch that added between v4.0 and v4.1-rc2.
>>
>> Best Regards,
>> Jinso/Cao Minh Hiep.
>>
>> We'd like to send the details of PM's Warning messages on two Board:
>> Koelsch_PM_supend-resume_warning_messages
>> Lager_PM_supend-resume_warning_messages
>> ==========================
>> Koelsch_PM_supend-resume_warning_messages:
>>
>> root@linaro-nano:~# echo mem > /sys/power/state
>> PM: Syncing filesystems ... done.
>> Freezing user space processes ... (elapsed 0.017 seconds) done.
>> Freezing remaining freezable tasks ... (elapsed 0.011 seconds) done.
>> Suspending console(s) (use no_console_suspend to debug)
>>
>> PM: suspend of devices complete after 123.237 msecs
>> PM: late suspend of devices complete after 4.790 msecs
>> PM: noirq suspend of devices complete after 17.415 msecs
>> Disabling non-boot CPUs ...
>> PM: noirq resume of devices complete after 19.764 msecs
>> PM: early resume of devices complete after 3.218 msecs
>> sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 404) to driver Micrel
>> KSZ8041RNLI
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572
>> irq_set_irq_wake+0x9c/0xf8()
>> Unbalanced IRQ 26 wake disable
> Please try "[PATCH] gpio: rcar: Check for irq_set_irq_wake() failures"
> (https://lkml.org/lkml/2015/5/4/396).
>
Thanks for your patch.
I have just patched this patch at v4.1-rc2 then re-test PM.
This problem is fixed with this patch.

Jinso/Hiep.

