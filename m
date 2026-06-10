Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010046.outbound.protection.outlook.com [52.101.229.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B57335BA;
	Wed, 10 Jun 2026 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052515; cv=fail; b=WnuDo9CCnyqLql8Hsrt0+kcC7j/+Eh6eeyo9arSEmhq/ms59XzfLAxzd5BxQHZqRCJbI/T73uOw65sKkPMSo/QMlFsNhaOe7VK4dQLi7J88/vS/lfJLN5NjG3z5IsxDJXt56MAhl5VP/8Ukl0TSA8Q3jz4rtNstf40BUwCov8Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052515; c=relaxed/simple;
	bh=8psTbyBagWMWkdk76aIcpdNzhd1LlTWs/TRWZv8gupM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=e3d+PF2cL76m4oWtxqnPAUBhfckIN2Pf60XIFHFyz/izOYr7iK4J1zhrZ00ZEW0yzsq89rXMi1cRGVgOdN97G0oCCQkBcosrvss3j+OJ1MHKzsAPhyTiOjHZDLceqz7cOOHFj46EwSlZKDy+yGzvpgNxkuoHmrLK8mUuK6XREVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=AWoUd/vK; arc=fail smtp.client-ip=52.101.229.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="AWoUd/vK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7wmJTbOVPyZRexDCCjCRIMeAGot6DWuG44ICgjHk2aeiMEqsJF6mTzoK4C4cJAZmoYgXTqYUtyHSibMMEYlOPdI9e4lNTVv4QOZFewTuC188jPIyuh6BGJ/6HWPBwDZWS3JdKfP6cQSpT0c+EVr2QCGWf9MDQ6XG83TratL4L6U3C8BImNehfD0WB7I6EZcouJCh1TuoNiVsEyTs/7Glud0PM4VW++YbYf5vQRuc0LzX5Pf/8Q82zK+3eMbcfHMes8M2Qzp5Yt9zpd0stjw4Kg4Ddm2MHidjO/8d/q8j9spTIh9En83bS2m6ct+v2halkQ+kFqXT9vpjcb8GGBfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itf99EnxDqBmB1xEoJBdlbzHUqN2QhpmLHqdebVXqt8=;
 b=kSgU9nHOuODjHj2klfoYhCxCaIUJs1RzAkQ/qjYf4WCL2N5OC6Rr0y/EQC9+Y0UbIiJH/JuKgtcM72zQr/Pr2/pEgQ5/323WAn8b8DVH0JFivrgzx/FDtOQ8VKMFYniDfzOq5jscrmKxRwhWv4Uv6U4t0n8U7VhlBRxub6ow35f3jKk0kV9aMtbg9hEhme2Mscb8LNJH2oWiY6/WLQU5XEgOwiZ9R4HcEVbug1CkF6TtA/e/v8a+WwNtY+noaeact4/PVovI/HME4MNQfLav58nNw1TsVrO04/QoWsEPaeoaVfVtu/IjMyCJHP67+ECMzrIvRqvzp9aS1eoKgB4jBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itf99EnxDqBmB1xEoJBdlbzHUqN2QhpmLHqdebVXqt8=;
 b=AWoUd/vKeqIBxmWWh6u2SJT0rEDh3zwgntgQosGuGu+PkV/6bKBU+I5bYHxpUdItVMzA1iy/c/0p+Wk/0kQabZkXAQEGUrHA1K5q1POhZLO6r2ofsr2364Pxcuoa/f+vfuwa+VdWm1ytMQMKZzi/s5Ys0mMekRNm7XQznrKQvVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYCPR01MB12042.jpnprd01.prod.outlook.com (2603:1096:400:3e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 00:48:31 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 00:48:31 +0000
Message-ID: <87v7br43vk.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/2] sh: roll back Ecovec24/7724se Sound support
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
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
In-Reply-To: <87wlw743x2.wl-kuninori.morimoto.gx@renesas.com>
References: <87wlw743x2.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 10 Jun 2026 00:48:31 +0000
X-ClientProxiedBy: TYCP301CA0043.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::19) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYCPR01MB12042:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c991df7-acfd-45cc-52fc-08dec689fe6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|366016|7416014|376014|1800799024|38350700014|921020|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	88bmXEkWkFYgBxkVY7dpqFh7iaLDBhkMx81k6GJ1T1ICAFCuHbYtimaZuCd6L3bqSabwC1hQgNhzdL5iaMPbzeJBjfuSHqI730PTTwcxz1nqpyULpiC2B8Dhc19W40/WmywOM/5Pw5S0XHzl6xoIr2FBjanrPBWi8AH+vkB1laFIOoku57BDX3sux4EEkWG0RL61ivTq2Yah+/mvXJjkZgQWUDDGYm/GjKQ3M8/nvE/5aLIjE0V+p1zkq1/qjzFpZouykn3371MO3RbJ53ACHhr2vU/VfhFUn/PENzwPnGNP51Gw+YoiJYcmyQM3weiD+C6qZGvqOlW6KC+BVoyvsfBlGD8OfRoxls6LQh8FeKsNG2nwNiY7iOXDtsUfSPjh/hiH3P7GqqqURxarVjOW2ayETMonsa1WI2Fig8HVZTbiPqXsmYJLcm1EEYx1ea4lX8PgKXXjRvfW8qb/6jWQtzYctjyLrAqPDHmBXB2aGNitWc9HDvFO5Ayy9gJRRwoGxJkTe6iWM2t8JQHSU4VjxJVYt0v3AvqC41i/eZU5YvFEEgb/F5C5+SN/dOu2y0kFT44AsvbrET1hDucQd0+hTA4HA9XAFZ1kXqGnhnXOxxN4aiiNgLNbeipmN6NpohTJGiHfc47Aco00AdjEomfkHmhRNJCCGhpiCc0WVdnB+HcK5udTzjfpD4jxEPY+eGDyhc/2RCfVHGXdw2Wg3vTfpo7D3kTGNTLgd3IpI1YAZasieTJ8QxXOafPV2COadSCerupgIFheRzLqgPwxmCXYGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXPZhyzYUk+U/a0A8x9MO/en/1lArjGdZRfsWDyu0eYM5KgPxCUlrBwQTfYb?=
 =?us-ascii?Q?8cZE5s4dGOJEQB0GQ+hxQ1+x8byAnD2HEeftz0nXf6exkGdSiOKXwOOcPbVk?=
 =?us-ascii?Q?3H6L73iQK7ki7Tn/Mx0WiB81ZSB0Fks2/JGQH+NKCIncholpo7SDvjN5JKR3?=
 =?us-ascii?Q?RzFUlyG56vke8H0bxEz/BEhwaQNi4Y0BmF86o7b2sXcsSlwnPSHzbV001vG2?=
 =?us-ascii?Q?EviVeJl6eLl5yS4aPLT8i14Vhpms6MTB+0/KtPSzvNAAG8otJGvNQ0bJcsQq?=
 =?us-ascii?Q?2+gTt6qCvZ6SZaUHjJMmQf6w0j3osJvb3SA1j/oZ98QaXJqPZeJhK3Ba9A/b?=
 =?us-ascii?Q?uhTcnctJWdifd8q42lXWRAUlgMt11O3YO0clqC26brViWYrRz2RX5R/QYhff?=
 =?us-ascii?Q?DlVfkRC1dsntqxkbCl720kseqWJo5b0zHB62CfdTOWm8W1k5hc4wFab1aU58?=
 =?us-ascii?Q?ElvUxEeilYDVWm7Q3ffg8aXd2XqprAgsuwnhMRn4hFD0YHsZcN7hA+U3pxnx?=
 =?us-ascii?Q?06dtZb/SR7pxa5Ec/8r+UXNKRVKQFlPBQ2Nv0IpyQDW3qg2wnrlEfqiTVvN7?=
 =?us-ascii?Q?nRKVLYp3gwFETJ78KLB/P/S7hO408PQwRoE6cX2dAaIkNmHc3k/dJkZW7ZsN?=
 =?us-ascii?Q?cPV7yCKjYfbUCsnYUlCRCUOFxSq1NwzhiuWQzhai20VG+uXIzm7Q1oFloz40?=
 =?us-ascii?Q?sSgCnW672iZUZaUuBJ37GqHQWgqGv5Es4kH5i6jMxxZx5wivMKvB7xLrNkbM?=
 =?us-ascii?Q?XKxEw58CcbltqphPbrSnPj0Xkk4G34SYO9uOO6if89MsdtqfrjfQljj0dUCq?=
 =?us-ascii?Q?CKS9VCr0Fb9c9QgntxEp4DS5nYNsGRoIOD+6/DIf/P+cIK4wwQC54HOVRXBY?=
 =?us-ascii?Q?qalzDYTHofBaYSRAHq/eFzVTQgEWY6TY0pvqrx+m41MHVhhbBIyqY+VHJHHB?=
 =?us-ascii?Q?EyfYwby1l6kCvVBJ5szU/6fQ8ewq1xaiuTYz+g1Es2UTWRxdjWf/BbJ3qO4h?=
 =?us-ascii?Q?cFC2Iz+n0VoGsTH1dcz3pOQxY1XN21ycVjbbFexsifjJUR4pj4c9eySLjMnz?=
 =?us-ascii?Q?zgpjp76lX7woAZsY6sLgC8H0J1wdjtMhbQO/vcGs4M58JJWeWQCOfIKh//93?=
 =?us-ascii?Q?PHgmIngf5koe/bWr0mqqOp5SLnD0g71pRIgAy/X1ANKPEy/LvWcvMgHbJ9Yg?=
 =?us-ascii?Q?CBvp431a8SoD12vBcv10immfhmnBo8XukirbocEUwK8sfyqSeIxkidXTtNEV?=
 =?us-ascii?Q?nQM0rsLi8S64/fCTq2Z4vaBqkroIRvKrr7j9WyQ6dS6OHZEQ6p8eMy9WCmJq?=
 =?us-ascii?Q?gCZuctMsM+Z4Q1KzjbB0cwO7yqr4eXSKVP5EPiRSDqbDHbjiXJbpqT4gYbc+?=
 =?us-ascii?Q?xrHAVSrG4yJ9z+V61qk+obVtZtcwdT+hPa+TcYODI0lO6aZia/HYC0dK5sSF?=
 =?us-ascii?Q?Ex+9ANHX4gHEVFV9F8tCjZg0bzkHCmhQjGDAGcR+hF2M3e7FCJASwVz2SLYF?=
 =?us-ascii?Q?eRLDt1iMSNuZQTI8tuKZEnAOChJYUK5e9KX/PX1Ag/qm8KYcqQW1WCWo0YJA?=
 =?us-ascii?Q?H4mbYigmNcJnG68DWJGAhrT7INRC1xYIfff/ewDpVMzrPe3+fQ7IP+SaTM4k?=
 =?us-ascii?Q?5VLRK883G0rVi57BkN8yKV9GJ+g/XdWaw1LaiIeaIrme+eoHpDWrJhW1HChc?=
 =?us-ascii?Q?J0zu9lenE/Udc+qJ1x1C4bkmptAALtW/43CI6ngKWU4qcn3Ko28R89FgEFt9?=
 =?us-ascii?Q?Y5tj3v1VkCOlrqhUaU4SwXPj09IaK40ibo6wcwEuau6tLBWA7+Be?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c991df7-acfd-45cc-52fc-08dec689fe6a
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:48:31.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+QRTteVbKWW36IiLzhJHj+XHSsWKigOXnF8oC7jUt4l/r53hmfG6uEVPeQGYVVht9qCBlCRdZzIaxKgANKwJ0ePwkR5enCWUKEhB0fSmu3I/d7I8YrFNDqe4F8J/ao3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12042

Due to a communication miss, the Ecovec24/7724se Sound support
were removed. We need to keep them for a while, until they will
support "DT-style".
Roll back Ecovec24/7724se "platform data style", and its necessary header.

Fixes: deadb855b694d ("sh: 7724se: remove FSI/AK4642/Simple-Audio-Card support")
Fixes: 9cc93ebc85e71 ("sh: ecovec24: remove FSI/DA7210/Simple-Audio-Card support")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |  90 ++++++++++++++++++++++++
 arch/sh/boards/mach-se/7724/setup.c  | 101 +++++++++++++++++++++++++++
 include/sound/simple_card.h          |  26 +++++++
 3 files changed, 217 insertions(+)
 create mode 100644 include/sound/simple_card.h

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index fe78dba442f91..a641e26f8fdf7 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -42,6 +42,9 @@
 #include <media/i2c/mt9t112.h>
 #include <media/i2c/tw9910.h>
 
+#include <sound/sh_fsi.h>
+#include <sound/simple_card.h>
+
 #include <video/sh_mobile_lcdc.h>
 
 /*
@@ -69,6 +72,16 @@
  *                                  OFF-ON : MMC
  */
 
+/*
+ * FSI - DA7210
+ *
+ * it needs amixer settings for playing
+ *
+ * amixer set 'HeadPhone' 80
+ * amixer set 'Out Mixer Left DAC Left' on
+ * amixer set 'Out Mixer Right DAC Right' on
+ */
+
 #define CEU_BUFFER_MEMORY_SIZE		(4 << 20)
 static phys_addr_t ceu0_dma_membase;
 static phys_addr_t ceu1_dma_membase;
@@ -507,6 +520,9 @@ static struct mt9t112_platform_data mt9t112_1_pdata = {
 };
 
 static struct i2c_board_info i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("da7210", 0x1a),
+	},
 	{
 		I2C_BOARD_INFO("tw9910", 0x45),
 		.platform_data = &tw9910_info,
@@ -845,6 +861,51 @@ static struct gpiod_lookup_table msiof_gpio_table = {
 
 #endif
 
+/* FSI */
+static struct resource fsi_resources[] = {
+	[0] = {
+		.name	= "FSI",
+		.start	= 0xFE3C0000,
+		.end	= 0xFE3C021d,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = evt2irq(0xf80),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device fsi_device = {
+	.name		= "sh_fsi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(fsi_resources),
+	.resource	= fsi_resources,
+};
+
+static struct simple_util_info fsi_da7210_info = {
+	.name		= "DA7210",
+	.card		= "FSIB-DA7210",
+	.codec		= "da7210.0-001a",
+	.platform	= "sh_fsi.0",
+	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBP_CFP,
+	.cpu_dai = {
+		.name	= "fsib-dai",
+	},
+	.codec_dai = {
+		.name	= "da7210-hifi",
+	},
+};
+
+static struct platform_device fsi_da7210_device = {
+	.name	= "asoc-simple-card",
+	.dev	= {
+		.platform_data	= &fsi_da7210_info,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.dma_mask = &fsi_da7210_device.dev.coherent_dma_mask,
+	},
+};
+
+
 /* IrDA */
 static struct resource irda_resources[] = {
 	[0] = {
@@ -970,6 +1031,8 @@ static struct platform_device *ecovec_devices[] __initdata = {
 #else
 	&msiof0_device,
 #endif
+	&fsi_device,
+	&fsi_da7210_device,
 	&irda_device,
 	&vou_device,
 #if defined(CONFIG_MMC_SH_MMCIF) || defined(CONFIG_MMC_SH_MMCIF_MODULE)
@@ -1294,6 +1357,33 @@ static int __init arch_setup(void)
 		__raw_writew((__raw_readw(IODRIVEA) & ~0x3000) | 0x2000,
 			     IODRIVEA);
 
+	/* enable FSI */
+	gpio_request(GPIO_FN_FSIMCKB,    NULL);
+	gpio_request(GPIO_FN_FSIIBSD,    NULL);
+	gpio_request(GPIO_FN_FSIOBSD,    NULL);
+	gpio_request(GPIO_FN_FSIIBBCK,   NULL);
+	gpio_request(GPIO_FN_FSIIBLRCK,  NULL);
+	gpio_request(GPIO_FN_FSIOBBCK,   NULL);
+	gpio_request(GPIO_FN_FSIOBLRCK,  NULL);
+	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
+
+	/* set SPU2 clock to 83.4 MHz */
+	clk = clk_get(NULL, "spu_clk");
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, clk_round_rate(clk, 83333333));
+		clk_put(clk);
+	}
+
+	/* change parent of FSI B */
+	clk = clk_get(NULL, "fsib_clk");
+	if (!IS_ERR(clk)) {
+		/* 48kHz dummy clock was used to make sure 1/1 divide */
+		clk_set_rate(&sh7724_fsimckb_clk, 48000);
+		clk_set_parent(clk, &sh7724_fsimckb_clk);
+		clk_set_rate(clk, 48000);
+		clk_put(clk);
+	}
+
 	gpio_request(GPIO_PTU0, NULL);
 	gpio_direction_output(GPIO_PTU0, 0);
 	mdelay(20);
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 58e86ba9ad735..e500feb910539 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -37,6 +37,9 @@
 #include <mach-se/mach/se7724.h>
 #include <media/drv-intf/renesas-ceu.h>
 
+#include <sound/sh_fsi.h>
+#include <sound/simple_card.h>
+
 #include <video/sh_mobile_lcdc.h>
 
 #define CEU_BUFFER_MEMORY_SIZE		(4 << 20)
@@ -63,6 +66,13 @@ static phys_addr_t ceu1_dma_membase;
  * and change SW41 to use 720p
  */
 
+/*
+ * about sound
+ *
+ * This setup.c supports FSI slave mode.
+ * Please change J20, J21, J22 pin to 1-2 connection.
+ */
+
 /* Heartbeat */
 static struct resource heartbeat_resource = {
 	.start  = PA_LED,
@@ -268,6 +278,50 @@ static struct platform_device ceu1_device = {
 	},
 };
 
+/* FSI */
+/* change J20, J21, J22 pin to 1-2 connection to use slave mode */
+static struct resource fsi_resources[] = {
+	[0] = {
+		.name	= "FSI",
+		.start	= 0xFE3C0000,
+		.end	= 0xFE3C021d,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = evt2irq(0xf80),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device fsi_device = {
+	.name		= "sh_fsi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(fsi_resources),
+	.resource	= fsi_resources,
+};
+
+static struct simple_util_info fsi_ak4642_info = {
+	.name		= "AK4642",
+	.card		= "FSIA-AK4642",
+	.codec		= "ak4642-codec.0-0012",
+	.platform	= "sh_fsi.0",
+	.daifmt		= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBP_CFP,
+	.cpu_dai = {
+		.name	= "fsia-dai",
+	},
+	.codec_dai = {
+		.name	= "ak4642-hifi",
+		.sysclk	= 11289600,
+	},
+};
+
+static struct platform_device fsi_ak4642_device = {
+	.name	= "asoc-simple-card",
+	.dev	= {
+		.platform_data	= &fsi_ak4642_info,
+	},
+};
+
 /* KEYSC in SoC (Needs SW33-2 set to ON) */
 static struct sh_keysc_info keysc_info = {
 	.mode = SH_KEYSC_MODE_1,
@@ -535,12 +589,21 @@ static struct platform_device *ms7724se_devices[] __initdata = {
 	&sh_eth_device,
 	&sh7724_usb0_host_device,
 	&sh7724_usb1_gadget_device,
+	&fsi_device,
+	&fsi_ak4642_device,
 	&sdhi0_cn7_device,
 	&sdhi1_cn8_device,
 	&irda_device,
 	&vou_device,
 };
 
+/* I2C device */
+static struct i2c_board_info i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("ak4642", 0x12),
+	},
+};
+
 #define EEPROM_OP   0xBA206000
 #define EEPROM_ADR  0xBA206004
 #define EEPROM_DATA 0xBA20600C
@@ -603,9 +666,19 @@ extern char ms7724se_sdram_enter_end;
 extern char ms7724se_sdram_leave_start;
 extern char ms7724se_sdram_leave_end;
 
+static int __init arch_setup(void)
+{
+	/* enable I2C device */
+	i2c_register_board_info(0, i2c0_devices,
+				ARRAY_SIZE(i2c0_devices));
+	return 0;
+}
+arch_initcall(arch_setup);
+
 static int __init devices_setup(void)
 {
 	u16 sw = __raw_readw(SW4140); /* select camera, monitor */
+	struct clk *clk;
 	u16 fpga_out;
 
 	/* register board specific self-refresh code */
@@ -626,6 +699,7 @@ static int __init devices_setup(void)
 		      (1 << 4)  | /* AK8813 PDN */
 		      (1 << 5)  | /* AK8813 RESET */
 		      (1 << 6)  | /* VIDEO DAC */
+		      (1 << 7)  | /* AK4643 */
 		      (1 << 8)  | /* IrDA */
 		      (1 << 12) | /* USB0 */
 		      (1 << 14)); /* RMII */
@@ -755,6 +829,33 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_KEYOUT1,     NULL);
 	gpio_request(GPIO_FN_KEYOUT0,     NULL);
 
+	/* enable FSI */
+	gpio_request(GPIO_FN_FSIMCKA,    NULL);
+	gpio_request(GPIO_FN_FSIIASD,    NULL);
+	gpio_request(GPIO_FN_FSIOASD,    NULL);
+	gpio_request(GPIO_FN_FSIIABCK,   NULL);
+	gpio_request(GPIO_FN_FSIIALRCK,  NULL);
+	gpio_request(GPIO_FN_FSIOABCK,   NULL);
+	gpio_request(GPIO_FN_FSIOALRCK,  NULL);
+	gpio_request(GPIO_FN_CLKAUDIOAO, NULL);
+
+	/* set SPU2 clock to 83.4 MHz */
+	clk = clk_get(NULL, "spu_clk");
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, clk_round_rate(clk, 83333333));
+		clk_put(clk);
+	}
+
+	/* change parent of FSI A */
+	clk = clk_get(NULL, "fsia_clk");
+	if (!IS_ERR(clk)) {
+		/* 48kHz dummy clock was used to make sure 1/1 divide */
+		clk_set_rate(&sh7724_fsimcka_clk, 48000);
+		clk_set_parent(clk, &sh7724_fsimcka_clk);
+		clk_set_rate(clk, 48000);
+		clk_put(clk);
+	}
+
 	/* SDHI0 connected to cn7 */
 	gpio_request(GPIO_FN_SDHI0CD, NULL);
 	gpio_request(GPIO_FN_SDHI0WP, NULL);
diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
new file mode 100644
index 0000000000000..2e999916dbd7d
--- /dev/null
+++ b/include/sound/simple_card.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ASoC simple sound card support
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ */
+
+#ifndef __SIMPLE_CARD_H
+#define __SIMPLE_CARD_H
+
+#include <sound/soc.h>
+#include <sound/simple_card_utils.h>
+
+struct simple_util_info {
+	const char *name;
+	const char *card;
+	const char *codec;
+	const char *platform;
+
+	unsigned int daifmt;
+	struct simple_util_dai cpu_dai;
+	struct simple_util_dai codec_dai;
+};
+
+#endif /* __SIMPLE_CARD_H */
-- 
2.53.0

