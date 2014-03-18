From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 18 Mar 2014 21:48:18 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <5328CD29.4080207@cogentembedded.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070305010406070709050709"
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------070305010406070709050709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 03/18/2014 11:45 PM, Laurent Pinchart wrote:

>>>>>>> I have yet to ascertain how this ends up happening with device probe,
>>>>>>> it seems to be very dependant on the code.

>>>>>> Adding a WARN() in cpg_mstp_clock_endisable():
>> [...]

>>>>> this explains it, the call to stats causes a get_sync/put_sync which
>>>>> puts the device into a state where it /could/ be suspended and thus
>>>>> does get suspended in this case from the pm code.

>>>>> I'm not /sure/ why the pm_runtime code is not protecting against
>>>>> running this when a device probe is in progress, but it seems the
>>>>> best thing is to ensure that we always do a get/put sync in the
>>>>> driver to ensure we have a reference during probe.

>>>> Wouldn't it be better to register the MDIO bus before registering the
>>>> network device ? It looks like the current order is prone to race
>>>> conditions.

>>> Not sure, requires input?

>> People say that the driver should be ready to receive the ndo_open() method
>> call even before register_netdev() returns. I have prepared the patch to
>> probe MDIO before calling register_netdev() now, need to sanity test it.

> Thank you.

    Not at all, actually. I've probvably missed something subtle in the 
mdiobus_register() call chain, and so hilarity ensued when I booted:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at include/linux/kref.h:47 kobject_get+0x50/0x68()
CPU: 0 PID: 1 Comm: swapper Tainted: G        W    3.14.0-rc7-dirty #339
Backtrace:
[<c0010804>] (dump_backtrace) from [<c00109a0>] (show_stack+0x18/0x1c)
  r6:c03eedcb r5:00000009 r4:00000000 r3:00204140
[<c0010988>] (show_stack) from [<c0355c14>] (dump_stack+0x20/0x28)
[<c0355bf4>] (dump_stack) from [<c001c19c>] (warn_slowpath_common+0x68/0x88)
[<c001c134>] (warn_slowpath_common) from [<c001c294>] 
(warn_slowpath_null+0x24/0x2c)
  r8:eeca2a10 r7:ee7fd440 r6:ee7fd448 r5:c04791d7 r4:eeda8258
[<c001c270>] (warn_slowpath_null) from [<c015f474>] (kobject_get+0x50/0x68)
[<c015f424>] (kobject_get) from [<c01c6f68>] (get_device+0x1c/0x24)
  r5:00000000 r4:ee7fd440
[<c01c6f4c>] (get_device) from [<c01c706c>] (device_add+0xc4/0x510)
[<c01c6fa8>] (device_add) from [<c01c74d4>] (device_register+0x1c/0x20)
  r10:ee7fd400 r8:eeca2a10 r7:ee7fd440 r6:ef2058e8 r5:ee7fd404 r4:ee7fd440
[<c01c74b8>] (device_register) from [<c021150c>] (mdiobus_register+0x84/0x168)
  r4:ee7fd400 r3:00000000
[<c0211488>] (mdiobus_register) from [<c028cb64>] (of_mdiobus_register+0x3c/0x1ac)
  r8:eeca2a10 r7:eeda8250 r6:ef2058e8 r5:ee7ec690 r4:ee7fd400 r3:00000080
[<c028cb28>] (of_mdiobus_register) from [<c021410c>] 
(sh_eth_drv_probe+0x9f4/0xb58)
  r10:ee7fd400 r9:ffffffff r8:eeca2a10 r7:eeda8250 r6:eeca2a10 r5:ee7ec690
  r4:eeda8000
[<c0213718>] (sh_eth_drv_probe) from [<c01cb6e8>] (platform_drv_probe+0x20/0x50)
  r10:c044779c r9:00000000 r8:c043ccd0 r7:c01ca5d4 r6:c04706bc r5:c04706bc
  r4:eeca2a10
[<c01cb6c8>] (platform_drv_probe) from [<c01ca480>] 
(driver_probe_device+0xbc/0x210)
  r5:00000000 r4:eeca2a10
[<c01ca3c4>] (driver_probe_device) from [<c01ca644>] (__driver_attach+0x70/0x94)
  r6:c04706bc r5:eeca2a44 r4:eeca2a10 r3:00000000
[<c01ca5d4>] (__driver_attach) from [<c01c8bf4>] (bus_for_each_dev+0x5c/0x98)
  r6:c04706bc r5:eec4de40 r4:00000000 r3:c01ca5d4
[<c01c8b98>] (bus_for_each_dev) from [<c01ca1c8>] (driver_attach+0x20/0x28)
  r7:c046d680 r6:00000000 r5:ee7f1500 r4:c04706bc
[<c01ca1a8>] (driver_attach) from [<c01c93c4>] (bus_add_driver+0xc8/0x1c8)
[<c01c92fc>] (bus_add_driver) from [<c01caccc>] (driver_register+0xa4/0xe8)
  r7:c0479280 r6:c044f56c r5:c0447790 r4:c04706bc
[<c01cac28>] (driver_register) from [<c01cbee8>] 
(__platform_driver_register+0x50/0x64)
  r5:c0447790 r4:00000006
[<c01cbe98>] (__platform_driver_register) from [<c043cce8>] 
(sh_eth_driver_init+0x18/0x20)
[<c043ccd0>] (sh_eth_driver_init) from [<c042ab18>] (do_one_initcall+0x9c/0x140)
[<c042aa7c>] (do_one_initcall) from [<c042acac>] (kernel_init_freeable+0xf0/0x1b8)
  r10:c044779c r9:00000000 r8:00000083 r7:c0479280 r6:c044f56c r5:c0447790
  r4:00000006
[<c042abbc>] (kernel_init_freeable) from [<c0353144>] (kernel_init+0x14/0xec)
  r10:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0353130 r4:c0479280
[<c0353130>] (kernel_init) from [<c000de78>] (ret_from_fork+0x14/0x3c)
  r4:00000000 r3:00000000
---[ end trace 3406ff24bd97382f ]---
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
pgd = c0004000
[0000000c] *pgd=00000000
Internal error: Oops: 5 [#1] ARM
CPU: 0 PID: 1 Comm: swapper Tainted: G        W    3.14.0-rc7-dirty #339
task: eec30b80 ti: eec4c000 task.ti: eec4c000
PC is at kobj_child_ns_ops+0x18/0x34
LR is at kobj_ns_ops+0x14/0x18
pc : [<c015f7ec>]    lr : [<c015f81c>]    psr: a0000153
sp : eec4dc40  ip : eec4dc50  fp : eec4dc4c
r10: ee7fd400  r9 : ffffffff  r8 : eeca2a10
r7 : c046fe7c  r6 : eeda8258  r5 : 00000000  r4 : ee7ec5c0
r3 : 00000000  r2 : eed03ac4  r1 : ee7ec5c4  r0 : eeda8258
Flags: NzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 40004059  DAC: 00000015
Process swapper (pid: 1, stack limit = 0xeec4c238)
Stack: (0xeec4dc40 to 0xeec4e000)
dc40: eec4dc5c eec4dc50 c015f81c c015f7e0 eec4dc74 eec4dc60 c015f834 c015f814
dc60: eed03ac4 ee7ec5c0 eec4dcac eec4dc78 c015f910 c015f82c 00000000 00000000
dc80: eec4dcac eec4dc90 ee7ec5c0 00000000 eeda8258 c046fe7c eeca2a10 ee7fd400
dca0: eec4dcd4 eec4dcb0 c015fc4c c015f868 eec4dcd4 eec4dcdc c001c294 00000000
dcc0: ee7ec5c0 eeda8258 eec4dcfc eec4dce0 c01c6e54 c015fbe8 c03f2cf2 c040d158
dce0: ee7fd440 00000000 ee7fd448 eeda8250 eec4dd34 eec4dd00 c01c707c c01c6d68
dd00: c01d38e4 c003f4ec 00000020 ee7fd440 ee7fd440 ee7fd404 ef2058e8 ee7fd440
dd20: eeca2a10 ee7fd400 eec4dd4c eec4dd38 c01c74d4 c01c6fb4 00000000 ee7fd400
dd40: eec4dd74 eec4dd50 c021150c c01c74c4 00000080 ee7fd400 ee7ec690 ef2058e8
dd60: eeda8250 eeca2a10 eec4ddac eec4dd78 c028cb64 c0211494 c01cca9c c01cc770
dd80: c01cc738 eeda8000 ee7ec690 eeca2a10 eeda8250 eeca2a10 ffffffff ee7fd400
dda0: eec4dde4 eec4ddb0 c021410c c028cb34 ffffffff 00000000 c01ca5d4 eeca2a10
ddc0: c04706bc c04706bc c01ca5d4 c043ccd0 00000000 c044779c eec4ddfc eec4dde8
dde0: c01cb6e8 c0213724 eeca2a10 00000000 eec4de1c eec4de00 c01ca480 c01cb6d4
de00: 00000000 eeca2a10 eeca2a44 c04706bc eec4de3c eec4de20 c01ca644 c01ca3d0
de20: c01ca5d4 00000000 eec4de40 c04706bc eec4de64 eec4de40 c01c8bf4 c01ca5e0
de40: eec2fe4c eec995b0 c04706bc ee7f1500 00000000 c046d680 eec4de74 eec4de68
de60: c01ca1c8 c01c8ba4 eec4de9c eec4de78 c01c93c4 c01ca1b4 c040d672 eec4de88
de80: c04706bc c0447790 c044f56c c0479280 eec4deb4 eec4dea0 c01caccc c01c9308
dea0: 00000006 c0447790 eec4dec4 eec4deb8 c01cbee8 c01cac34 eec4ded4 eec4dec8
dec0: c043cce8 c01cbea4 eec4df54 eec4ded8 c042ab18 c043ccdc eec4df04 eec4dee8
dee0: c00de144 ef201db7 eec4df00 eec4def8 c042a4e8 c0162c3c ef201db7 ef201dba
df00: eec4df54 eec4df10 c003284c c042a4d8 00000000 c0428600 00000006 00000006
df20: 00000083 c0427dd0 eec4df54 00000006 c0447790 c044f56c c0479280 00000083
df40: 00000000 c044779c eec4df94 eec4df58 c042acac c042aa88 00000006 00000006
df60: c042a4cc fd2bef9f 75ff2fd1 05a3f498 c0479280 c0353130 00000000 00000000
df80: 00000000 00000000 eec4dfac eec4df98 c0353144 c042abc8 00000000 00000000
dfa0: 00000000 eec4dfb0 c000de78 c035313c 00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 f7df77e1 9dbd73f4
Backtrace:
[<c015f7d4>] (kobj_child_ns_ops) from [<c015f81c>] (kobj_ns_ops+0x14/0x18)
[<c015f808>] (kobj_ns_ops) from [<c015f834>] (kobject_namespace+0x14/0x3c)
[<c015f820>] (kobject_namespace) from [<c015f910>] 
(kobject_add_internal+0xb4/0x294) 

  r4:ee7ec5c0 r3:eed03ac4
[<c015f85c>] (kobject_add_internal) from [<c015fc4c>] (kobject_add+0x74/0x94)
  r10:ee7fd400 r8:eeca2a10 r7:c046fe7c r6:eeda8258 r5:00000000 r4:ee7ec5c0
[<c015fbdc>] (kobject_add) from [<c01c6e54>] (get_device_parent+0xf8/0x154)
  r3:c040d158 r2:c03f2cf2
  r6:eeda8258 r5:ee7ec5c0 r4:00000000
[<c01c6d5c>] (get_device_parent) from [<c01c707c>] (device_add+0xd4/0x510)
  r7:eeda8250 r6:ee7fd448 r5:00000000 r4:ee7fd440
[<c01c6fa8>] (device_add) from [<c01c74d4>] (device_register+0x1c/0x20)
  r10:ee7fd400 r8:eeca2a10 r7:ee7fd440 r6:ef2058e8 r5:ee7fd404 r4:ee7fd440
[<c01c74b8>] (device_register) from [<c021150c>] (mdiobus_register+0x84/0x168)
  r4:ee7fd400 r3:00000000
[<c0211488>] (mdiobus_register) from [<c028cb64>] (of_mdiobus_register+0x3c/0x1ac)
  r8:eeca2a10 r7:eeda8250 r6:ef2058e8 r5:ee7ec690 r4:ee7fd400 r3:00000080
[<c028cb28>] (of_mdiobus_register) from [<c021410c>] 
(sh_eth_drv_probe+0x9f4/0xb58)
  r10:ee7fd400 r9:ffffffff r8:eeca2a10 r7:eeda8250 r6:eeca2a10 r5:ee7ec690
  r4:eeda8000
[<c0213718>] (sh_eth_drv_probe) from [<c01cb6e8>] (platform_drv_probe+0x20/0x50)
  r10:c044779c r9:00000000 r8:c043ccd0 r7:c01ca5d4 r6:c04706bc r5:c04706bc
  r4:eeca2a10
[<c01cb6c8>] (platform_drv_probe) from [<c01ca480>] 
(driver_probe_device+0xbc/0x210)
  r5:00000000 r4:eeca2a10
[<c01ca3c4>] (driver_probe_device) from [<c01ca644>] (__driver_attach+0x70/0x94)
  r6:c04706bc r5:eeca2a44 r4:eeca2a10 r3:00000000
[<c01ca5d4>] (__driver_attach) from [<c01c8bf4>] (bus_for_each_dev+0x5c/0x98)
  r6:c04706bc r5:eec4de40 r4:00000000 r3:c01ca5d4
[<c01c8b98>] (bus_for_each_dev) from [<c01ca1c8>] (driver_attach+0x20/0x28)
  r7:c046d680 r6:00000000 r5:ee7f1500 r4:c04706bc
[<c01ca1a8>] (driver_attach) from [<c01c93c4>] (bus_add_driver+0xc8/0x1c8)
[<c01c92fc>] (bus_add_driver) from [<c01caccc>] (driver_register+0xa4/0xe8)
  r7:c0479280 r6:c044f56c r5:c0447790 r4:c04706bc
[<c01cac28>] (driver_register) from [<c01cbee8>] 
(__platform_driver_register+0x50/0x64)
  r5:c0447790 r4:00000006
[<c01cbe98>] (__platform_driver_register) from [<c043cce8>] 
(sh_eth_driver_init+0x18/0x20)
[<c043ccd0>] (sh_eth_driver_init) from [<c042ab18>] (do_one_initcall+0x9c/0x140)
[<c042aa7c>] (do_one_initcall) from [<c042acac>] (kernel_init_freeable+0xf0/0x1b8
  r10:c044779c r9:00000000 r8:00000083 r7:c0479280 r6:c044f56c r5:c0447790
  r4:00000006
[<c042abbc>] (kernel_init_freeable) from [<c0353144>] (kernel_init+0x14/0xec)
  r10:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0353130 r4:c0479280
[<c0353130>] (kernel_init) from [<c000de78>] (ret_from_fork+0x14/0x3c)
  r4:00000000 r3:00000000
Code: e24cb004 e2503000 0a000005 e5933014 (e593300c)
---[ end trace 3406ff24bd973830 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

    This looks rather hopeless to me. I'm attaching the patch just in case, 
it's against renesas-devel-v3.14-rc7-20140318.

>>>> Another potential issue, does the network layer guarantee that the device
>>>> will always be opened by an .ndo_open() call before performing any MDIO
>>>> operation ? sh_mmd_ctrl, sh_set_mdio and sh_get_mdio access sh-eth
>>>> registers, could we be missing runtime PM calls in those call paths ?

>>> I'm not sure if there is any guarantee, I don't think the PHY driver
>>> does any sort of open on probe. I do have a patch to ensure that the
>>> MDIO operations are wrapped with pm_runtime_{get,put}_sync() calls as
>>> the probe of the PHY often fails without it.

>> Respin this patch please (addressing my comments), so that DaveM could take
>> it.

> Before wrapping MDIO operations in runtime PM calls, could we check whether
> that's really needed ? Moving PHY registration before network device
> registration will fix PHY probe problems, we might not need any other change.

    There's also sh_eth_do_ioctl() that calls phy_mii_ioctl() which does PHY 
reads/writes. Although the device probably needs to be opened first.
Anyway, looks like we do need that Ben's patch or something alike -- maybe 
another RPM resume in sh_mdio_init()...

WBR, Sergei


--------------070305010406070709050709
Content-Type: text/x-patch;
 name="sh_eth-fix-MDIO-probing-vs-open-race.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sh_eth-fix-MDIO-probing-vs-open-race.patch"

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |   35 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

Index: renesas/drivers/net/ethernet/renesas/sh_eth.c
===================================================================
--- renesas.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ renesas/drivers/net/ethernet/renesas/sh_eth.c
@@ -2615,9 +2615,10 @@ static int sh_mdio_init(struct net_devic
 	int ret, i;
 	struct bb_info *bitbang;
 	struct sh_eth_private *mdp = netdev_priv(ndev);
+	struct platform_device *pdev = mdp->pdev;
 
 	/* create bit control struct for PHY */
-	bitbang = devm_kzalloc(&ndev->dev, sizeof(struct bb_info),
+	bitbang = devm_kzalloc(&pdev->dev, sizeof(struct bb_info),
 			       GFP_KERNEL);
 	if (!bitbang) {
 		ret = -ENOMEM;
@@ -2644,10 +2645,10 @@ static int sh_mdio_init(struct net_devic
 	mdp->mii_bus->name = "sh_mii";
 	mdp->mii_bus->parent = &ndev->dev;
 	snprintf(mdp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
-		 mdp->pdev->name, id);
+		 pdev->name, id);
 
 	/* PHY IRQ */
-	mdp->mii_bus->irq = devm_kzalloc(&ndev->dev,
+	mdp->mii_bus->irq = devm_kzalloc(&pdev->dev,
 					 sizeof(int) * PHY_MAX_ADDR,
 					 GFP_KERNEL);
 	if (!mdp->mii_bus->irq) {
@@ -2655,10 +2656,9 @@ static int sh_mdio_init(struct net_devic
 		goto out_free_bus;
 	}
 
-	/* register mdio bus */
-	if (ndev->dev.parent->of_node) {
-		ret = of_mdiobus_register(mdp->mii_bus,
-					  ndev->dev.parent->of_node);
+	/* register MDIO bus */
+	if (pdev->dev.of_node) {
+		ret = of_mdiobus_register(mdp->mii_bus, pdev->dev.of_node);
 	} else {
 		for (i = 0; i < PHY_MAX_ADDR; i++)
 			mdp->mii_bus->irq[i] = PHY_POLL;
@@ -2904,6 +2904,13 @@ static int sh_eth_drv_probe(struct platf
 		}
 	}
 
+	/* MDIO bus init */
+	ret = sh_mdio_init(ndev, pdev->id, pd);
+	if (ret) {
+		dev_err(&ndev->dev, "failed to initialise MDIO\n");
+		goto out_release;
+	}
+
 	netif_napi_add(ndev, &mdp->napi, sh_eth_poll, 64);
 
 	/* network device register */
@@ -2911,13 +2918,6 @@ static int sh_eth_drv_probe(struct platf
 	if (ret)
 		goto out_napi_del;
 
-	/* mdio bus init */
-	ret = sh_mdio_init(ndev, pdev->id, pd);
-	if (ret) {
-		dev_err(&ndev->dev, "failed to initialise MDIO\n");
-		goto out_unregister;
-	}
-
 	/* print device information */
 	pr_info("Base address at 0x%x, %pM, IRQ %d.\n",
 		(u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
@@ -2926,12 +2926,11 @@ static int sh_eth_drv_probe(struct platf
 
 	return ret;
 
-out_unregister:
-	unregister_netdev(ndev);
-
 out_napi_del:
 	netif_napi_del(&mdp->napi);
 
+	sh_mdio_release(ndev);
+
 out_release:
 	/* net_dev free */
 	if (ndev)
@@ -2946,9 +2945,9 @@ static int sh_eth_drv_remove(struct plat
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 
-	sh_mdio_release(ndev);
 	unregister_netdev(ndev);
 	netif_napi_del(&mdp->napi);
+	sh_mdio_release(ndev);
 	pm_runtime_disable(&pdev->dev);
 	free_netdev(ndev);
 

--------------070305010406070709050709--
