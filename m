From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Jul 2015 21:07:32 +0000
Subject: Traceback in -next due to commit 'clockevents/drivers/sh_tmu: Migrate to new 'set-state' interface'
Message-Id: <55AD6314.2050000@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

Commit 991a7f4970ed1 ("clockevents/drivers/sh_tmu: Migrate to new 'set-state' interface")
in -next causes the following traceback. This is seen with qemu runs for the sh target.

------------[ cut here ]------------
WARNING: at drivers/clocksource/sh_tmu.c:202
Modules linked in:

CPU: 0 PID: 0 Comm: swapper Not tainted 4.2.0-rc3-next-20150720 #1
task: 8c411ed8 ti: 8c40e000 task.ti: 8c40e000
PC is at sh_tmu_disable+0x40/0x60
PR is at sh_tmu_clock_event_shutdown+0x8/0x20
PC  : 8c271220 SP  : 8c40ff10 SR  : 400081f1 TEA : 00000000
R0  : 8c271240 R1  : 8fc08cfc R2  : 00000000 R3  : 3fffffff
R4  : 8fc08c00 R5  : 00000001 R6  : 00000002 R7  : ffffffff
R8  : 00000001 R9  : 8fc08c20 R10 : 00000000 R11 : 00000000
R12 : 8c012820 R13 : 00000000 R14 : 00000000
MACH: 3b9ac9ff MACL: 80000000 GBR : 00000000 PR  : 8c271248

Call trace:
  [<8c065836>] clockevents_switch_state+0x16/0x60
  [<8c06588c>] clockevents_shutdown+0xc/0x40
  [<8c066330>] tick_check_new_device+0x90/0xc0
  [<8c065556>] clockevents_register_device+0x56/0x120
  [<8c0662a0>] tick_check_new_device+0x0/0xc0
  [<8c27167a>] sh_tmu_probe+0x29a/0x4e0
  [<8c18a994>] kasprintf+0x14/0x20
  [<8c442782>] early_platform_driver_probe+0x20e/0x2bc
  [<8c1fade0>] platform_match+0x0/0x100
  [<8c33babc>] printk+0x0/0x24
  [<8c434892>] start_kernel+0x32e/0x574
  [<8c33babc>] printk+0x0/0x24
  [<8c17d320>] strlen+0x0/0x58
  [<8c43430c>] unknown_bootoption+0x0/0x1e0
  [<8c011024>] _stext+0x24/0x30

---[ end trace cb88537fdc8fa200 ]---

The traceback is seen since next-20150717.

Bisect log:

# bad: [708e764f2083fde82ce2b4fefa774ac908ed665d] Add linux-next specific files for 20150720
# good: [52721d9d3334c1cb1f76219a161084094ec634dc] Linux 4.2-rc3
git bisect start 'HEAD' 'v4.2-rc3'
# good: [ce8b84b40643831008d499595896070b5ce4f778] Merge remote-tracking branch 'sound/for-next'
git bisect good ce8b84b40643831008d499595896070b5ce4f778
# bad: [0af42a0b7cc76939b251494ee82e0d6f93eb0106] Merge remote-tracking branch 'staging/staging-next'
git bisect bad 0af42a0b7cc76939b251494ee82e0d6f93eb0106
# good: [8a405bb7b1b64e4282fa07360c509bef31cf6c5b] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 8a405bb7b1b64e4282fa07360c509bef31cf6c5b
# good: [f7d8b69a1d6dac9d650714e82390f3b63e2e582f] staging: sm750fb: add space after return type
git bisect good f7d8b69a1d6dac9d650714e82390f3b63e2e582f
# bad: [47720d8ca0f83f1b199a8124600dc734d8897bd1] Merge remote-tracking branch 'rcu/rcu/next'
git bisect bad 47720d8ca0f83f1b199a8124600dc734d8897bd1
# good: [0d4962676c87415f4b50866e229e6ea0087fb822] Merge with e7b4e4728057 (Make checkpatch.pl warn on expedited RCU grace periods)
git bisect good 0d4962676c87415f4b50866e229e6ea0087fb822
# bad: [991a7f4970ed1feb87592cd071b710a51b7dc257] clockevents/drivers/sh_tmu: Migrate to new 'set-state' interface
git bisect bad 991a7f4970ed1feb87592cd071b710a51b7dc257
# good: [ac8c525b4f4b719a29d5fbb37f6f5ba0d4e1f45f] clockevents/drivers/dw_apb: Migrate to new 'set-state' interface
git bisect good ac8c525b4f4b719a29d5fbb37f6f5ba0d4e1f45f
# good: [4cdc371d1c8015dbd6674f12d491ff07dc70243d] clockevents/drivers/mxs: Migrate to new 'set-state' interface
git bisect good 4cdc371d1c8015dbd6674f12d491ff07dc70243d
# good: [205e230e472b40c3cd13c70578484253aaebfbcb] clockevents/drivers/rockchip: Migrate to new 'set-state' interface
git bisect good 205e230e472b40c3cd13c70578484253aaebfbcb
# good: [7883df11f568723ae080ba0766dfeaa46a314ecc] clockevents/drivers/sh_cmt: Migrate to new 'set-state' interface
git bisect good 7883df11f568723ae080ba0766dfeaa46a314ecc
# good: [312dace1f7a4b039ccaff020fd14b865b591384f] clockevents/drivers/sh_mtu2: Migrate to new 'set-state' interface
git bisect good 312dace1f7a4b039ccaff020fd14b865b591384f
# first bad commit: [991a7f4970ed1feb87592cd071b710a51b7dc257] clockevents/drivers/sh_tmu: Migrate to new 'set-state' interface

Guenter
