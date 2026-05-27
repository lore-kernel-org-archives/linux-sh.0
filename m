Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011048.outbound.protection.outlook.com [40.107.74.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349A378D68;
	Wed, 27 May 2026 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864347; cv=fail; b=GBjByAoLnu8hKUEiz5zdwBUPSxnGsgUCuTaF7JZCIeFS8GL7pJi96jHgvCGL7vKb0Lq4WS9TW8wkpb/gYlNVHnuNpIv2n4SHSX3kGCR8sRt603JnkDF4J6lchNxcf6Qr6X6BjraCcUNzr7c7pgXdD8qwpr1OSY2th4TzEBOdHMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864347; c=relaxed/simple;
	bh=oVfAC6Te5bgczk0P8nc/eYBGZlWwxPAvtj1VXXlXm4c=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=mEAdOx3Beaic6olN3b/D0/AsV7ao6CEQDj2rl8XRkO9Ging7hit1wcbUVJ9DIICZ1fIg5Jmk97miICRWdHv7tlXJDAnPtJwNMOi9ex0546RYor1xFcsFLFnZecgi4MYdNaVj+XU57yphrU9B9bmGbbH5OZix0dLAyUO4fRi1OfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=CyMWQaWZ; arc=fail smtp.client-ip=40.107.74.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="CyMWQaWZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCDr46gptmFK1onpkxu60FpSVf/Yod6yyK9z2rejrxo+N/I8EppkAg+vEl4+DCw/qWf2WBEXsKtHYjMCH78pB50IMCIZkc2VlJpB2F1vGuJmME33p51dnQo1yCKRkNPMI8Y7Pxi1oZSThB1z+3bxRvC3b18n40HjYBC0lPgchbJB0tdGnR2K42JzIZES5FgN4phhkVDef5AEEQBtsoO20tg29kWYDDU18KjBxW9wb0vHvbaZ+mZSQiKYmqbcUcV07o9WHK1XAjHCWlXhMCOa8R++UvRC+PZ2zWTiPMvmgxrvvlMBzB/tMWBNucKz6foZgzMFJVMsftrbKA1JsjMb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apKdNrJmg63A7d9fK15fam7+7NKKHd3xoxJGh9xURBQ=;
 b=i15k2m51D5v0/3PwR7aiW7BW/ude4k4oTeVd8rWNftYzgGBVBBrtYzOQ3wKw1r6i7F9/WPeXp6TdFOGPWnLGpcSyK7mDnfOktNk9x+77TZwjO+Er6kkDMWbBPH26qSj0ucWJTbIkWA/N0gYWxaKkjg+pULs8ZXfO2jdFSZ+m3iajN9/McWHuT0HSAPeI6uK+7DHX63gxCH0O5Ie2QbMHel0QjzjVzRO64S6ZjKQT5FV7Xg8lj1j6/ZDaVxudDCE8Cj/Zdj+qcJIxwC7pPY1wIkDDTjIbL2LEFUotPiV57IQ5sEYJ/f0XLCOUCQBQ370jQRkihL/uCw/lH7DFVufWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apKdNrJmg63A7d9fK15fam7+7NKKHd3xoxJGh9xURBQ=;
 b=CyMWQaWZZCTl8P5VEn7EeR3W7hSHNFR6Jam6uOwmKziDdJSnHJ5tV7KsS0PCylcq8+RvB/lEz2i/sdayt6uLZilH5hlpUeNqqhYKcakBy/vtBL4IVawg85o4mW5z4JWNHfoopd2lpMML8HNAaC26r62QT5xhC5i9eSN54rjr+jI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYRPR01MB15880.jpnprd01.prod.outlook.com (2603:1096:405:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 06:45:42 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 06:45:41 +0000
Message-ID: <87y0h5e4ff.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/3] sh: ecovec24: remove FSI/DA7210/Simple-Audio-Card support
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
Date: Wed, 27 May 2026 06:45:41 +0000
X-ClientProxiedBy: TYCPR01CA0199.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::13) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYRPR01MB15880:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a85cef-e128-4413-6bcd-08debbbb91d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|921020|38350700014|18002099003|22082099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	ptwsX+/SmhxCNXyAILPKU3dmkF8Sb1S1XuUu5z7ToIvIVUmsASw6MgH1OV/EMjkBFHJDopeaa1NlXuu4Mq4iMpGqFoOCeLZy1Qe26XWBZpJQBVzls654mR+6fDz8TmzUFRistmTtTUn9KbyErlZUqNTsgKdGHIYxxXz/dRVJyyKjkSGesE7vk45y/B0j/TUhxcAPZhQxbyGuHQAtEFy4E7rrMDzfZvBxLTiL7cfBLL0uYssHS7WElDQAIvr8kXKClC6gckndYRcTncKueKewMxmPdzz/qEBEJsq1UtsPwyPTE34/hdK5X3A7kIrjp2WM+kJGoPPD+XOLJWZToX1uwJkRTqutxFGY61oi339flUMiifrmIpzaSg4xxKI5H2jAX+6ORVE7BuH7Z8C4WvTEwAizCOxjd8FRUMN+QiAvy6nAHkQrUrT195yC7PTIAWzupPu0EcpVDrwlOkuZCicZDse+CPr58S+uvu7fJga2un/QUkKcl3vprDCvVeaAfDLRLTldzektVlmuppR0MXsBMx4xwOtg1TOttZWCCZS+Hr3ZHRheLGxWqTe2tj3DuO1Tr7DSAMY7iaVq9dYeWju4IXICBvjlIHD4aG2CLyeM9V9CWSeOai1oMjbB1mXfwcAWZMygMm8hnE28xe3sS1lYpyOuP5S9O/Y/dLWVSOMu2OAyQu4QacD2gC2EOQZQ9FDI2ALHtaVBNzF5DIAkOwd9nfkw4y8tegCEj1J6ViffFDTweh27Px53uNySGpeVm/FXRb62jekHSJD+K0JS8/XiSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(921020)(38350700014)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PxxnAQy+vhgvjSHjhPrN4YEyM36h6X6LxElH60dFUkoKgzo1DmL1HE9Pu27?=
 =?us-ascii?Q?BgTQDg8u6D0VOfCUbtZX+7F+aGicUxH/6e3UhO5//eI0h7Mo/bxDfl5oLXW1?=
 =?us-ascii?Q?9husAkSnXJIIDy3rTWOTjhpMn6babKcUImj5GaG1sSHlQwP9Nq9Or+unWGXf?=
 =?us-ascii?Q?ayX7IAtj1zcOxF4v+mrXKu/TjqoSmrVEYciBxgzldSWlpLLXD7ZIdUg8CdZE?=
 =?us-ascii?Q?H+Ssgi4La+uNc/orLuuF0YEcA/P+IP4SVkFIq1d9AG9PSmeeS79C/itLLbHG?=
 =?us-ascii?Q?BQkVl4/ZOVfU51ufJAPmibf7rFv0JR8DX5wzQU+TjyfXpxOL/J+Xq/cGE5fp?=
 =?us-ascii?Q?gaUNdUBp02yogAJSAhGAIzwHN4WFJKSKwrp7gzgwCYSP6H60BqW7SF+AuaXE?=
 =?us-ascii?Q?9HWuxq0KqMQB7r3UflWwZMj7d5RKAgcXppMLRwJVV58MeaejngrgwmhtWZB3?=
 =?us-ascii?Q?/Vva+aPoM8naPwsaBwZUEKx1K3FG+vtbXzfycpg/dXGtmaOOP42miH9SNzan?=
 =?us-ascii?Q?hgFTH9GYXbmrsLWiMkdfrfUtRqekcs8UvbjK75v1uzpkkqQ2ae5w7lw3TyVF?=
 =?us-ascii?Q?06q/u4Qu0g0pz31zRVGIUN2ijcyqId89Sfi3fH6Uy84T9axtip9kUSwqsqNF?=
 =?us-ascii?Q?xjZ0R5IB1pDcnjUAnacUhvVNNCOWUv/c3SkkWJmT5JE3Mvh6xOhftSI+eHJv?=
 =?us-ascii?Q?UuXimaA00RVnPLJfPPn1pbWmAFEUK85Hi75pholkn2I5kxLDo+26cTBlws0U?=
 =?us-ascii?Q?FkpiVzvqABrlk4C/k7fCmM2BnqX47uRV4ocuddB1kGXS7ut3S9jhl2RNO9VI?=
 =?us-ascii?Q?LOq4s1/ClZ47ZpoQm+YGQ/6Q6LTC1J+nYRMyInHSEYlI0P8Ub5dzefno6jmo?=
 =?us-ascii?Q?Z/fhpVWkcuUspVXYuhtazVzP7oo+Kw9wo2KbIGJAa02jsRNG+kbO5cT1Z+lO?=
 =?us-ascii?Q?kaXMvb2CDBdT/LodBWWtZ49FmMxlOECKGiM/A7AN6vQ19PCCrBqhvg4wD2p7?=
 =?us-ascii?Q?w5i1nI6eus5YewPIQHbsw2NrNSUUTf1dpwTcpUVvJ0WLgzceEpB8l8oP++wo?=
 =?us-ascii?Q?gj/mOPOuIKFlWtY+p5Iiqo3PqxiEGeto/BRhu5S0ZOgTOVCtH9icLajU8jEx?=
 =?us-ascii?Q?n//jxhZPBDW/4EA+XMI0zZR5h4Oues0x5zARiwcE2qfFokl8EwQRoMkEdO9v?=
 =?us-ascii?Q?7DYzPc62gYVoJ5eULuxu24rBixqJ2Yezb6NFOEIH/HDhKJxnk+mydoPyaG8o?=
 =?us-ascii?Q?xKTMGbxm/PliGLUoqm4Z4lsia16WjyH4aD4Uoqc7fjXjYZMkpSFtGVTXHZWF?=
 =?us-ascii?Q?kCCzoprGraRjlkOWkRBhTZaEmcmLbBEHIGxlfSa/H/DvJrhd+bqibthcAmXA?=
 =?us-ascii?Q?ioQCmUCNSfzNkXojSguNTvRkxEjvCI2k85haGA/DCqDIaIqcFZkHxdrQ3OOO?=
 =?us-ascii?Q?OdQBFoyOgH/pdnGY1HY5RjuRM461V8srd0Te6YFXq9JUdoLRGvMut6NL/D9W?=
 =?us-ascii?Q?BCRvtM5/h+cwoLmvXtTOUEO+wemSuGy+2uzxl7VCGOLCOagvG2q/v2slz0X6?=
 =?us-ascii?Q?GoVZa7wTX/RKJSxCUVidTqvcHk71V75H1X3tKJU7Q0iGnPSp6Ldzlixi0OBw?=
 =?us-ascii?Q?cyafYIoUkUlTxcw2RqYrkmC4sCLT+PXPp0rqO7jWlgop0FM+8BcAqjsyXG0y?=
 =?us-ascii?Q?Z6yVHNm1icfL56KG1ZBIYDV5ExHYCEhGT8rksvs1YBPGamIc9bJBDJDV5Nk9?=
 =?us-ascii?Q?dJbpbF5SU/y9unoAg+2n1dQn0l5gUwKdq91Aoe/c8bzyML+KRQAG?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a85cef-e128-4413-6bcd-08debbbb91d8
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:45:41.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gIWl+ERU2yT9NdN7z9byHNnf+HL6shLcmIjjMqN1ngWw9ALpmWckWNzgc37byuawYgYwTBdlkKLssRm4gPWjt1BHc/eGiKNec36gTtQ0CgK8hKoSWyDlZLZaaSZQ/zn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15880

Ecovec24 is using Simple-Audio-Card with "platform data" style
(which is mainly supporting "DT style" today), but "platform data"
style is not working correctly working during almost 10 years.

And DA7210 which is used in Ecovec24 was prototype version, and has
diff between production version. The driver doesn't care about it.

Ecovec24 sound doesn't work in these days, and there has been no
such report. Let's remove sound support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c | 90 ----------------------------
 1 file changed, 90 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index a641e26f8fdf7..fe78dba442f91 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -42,9 +42,6 @@
 #include <media/i2c/mt9t112.h>
 #include <media/i2c/tw9910.h>
 
-#include <sound/sh_fsi.h>
-#include <sound/simple_card.h>
-
 #include <video/sh_mobile_lcdc.h>
 
 /*
@@ -72,16 +69,6 @@
  *                                  OFF-ON : MMC
  */
 
-/*
- * FSI - DA7210
- *
- * it needs amixer settings for playing
- *
- * amixer set 'HeadPhone' 80
- * amixer set 'Out Mixer Left DAC Left' on
- * amixer set 'Out Mixer Right DAC Right' on
- */
-
 #define CEU_BUFFER_MEMORY_SIZE		(4 << 20)
 static phys_addr_t ceu0_dma_membase;
 static phys_addr_t ceu1_dma_membase;
@@ -520,9 +507,6 @@ static struct mt9t112_platform_data mt9t112_1_pdata = {
 };
 
 static struct i2c_board_info i2c0_devices[] = {
-	{
-		I2C_BOARD_INFO("da7210", 0x1a),
-	},
 	{
 		I2C_BOARD_INFO("tw9910", 0x45),
 		.platform_data = &tw9910_info,
@@ -861,51 +845,6 @@ static struct gpiod_lookup_table msiof_gpio_table = {
 
 #endif
 
-/* FSI */
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
-static struct simple_util_info fsi_da7210_info = {
-	.name		= "DA7210",
-	.card		= "FSIB-DA7210",
-	.codec		= "da7210.0-001a",
-	.platform	= "sh_fsi.0",
-	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBP_CFP,
-	.cpu_dai = {
-		.name	= "fsib-dai",
-	},
-	.codec_dai = {
-		.name	= "da7210-hifi",
-	},
-};
-
-static struct platform_device fsi_da7210_device = {
-	.name	= "asoc-simple-card",
-	.dev	= {
-		.platform_data	= &fsi_da7210_info,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.dma_mask = &fsi_da7210_device.dev.coherent_dma_mask,
-	},
-};
-
-
 /* IrDA */
 static struct resource irda_resources[] = {
 	[0] = {
@@ -1031,8 +970,6 @@ static struct platform_device *ecovec_devices[] __initdata = {
 #else
 	&msiof0_device,
 #endif
-	&fsi_device,
-	&fsi_da7210_device,
 	&irda_device,
 	&vou_device,
 #if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
@@ -1357,33 +1294,6 @@ static int __init arch_setup(void)
 		__raw_writew((__raw_readw(IODRIVEA) & ~0x3000) | 0x2000,
 			     IODRIVEA);
 
-	/* enable FSI */
-	gpio_request(GPIO_FN_FSIMCKB,    NULL);
-	gpio_request(GPIO_FN_FSIIBSD,    NULL);
-	gpio_request(GPIO_FN_FSIOBSD,    NULL);
-	gpio_request(GPIO_FN_FSIIBBCK,   NULL);
-	gpio_request(GPIO_FN_FSIIBLRCK,  NULL);
-	gpio_request(GPIO_FN_FSIOBBCK,   NULL);
-	gpio_request(GPIO_FN_FSIOBLRCK,  NULL);
-	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
-
-	/* set SPU2 clock to 83.4 MHz */
-	clk = clk_get(NULL, "spu_clk");
-	if (!IS_ERR(clk)) {
-		clk_set_rate(clk, clk_round_rate(clk, 83333333));
-		clk_put(clk);
-	}
-
-	/* change parent of FSI B */
-	clk = clk_get(NULL, "fsib_clk");
-	if (!IS_ERR(clk)) {
-		/* 48kHz dummy clock was used to make sure 1/1 divide */
-		clk_set_rate(&sh7724_fsimckb_clk, 48000);
-		clk_set_parent(clk, &sh7724_fsimckb_clk);
-		clk_set_rate(clk, 48000);
-		clk_put(clk);
-	}
-
 	gpio_request(GPIO_PTU0, NULL);
 	gpio_direction_output(GPIO_PTU0, 0);
 	mdelay(20);
-- 
2.43.0

