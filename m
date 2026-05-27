Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011066.outbound.protection.outlook.com [52.101.125.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD3385D86;
	Wed, 27 May 2026 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864352; cv=fail; b=chM6Q+IaTxP9RTns1p9LUKXqAMuXHICnJ59D6Evi/BbzgV1hsA7eamZoqLCLtF9L/Y5+ix1IvcFB1Xlea51NvcEHnJXUgZbkhvINJ7GHw8aP7FZLY4x4LzG5PKSO7Dz5iS0BrA44QCID6fUOFNRhroamMCI/euR855iWBN7ZP/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864352; c=relaxed/simple;
	bh=j/IVKWkCCBzCTMRVOgmy5RRp5Vuzg4OeN4ijvUDBdPY=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=t8yQn9Y4c4fwRfC4qcpY4QuGGRGdvPopXp5PkSBTsdiJ0+AtRI2iA/BTPEjZWblOqUcrxzEiICUFq7ETc8pHGhX16l4wkxFLjZHq1w3eVA3It4w3oKHCpBVIHPJI7avWyP5jnems2HeC/NqxkeTgKOLAupsZZtw6V087to3BQpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=gf5J8HmI; arc=fail smtp.client-ip=52.101.125.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="gf5J8HmI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdSljjNiw+NPZAq+LC5Vmiougqq0Dwn/BEn7Psdw/VKeNrhTHpnVAUCT7iOvGngK+6EKnSvL5u594RlbmsBwWc5W4M3nabRsIfTMy6YvpxUOBEOWgw+pnSxunMZ73Z1iuRuiycSTdNv7ftjcLaI/HJKztRciHoJNUF898WBemm3zrS5ODyuLWKazWqszafbiXp69M+SyfdOIw+VvRYNByobpyfapJEnp2S+LAYuQiwmwYObSoQQLCsREU05Pb3jlJv7vSviDqAyaRLWeAdKvuFF+HxmhTm0yWk2FzHJGFYkotGwEt958ITWGucbG3rIV8G84etXSzfrJiut4UBK6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwjOJSt+kWLBqkzbH7rUeVFNfmMf6xmnQ+PMxW++XuY=;
 b=PYnjH9duUbq6YPyf2cNutScA5igKyhqtQKq6jLaCU3XFoiU3i6Mt5ThHdE0o6kww9MkBceRIVNBcO6cGYPlyL7A5bpcsASlIJx7k1FPLsLX4pWbCL0x4dZEHoOCCN0RCWX4aeZBC8qEvbxke5eqaoscnQysM+hB4xSTI3CWOZsSbeCiXblWQCCEOffJ7mo+ezKl/e/uXLMn5tMpE4u9lZYuzYiYBNvIvHmsS1JcYiNzdt+Y8X+2nhb6kW5bNDN2LpLEqdykD4/nYjiM2gS15cX9ETwImVu3N9InUxaQATiLTA6hNuxVHprOaKtcfqqcaBu5smqBWJq8yq/u26y5efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwjOJSt+kWLBqkzbH7rUeVFNfmMf6xmnQ+PMxW++XuY=;
 b=gf5J8HmILHXFjUFrbzoWiSRSISYFErCd93l56EzuuTKXHDVJhN8GKkN5HdzUQCq4V58hsJRmVbXCQim3b8DsxVEwtXP5n0a2OIo/BiW2lxfglCaDN2l24i7lvTFn6UYSDaF0j40sFFowdCxB3MGaTPN+ytc85CnQrFy/S6n2thc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TY4PR01MB13430.jpnprd01.prod.outlook.com (2603:1096:405:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 06:45:47 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 06:45:47 +0000
Message-ID: <87wlwpe4f9.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 2/3] sh: 7724se: remove FSI/AK4642/Simple-Audio-Card support
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Takashi Iwai <tiwai@suse.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org
In-Reply-To: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
References: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 27 May 2026 06:45:47 +0000
X-ClientProxiedBy: TYCP301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::19) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TY4PR01MB13430:EE_
X-MS-Office365-Filtering-Correlation-Id: 7072c6eb-bf66-4ff2-d57f-08debbbb9561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CdSiXC2WgoytMVXIv5Uu61YtfjfG+AXSU0ugUpechHJ+FeXpwZhwMbiFtSLdTquQI3vHJSdvSkY2V7WCeHRLFAEH2lAcbhrgDKoap6xzDD1wLKP68WAYvYCTRTK76+q0pxT9qQtTXSjdniRBqPBwOLOJsYpL3fa7lAWVjF0wTrMY2yn00TfVIR/2eJCf/EbC2x8w+c4QyYSDvLfZodTJpLBTwh2sWoDHOB0uscwaVrrgcRf+EUrDvzEzcNEMzx9l+wREtUQ0CF5WDTr63KJYXEnJvXvVA/55CzQQqc8cGX8rfpLQXF68dzqFR58f3/TbsaCrsoTNii+XMQoQKfllnnHF1fmhSTnMa736nNf5ruWQjePVf+9daGGsu6QXtnj19Q2OZnDM7s74zttYy/BlFszbu5u4RAQlHvDdEzjJ7dCgkq+oUaf8R6xhi2h4sGR6yyocfYaxJC6wikrVa4ASUOF9ZVJP9g0tjHTt0NNA2OK1OnmmkW+UYv4zVzHrI+xhxJFpIO0kmlpnssTdYR9rIKZl25ytu7dwWiC3oBCACyTVm6rXHaI2yxIeddFTSVCtUL95QMaBcgr7JuoPMYLWUYqAIGS4m8hpP7kkGeGc4UBJ/V/hgytssK4lDpofkx50usOctHuheUYomEmHbfA0LSKLIESalCpNq7X31JlwJrDorsshrG7TzP1xUNzv98TnMqshSIPoaKLAOjKQ+3RnUseu3wDa/1okomxrvXr04bHrtZC8vEJ7zhtFCFeOAQO6EujPATkxohu9EmwHFnY60w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rt7Ar8PSpRUnFKInL5FBK6n9zQXd3/ZOcUac0MpSSQzh49z7KQUoNyt87Mk+?=
 =?us-ascii?Q?JBjCIKegorzsApjHstCa/MNBHqZcP1SemEgydVtmUTNMe7DkBgIUefdvcYES?=
 =?us-ascii?Q?w1kEsbsYxwZSqaxf5scCR/DGAQwO/2WvZxYEk/uXI3p032QuyxbYRspH6G+e?=
 =?us-ascii?Q?V3ehnwjlq5as6iK887vLgKROlviZh3eevvjmA2QfKEQwboHgYygUKsI5A9uB?=
 =?us-ascii?Q?0wwZ0ImMhZY0/E4MHPADydXWFCFzVnEeZDIP3WjDoCQRb4CoGAPu4F/TmJYM?=
 =?us-ascii?Q?odazADKP23hPwp5JGoXJFm9fhtH1oZs0ZHqYGsGzhaF8FAAaTBUUHMtl6THl?=
 =?us-ascii?Q?5RDDgiyyKnQB6HUGPjkDerYcxF8UTro6nNL6xXmYiKIS//V0kwCe+jOrxZEy?=
 =?us-ascii?Q?UwcvMyOLNHG836BYdtIoAvUkOTwK9hX4HNlHZ0vqjyIsjx3JDwfkUuJzC2dC?=
 =?us-ascii?Q?yQg+eLloU2IKYmmcdUyvfP7EtaJ4zEQ5LgkHe7Rxq6i2vuJ3a0Tuaxd6GMtH?=
 =?us-ascii?Q?3mYLXDMXP3jvOR5oopGDjppXITKgB7hts27UbKhAEHv8yPcOF7xJPNpmkpuR?=
 =?us-ascii?Q?/ecbVUX4Qnv5h1ElMdYdQg8qMxJamJ02wxhhXkt1bHdmFLbcQe3/gzOhQMl+?=
 =?us-ascii?Q?kfjPrp15fWyTjzvJ5aw8l0U+MquLKoloKwftoGO0xO2RSQ6MybvCT45JDCYJ?=
 =?us-ascii?Q?ZZOkQUZKO8aZjzfzgFFB9BodlgzNMf640SDNEn7Q7Ce9cCd4890z4345bx5k?=
 =?us-ascii?Q?BAZotkPw78q5pSBBejwD6lJxt9wcZlCVqTX1Wp2gsmwEPOOu3sA6Ge2OF53N?=
 =?us-ascii?Q?6QQwfTtQxLhQit6kUM/a2dmJ1mjXECf3rPtWNWmqNdBjNumNo0H6wd2hJWR5?=
 =?us-ascii?Q?SEcq4C1S3Fd0NLet4T8wIlOb75bgrp+XJ58jC55CD1sknZoFUCXhI8bcTkhd?=
 =?us-ascii?Q?SlHrpFERAxa9/+HbX+1YcHTwA98PC/rxC0rhbFjQ46f/I17imORFdQH2A3fr?=
 =?us-ascii?Q?ypZ1oqrIDBEGpIcXQ6V3oYd4lmyEAvZ+WSIE+tfCP93tCk1o/87QHyFWF1PN?=
 =?us-ascii?Q?CCbU95hRKx2MJxIWignVxwxCMkfUJaH5RbG3aer2gCnTeutjSsQTfQ+p+0ZH?=
 =?us-ascii?Q?22/Z5FiLoZGzZIQmeuuant6OU3x58HL28432AazO3TNfR3ZmLq+Dsunmxljb?=
 =?us-ascii?Q?J4+4QEdM++mQnLvIgXNYAzv5/+YJi1pL6U6QBbYav2aJXGlx3Ocne90bFCkL?=
 =?us-ascii?Q?Z1gT8PBRBiun0b5NNapPQc47rJfiIdM6KEKXXcyzj8y7g/+vesCncxZ88TFH?=
 =?us-ascii?Q?sT6M4lvqXBp1CaVwKRO5QGZW7bUteJ7AC7ZRfQytllVM3MEGnAa74ssqoQ0x?=
 =?us-ascii?Q?R3Bi7ybS9bs5MW1jDM+Wzk08DawrLZnVN+u24QREj3MVmlBsZJf9aaDBdkAm?=
 =?us-ascii?Q?fcWBP9NxH1AGqr6FO5Eo0pZM2aHDujqazFvjqfv6NKysdZGCZG6InNUaUVoh?=
 =?us-ascii?Q?65hKJWVAmrCrvqI6ZeAvtl7uooNU5qtXkGZIRxRsoeiYk4gTxJ6SLkMkuoS4?=
 =?us-ascii?Q?PPOg9ahvMZHjIyauaC5AXd1a/x/6K1qEHSDHqeU64Yz6IlJK+UJleQnGGfr8?=
 =?us-ascii?Q?+SYA8Rq9ehmanIee6XZVs7SQJwLOF2saMDRbSJL+qKWKhcIUziUpOW5iv0pc?=
 =?us-ascii?Q?m2hprq+JZyoVejZyVxWzHXkl7fFlJw0YhGHZ/iopH/riDHOD9oj2tTuQV//2?=
 =?us-ascii?Q?SNblxuVK1mhtGoankd48M90/VsQrtSslW74olcYBuYgzsDK5dtFk?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7072c6eb-bf66-4ff2-d57f-08debbbb9561
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:45:47.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ij424J1O35oawzrH+Y/N9YSVX6KrDMBZ2nlGiW7JSwVBCr1oL7utqfgQwfGYZAKNOiUthGSbnLRizrfyb/L1mTJsy0znqRBFWn1/zxBKlGAjnj+E/DwP0qRmO6yGGzAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13430

7724se is using Simple-Audio-Card with "platform data" style
(which is mainly supporting "DT style" today), but "platform data"
style is not working correctly working during almost 10 years.

7724se sound doesn't work in these days, and there has been no
such report. Let's remove sound support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-se/7724/setup.c | 101 ----------------------------
 1 file changed, 101 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index e500feb910539..58e86ba9ad735 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -37,9 +37,6 @@
 #include <mach-se/mach/se7724.h>
 #include <media/drv-intf/renesas-ceu.h>
 
-#include <sound/sh_fsi.h>
-#include <sound/simple_card.h>
-
 #include <video/sh_mobile_lcdc.h>
 
 #define CEU_BUFFER_MEMORY_SIZE		(4 << 20)
@@ -66,13 +63,6 @@ static phys_addr_t ceu1_dma_membase;
  * and change SW41 to use 720p
  */
 
-/*
- * about sound
- *
- * This setup.c supports FSI slave mode.
- * Please change J20, J21, J22 pin to 1-2 connection.
- */
-
 /* Heartbeat */
 static struct resource heartbeat_resource = {
 	.start  = PA_LED,
@@ -278,50 +268,6 @@ static struct platform_device ceu1_device = {
 	},
 };
 
-/* FSI */
-/* change J20, J21, J22 pin to 1-2 connection to use slave mode */
-static struct resource fsi_resources[] = {
-	[0] = {
-		.name	= "FSI",
-		.start	= 0xFE3C0000,
-		.end	= 0xFE3C021d,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start  = evt2irq(0xf80),
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device fsi_device = {
-	.name		= "sh_fsi",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(fsi_resources),
-	.resource	= fsi_resources,
-};
-
-static struct simple_util_info fsi_ak4642_info = {
-	.name		= "AK4642",
-	.card		= "FSIA-AK4642",
-	.codec		= "ak4642-codec.0-0012",
-	.platform	= "sh_fsi.0",
-	.daifmt		= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBP_CFP,
-	.cpu_dai = {
-		.name	= "fsia-dai",
-	},
-	.codec_dai = {
-		.name	= "ak4642-hifi",
-		.sysclk	= 11289600,
-	},
-};
-
-static struct platform_device fsi_ak4642_device = {
-	.name	= "asoc-simple-card",
-	.dev	= {
-		.platform_data	= &fsi_ak4642_info,
-	},
-};
-
 /* KEYSC in SoC (Needs SW33-2 set to ON) */
 static struct sh_keysc_info keysc_info = {
 	.mode = SH_KEYSC_MODE_1,
@@ -589,21 +535,12 @@ static struct platform_device *ms7724se_devices[] __initdata = {
 	&sh_eth_device,
 	&sh7724_usb0_host_device,
 	&sh7724_usb1_gadget_device,
-	&fsi_device,
-	&fsi_ak4642_device,
 	&sdhi0_cn7_device,
 	&sdhi1_cn8_device,
 	&irda_device,
 	&vou_device,
 };
 
-/* I2C device */
-static struct i2c_board_info i2c0_devices[] = {
-	{
-		I2C_BOARD_INFO("ak4642", 0x12),
-	},
-};
-
 #define EEPROM_OP   0xBA206000
 #define EEPROM_ADR  0xBA206004
 #define EEPROM_DATA 0xBA20600C
@@ -666,19 +603,9 @@ extern char ms7724se_sdram_enter_end;
 extern char ms7724se_sdram_leave_start;
 extern char ms7724se_sdram_leave_end;
 
-static int __init arch_setup(void)
-{
-	/* enable I2C device */
-	i2c_register_board_info(0, i2c0_devices,
-				ARRAY_SIZE(i2c0_devices));
-	return 0;
-}
-arch_initcall(arch_setup);
-
 static int __init devices_setup(void)
 {
 	u16 sw = __raw_readw(SW4140); /* select camera, monitor */
-	struct clk *clk;
 	u16 fpga_out;
 
 	/* register board specific self-refresh code */
@@ -699,7 +626,6 @@ static int __init devices_setup(void)
 		      (1 << 4)  | /* AK8813 PDN */
 		      (1 << 5)  | /* AK8813 RESET */
 		      (1 << 6)  | /* VIDEO DAC */
-		      (1 << 7)  | /* AK4643 */
 		      (1 << 8)  | /* IrDA */
 		      (1 << 12) | /* USB0 */
 		      (1 << 14)); /* RMII */
@@ -829,33 +755,6 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_KEYOUT1,     NULL);
 	gpio_request(GPIO_FN_KEYOUT0,     NULL);
 
-	/* enable FSI */
-	gpio_request(GPIO_FN_FSIMCKA,    NULL);
-	gpio_request(GPIO_FN_FSIIASD,    NULL);
-	gpio_request(GPIO_FN_FSIOASD,    NULL);
-	gpio_request(GPIO_FN_FSIIABCK,   NULL);
-	gpio_request(GPIO_FN_FSIIALRCK,  NULL);
-	gpio_request(GPIO_FN_FSIOABCK,   NULL);
-	gpio_request(GPIO_FN_FSIOALRCK,  NULL);
-	gpio_request(GPIO_FN_CLKAUDIOAO, NULL);
-
-	/* set SPU2 clock to 83.4 MHz */
-	clk = clk_get(NULL, "spu_clk");
-	if (!IS_ERR(clk)) {
-		clk_set_rate(clk, clk_round_rate(clk, 83333333));
-		clk_put(clk);
-	}
-
-	/* change parent of FSI A */
-	clk = clk_get(NULL, "fsia_clk");
-	if (!IS_ERR(clk)) {
-		/* 48kHz dummy clock was used to make sure 1/1 divide */
-		clk_set_rate(&sh7724_fsimcka_clk, 48000);
-		clk_set_parent(clk, &sh7724_fsimcka_clk);
-		clk_set_rate(clk, 48000);
-		clk_put(clk);
-	}
-
 	/* SDHI0 connected to cn7 */
 	gpio_request(GPIO_FN_SDHI0CD, NULL);
 	gpio_request(GPIO_FN_SDHI0WP, NULL);
-- 
2.43.0

