From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 30 Oct 2015 04:35:16 +0000
Subject: Re: [PATCH v2] i2c: rcar: make sure clocks are on when doing hw init
Message-Id: <1726774.W1OrN54TP1@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1446158791-29682-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1446158791-29682-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Wolfram,

Thank you for the patch.

I'm afraid this doesn't make any noticeable difference. With or without the=
=20
patch applied the adv7511 can't be detected using the latest driver tag=20
(renesas-devel-20151026-v4.3-rc7).

However, I have a bit more information to report.

First of all, I got one kernel panic.

[    9.596439] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    9.603252] [drm] No driver support for vblank timestamp query.
[    9.609724] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    9.616106] adv7180 2-0020: chip found @ 0x20 (e6530000.i2c)
[    9.632980] rcar_thermal e61f0000.thermal: 1 sensor probed
[    9.641533] Unable to handle kernel paging request at virtual address=20
ffffffff
[    9.648927] pgd =3D eb2adf40
[    9.651695] [ffffffff] *pgd=80000040007003, *pmdkfde003, *pte=00000000
[    9.658579] Internal error: Oops: a07 [#1] SMP ARM
[    9.663475] Modules linked in: rcar_thermal adv7180(+) phy_rcar_gen2=20
soundcore udc_core
[    9.671719] CPU: 0 PID: 552 Comm: udevd Not tainted 4.3.0-rc7-07332-
gfb990fd3ff96 #114
[    9.679811] Hardware name: Generic R8A7791 (Flattened Device Tree)
[    9.686125] task: eb11f400 ti: ea92e000 task.ti: ea92e000
[    9.691653] PC is at rcar_i2c_irq+0xd4/0x3e4
[    9.696018] LR is at rcar_i2c_write+0x28/0x38
[    9.700471] pc : [<c0324588>]    lr : [<c0323cf0>]    psr: 80000193
[    9.700471] sp : ea92fea8  ip : ea92fe88  fp : ea92fecc
[    9.712200] r10: 00000000  r9 : c067f37c  r8 : 00000000
[    9.717538] r7 : 00000000  r6 : ea92db38  r5 : 00000000  r4 : eb223c10
[    9.724206] r3 : 00000000  r2 : ffffffff  r1 : 00000000  r0 : eb223c10
[    9.730877] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t=20
user
[    9.738260] Control: 30c5387d  Table: 6b2adf40  DAC: fffffffd
[    9.744131] Process udevd (pid: 552, stack limit =3D 0xea92e210)
[    9.750090] Stack: (0xea92fea8 to 0xea930000)
[    9.754543] fea0:                   c0121368 c011cdfc eb1f9b90 eb21cc40 =

eb1d4220 00000068
[    9.762903] fec0: ea92ff0c ea92fed0 c00727bc c03244c0 ea886198 00000101 =

eada6e90 eb1d41c0
[    9.771263] fee0: 00000000 eb1d41c0 eb1d4220 00000000 00000000 eb00a800 =

00000003 f0803000
[    9.779622] ff00: ea92ff2c ea92ff10 c0072a24 c0072760 00000000 eb1d41c0 =

c0656484 00000000
[    9.787981] ff20: ea92ff4c ea92ff30 c0075e40 c00729c0 c0075d80 00000068 =

c06361f0 00000000
[    9.796339] ff40: ea92ff5c ea92ff50 c0071fd0 c0075d8c ea92ff84 ea92ff60 =

c007211c c0071fb4
[    9.804697] ff60: ea92ffb0 f0802000 f080200c c063cd10 c0656480 ea92ffb0 =

ea92ffac ea92ff88
[    9.813055] ff80: c000a4a0 c00720c4 0000f948 80000010 ffffffff 30c5387d =

30c5387d 00000004
[    9.821414] ffa0: 00000000 ea92ffb0 c0015dc8 c000a45c 00000004 0001fabc =

00000004 0002d00c
[    9.829773] ffc0: 000003ef 000419be bec86de8 00041168 00032060 00000003 =

00000004 000419bf
[    9.838132] ffe0: 00000018 bec86dc0 0000f97c 0000f948 80000010 ffffffff =

ea92fff4 00000000
[    9.846488] Backtrace:=20
[    9.849010] [<c03244b4>] (rcar_i2c_irq) from [<c00727bc>]=20
(handle_irq_event_percpu+0x68/0x260)
[    9.857810]  r6:00000068 r5:eb1d4220 r4:eb21cc40
[    9.862560] [<c0072754>] (handle_irq_event_percpu) from [<c0072a24>]=20
(handle_irq_event+0x70/0x94)
[    9.871626]  r10:f0803000 r9:00000003 r8:eb00a800 r7:00000000 r6:0000000=
0=20
r5:eb1d4220
[    9.879675]  r4:eb1d41c0
[    9.882278] [<c00729b4>] (handle_irq_event) from [<c0075e40>]=20
(handle_fasteoi_irq+0xc0/0x1c0)
[    9.890990]  r6:00000000 r5:c0656484 r4:eb1d41c0 r3:00000000
[    9.896812] [<c0075d80>] (handle_fasteoi_irq) from [<c0071fd0>]=20
(generic_handle_irq+0x28/0x38)
[    9.905612]  r6:00000000 r5:c06361f0 r4:00000068 r3:c0075d80
[    9.911433] [<c0071fa8>] (generic_handle_irq) from [<c007211c>]=20
(__handle_domain_irq+0x64/0xc4)
[    9.920327] [<c00720b8>] (__handle_domain_irq) from [<c000a4a0>]=20
(gic_handle_irq+0x50/0x98)
[    9.928860]  r8:ea92ffb0 r7:c0656480 r6:c063cd10 r5:f080200c r4:f0802000=
=20
r3:ea92ffb0
[    9.936824] [<c000a450>] (gic_handle_irq) from [<c0015dc8>]=20
(__irq_usr+0x48/0x60)
[    9.944471] Exception stack(0xea92ffb0 to 0xea92fff8)
[    9.949632] ffa0:                                     00000004 0001fabc =

00000004 0002d00c
[    9.957991] ffc0: 000003ef 000419be bec86de8 00041168 00032060 00000003 =

00000004 000419bf
[    9.966349] ffe0: 00000018 bec86dc0 0000f97c 0000f948 80000010 ffffffff
[    9.973105]  r10:00000004 r8:30c5387d r7:30c5387d r6:ffffffff r5:8000001=
0=20
r4:0000f948
[    9.981158] Code: e5962008 e5941000 e5911024 f57ff04f (e7c21003)=20
[    9.987389] ---[ end trace 4f04837ce7816c01 ]---
[    9.992107] Kernel panic - not syncing: Fatal exception in interrupt
[    9.998603] CPU1: stopping
[   10.001380] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.3.=
0-
rc7-07332-gfb990fd3ff96 #114
[   10.010893] Hardware name: Generic R8A7791 (Flattened Device Tree)
[   10.017207] Backtrace:=20
[   10.019729] [<c0014b94>] (dump_backtrace) from [<c0014eac>]=20
(show_stack+0x20/0x24)
[   10.027466]  r6:c067f2c8 r5:00000001 r4:00000000 r3:00000000
[   10.033297] [<c0014e8c>] (show_stack) from [<c01df344>]=20
(dump_stack+0x8c/0xc0)
[   10.040686] [<c01df2b8>] (dump_stack) from [<c0018410>]=20
(handle_IPI+0x1b8/0x2dc)
[   10.048245]  r4:c0689430 r3:eb0ec000
[   10.051920] [<c0018258>] (handle_IPI) from [<c000a4dc>]=20
(gic_handle_irq+0x8c/0x98)
[   10.059656]  r10:f0803000 r9:c063c4e8 r8:eb0edf50 r7:c0656480 r6:c063cd1=
0=20
r5:f080200c
[   10.067706]  r4:f0802000 r3:00000000
[   10.071381] [<c000a450>] (gic_handle_irq) from [<c0015b00>]=20
(__irq_svc+0x40/0x54)
[   10.079029] Exception stack(0xeb0edf50 to 0xeb0edf98)
[   10.084191] df40:                                     00000001 00000000 =

eb0edfb0 c0022e40
[   10.092551] df60: c067f908 c063c49c 00000000 00000000 c0637280 c063c4e8 =

c063c4f0 eb0edfac
[   10.100909] df80: eb0edfb0 eb0edfa0 c0012444 c0012448 60000013 ffffffff
[   10.107665]  r10:c063c4f0 r8:c0637280 r7:eb0edf84 r6:ffffffff r5:6000001=
3=20
r4:c0012448
[   10.115727] [<c0012408>] (arch_cpu_idle) from [<c0067950>]=20
(default_idle_call+0x30/0x3c)
[   10.124001] [<c0067920>] (default_idle_call) from [<c0067bf4>]=20
(cpu_startup_entry+0x238/0x3a0)
[   10.132806] [<c00679bc>] (cpu_startup_entry) from [<c0017fcc>]=20
(secondary_start_kernel+0x154/0x188)
[   10.142050]  r7:c0689458
[   10.144652] [<c0017e78>] (secondary_start_kernel) from [<4000a58c>]=20
(0x4000a58c)
[   10.152211]  r5:00000000 r4:6b0818c0
[   10.155888] ---[ end Kernel panic - not syncing: Fatal exception in=20
interrupt

This only occurred once, I don't know how to reproduce it.

I have also seen different errors:

[    1.177690] i2c-rcar e6530000.i2c: error -16 : 0
[    1.182534] adv7511: probe of 2-0039 failed with error -16
[    1.188293] i2c-rcar e6530000.i2c: probed

-110 occurred as well.

This occurred when rebooting the board by pressing the reset button, and if=
 I=20
remember correctly moving from renesas-devel-20151013v2-v4.3-rc5 to renesas-
devel-20151026-v4.3-rc7. Even though it occurred several times in a row I=20
can't seem to reproduce this issue now I'm afraid.

On Thursday 29 October 2015 23:46:31 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-rcar.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 616433d387cdb2..58dbd30c24d1cc 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -612,7 +612,10 @@ static int rcar_i2c_probe(struct platform_device *pd=
ev)
> if (IS_ERR(priv->io))
>  		return PTR_ERR(priv->io);
>=20
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
>  	rcar_i2c_init(priv);
> +	pm_runtime_put(dev);
>=20
>  	irq =3D platform_get_irq(pdev, 0);
>  	init_waitqueue_head(&priv->wait);
> @@ -631,22 +634,24 @@ static int rcar_i2c_probe(struct platform_device
> *pdev) dev_name(dev), priv);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot get irq %d\n", irq);
> -		return ret;
> +		goto out_pm_disable;
>  	}
>=20
> -	pm_runtime_enable(dev);
>  	platform_set_drvdata(pdev, priv);
>=20
>  	ret =3D i2c_add_numbered_adapter(adap);
>  	if (ret < 0) {
>  		dev_err(dev, "reg adap failed: %d\n", ret);
> -		pm_runtime_disable(dev);
> -		return ret;
> +		goto out_pm_disable;
>  	}
>=20
>  	dev_info(dev, "probed\n");
>=20
>  	return 0;
> +
> + out_pm_disable:
> +	pm_runtime_disable(dev);
> +	return ret;
>  }
>=20
>  static int rcar_i2c_remove(struct platform_device *pdev)

--=20
Regards,

Laurent Pinchart

