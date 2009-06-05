From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 05 Jun 2009 01:31:10 +0000
Subject: Please apply 7bce6c2740fab3.. to 2.6.30-rc9
Message-Id: <29ab51dc0906041831w1fc20805v6e552862a55cbec0@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Paul.

RTC of the sh7785lcr board of linux-2.6.30-rc8 does not work.
Because 7bce6c2740fab3 ( sh: sh7785lcr: fix I2C device address map for
32-bit mode)
is not taken in by a linus tree.

<snip>
[    1.876111] ata2: SATA link down (SStatus 0 SControl 310)
[    2.260216] rtc-rs5c372 0-0032: can't read registers
[    2.265204] rtc-rs5c372: probe of 0-0032 failed with error -5
[    2.270964] PCA9564/PCA9665 at 0x14000000 registered.
[    2.276287] cpuidle: using governor ladder
<snip>

This works when apply this commitment.
<snip>
[    1.255643] PCA9564/PCA9665 at 0x06000000: Clock frequency is 330kHz
[    1.268084] rtc-rs5c372 0-0032: r2025sd found, am/pm, driver version 0.6
[    1.275179] rtc-rs5c372 0-0032: rtc core: registered rtc-rs5c372 as rtc0
[    1.281914] PCA9564/PCA9665 at 0x06000000 registered.
[    1.287179] cpuidle: using governor ladder
<snip>

Could you apply this commit to 2.6.30-rc9?

Best regards,
 Nobuhiro
-- 
Nobuhiro Iwamatsu
