From: deepaksi <deepak.sikri@st.com>
Date: Fri, 15 Apr 2011 05:56:54 +0000
Subject: [linux-pm] SPEAR Power Management: Suspend to ram problem
Message-Id: <4DA7DB56.4070307@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@lists.linux-foundation.org
Cc: Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Amit GOEL <amit.goel@st.com>, Armando VISCONTI <armando.visconti@st.com>, deepaksi <deepak.sikri@st.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, deepak.sikri79@gmail.com


Hi,
I am facing some issues related to system wake up  from the sleep.
The SPEAr system is a SOC having the ARM cortex core.
The system hardware has certain power islands, and all islands except the
 one having the wake up sources and Power Management Controller are made
 off, while moving into sleep.

On waking up from Suspend to RAM, I get the following log on the console
( the debugger
 shows, all the devices are up and some user space processes are being
run, which execute
a system call before crash).

PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: suspend of devices complete after 2.857 msecs
PM: late suspend of devices complete after 0.970 msecs
PM: early resume of devices complete after 0.671 msecs
usb usb3: root hub lost power or was reset
usb usb4: root hub lost power or was reset
PM: resume of devices complete after 30.735 msecs
Restarting tasks ... done.
Kernel panic - not syncing: Attempted to kill init!
Backtrace:
[<80031b30>] (dump_backtrace+0x0/0x10c) from [<80031c70>]
(dump_stack+0x18/0x1c)
 r7:0000000b r6:0000000b r5:8f828000 r4:803b90e8
[<80031c58>] (dump_stack+0x0/0x1c) from [<8004266c>] (panic+0x60/0x17c)
[<8004260c>] (panic+0x0/0x17c) from [<80045800>] (do_exit+0x68/0x5f0)
 r3:8038d3c0 r2:8f828000 r1:8f8280fc r0:80331eaa
[<80045798>] (do_exit+0x0/0x5f0) from [<80045e20>] (do_group_exit+0x98/0xc8)
[<80045d88>] (do_group_exit+0x0/0xc8) from [<80050eec>]
(get_signal_to_deliver+0x310/0x350)
 r7:8f82a000 r6:8f82bee0 r5:8f91259c r4:0000000b
[<80050bdc>] (get_signal_to_deliver+0x0/0x350) from [<800309a0>]
(do_notify_resume+0x70/0x62c)
[<80030930>] (do_notify_resume+0x0/0x62c) from [<8002dd98>]
(work_pending+0x24/0x28)


Could any one help in debugging the same ?

Deepak
