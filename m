Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011040.outbound.protection.outlook.com [40.107.74.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010A3AEF4C;
	Wed, 27 May 2026 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864357; cv=fail; b=ASI74VUpezA6DQm34rRqWP6Fq+G/vzjZlNM0e65yOEpa9PBF4+VBMpfS6MfVZccXakfIm+Y6vK+5E/ldhB2HDGVWKmmjpLSMQ88Ybx2+R3NuGJql4g28aknYDx+WRMdWqCkw7upEnMasvJkR7gPcRf8zzrw5JHQQguhaSIhJS40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864357; c=relaxed/simple;
	bh=rzKAY6tZwb+hoflSEGojf73Ec3u1HidjfhX/grd4SxU=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=bDtu6Kms3INU4dcV5gD2YxTDZPd3xgG7NOlpeokVEsbSKmX88bDEHZ5XL3y3nbBg7LuILDvSGaaB45adZ1Z0aAnR6/DJplhUWrwXQgHgReXfizXXHQhgGAIXZaK71UUCLSlRgjHhvM83rHSPHJMaFXKWIhCwp+KOSchItDrrq5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=hJ4Uz4sZ; arc=fail smtp.client-ip=40.107.74.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="hJ4Uz4sZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ye5yU/JbIi/iEPBIdSkD2Y2Kk2A6mJA0+5GSOtQdJmiSMvpsK1Q7cves/djW4L77WtrPJOEzFvBeRlHnQW8XozN7MH6WkBUV+vWjf2cHf3Cq60kFe5AAE4ZTd45Kts6v95BBEqZUSFjDgKZLr3gWiYlW+qVweoPowm/zff7WRWMh40CdlhacMfthHEv8BEZtnE+QZ+Yc/ditCBBqCurzAC9ZpfhsJyHMbpV3mVfEow21fRZX8xPakirbq4RTc9qJbi0MoLEeFgrgjLV70iZyydf7/hS0pFIevjTaffz64590yYkE2c8REqG0q4spK6gb7hKLpKBQG3d0cYWdz51Iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p3mV4+3lf/Dmf09Y5C76t52SqlfgedaFH+CoG5Zkz0=;
 b=PtgkKQSS86RNyDf/rZw09Bxnr4bMufOz+a3B648j3BOxKf+FybiJ7c1RdVDU17M+SN4itI7fefXBhi4P1cK1wA/QwqJompAZxymo5axCwiPHwsPJsjL1WAuDxsbvWeST4TEUDBpOixwd2p6bWrnaoPspq1+VVcNkdm1PIrSg9Bcf0Vx1UyxaRH0GWBlvU9zOLiSMgYbQZKM7XecxOj+wDaS+SXJ8py8blzGjsR59x7i85ieXcb9evqAzXw23QvWo8eK12dZagB9tGAvK0b3EM16OlhnJNqM0rsZrKonA5Fa7rX1990YRFZHYhR36IXp6OTCz5dkgJiQoGPPFW5tVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p3mV4+3lf/Dmf09Y5C76t52SqlfgedaFH+CoG5Zkz0=;
 b=hJ4Uz4sZx2waCeqZSbWnOVEypKah4FLHYnI1prEMiMdSVL3Z7dwWv/KbgsK3S5Ks3yf3u3FAiL8MATWYATbYVjkb2V/fKrgH3giBaDZ9GuQQmBu/qXuykOXUwT3OmgshxnAn7avGft/2MM628j3EuCtkshhD87WJnCBc/uh/yOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TY4PR01MB13430.jpnprd01.prod.outlook.com (2603:1096:405:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 06:45:52 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 06:45:52 +0000
Message-ID: <87v7c9e4f4.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 3/3] ASoC: simple-card: remove platform data style
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
Date: Wed, 27 May 2026 06:45:52 +0000
X-ClientProxiedBy: TYCP286CA0290.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::7) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TY4PR01MB13430:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ced75ff-a198-413f-f281-08debbbb9873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8PxMmaBqN0SRAeh1vlbHcxtPRxz42sqbmgKB6qx8nLMM1ptllg2SZUr11pz0bydnu/EhORUNjLinwFmCjkfsaTlghQf+AmwwPLlcTkvFIx4cUbEchWjZgTetCi9mewZlZDMZi+ENt/6vwBhI+PNqqbF+CwcwJHh/HyN7+aDCOO4LGRoyOugip3qQF2eqIhcBOlx88Q0076MHzPM95BUhqNXhMaC5Qsk2kQcDSyLWal3k6jHB6WOxrA1+TG0OJq8Fv+HOMknZG0oDfGQ5zA9SYJZEgKq1uLuoy0bf1DqfH+3WG4oEAAimgx0EUP6w1Ezxjh/af0iQhLsf2rs82QIZpWeTVHdCoIbB6SA4Kkzo0wXxxz4aNWjvDfQQKAsF5aXRZR2tPpmUBznKDD9grMBlxzU7JVtJueQnSFrDEoemvJogFiAPCZrTLLUaG1BOTTG4u0TmLZYBViIrNQh/IcsySOnBr5N8dozWDkAvUtbcQwwvDd3eDhyF7is1FE0/ycw63QCbh2DIIAUEnBt50NmT9+2V42y6H9A+lNFQWON+2wcibDRbKgTl5QUBGvCIhUbpGWHch4hPnP2pfMLBfzpKLT42pPE0fD8kCjEqllzkLzfiHeltGa019qriCPvDLa2L+AvLEgZnTPmpfUBiei0kxwWzJslhyexa592EjUJ3H7EUF357dY9uUukLlqlDuOEqk0P/opy4w4mZjfQYcvLNccXapfkMbLX+jMAr/cAu7BjTocLi/FemIGDC4fr+JzZHAdLFVRmwwe0MhgZ3QSX79g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+BUVg1+vLZ8xzkYE64BzS5R+XJEcBvwgH0rGmSDVVstodnSLI6ymoWYCvGqx?=
 =?us-ascii?Q?Jsa2ikWBE+bRYG/IQyN8wfKYm+B2guE/aFfyUruyButBUuXchRKLXaoQxhYP?=
 =?us-ascii?Q?hetBau3z9jhahCOpHTvyQESVIUdJNWPkcGkBTJQkbzGMqK1T8aW6CkX4koXg?=
 =?us-ascii?Q?Yb8G0elLsmXqRCUvWHMsyWLm7kP0IHtOv9ozVDYogryoqJVx434YrlgYV7KF?=
 =?us-ascii?Q?vvbl2vzoHtRklAKMFfOzKomcYBJYwFRe25aFRtAqw+V8Z4JzantHjThYLV01?=
 =?us-ascii?Q?VWaodNMiXGyhKTkAGTL+cSNQvAGFoUfwBT7tv5LtLkO36VAwJHkXyeTIcCvX?=
 =?us-ascii?Q?pqwnSPykyXlyKNQ0n45hD2cQ+B6CkkY9cxxk2rQrLoBkmfI++RlefgwlnQxx?=
 =?us-ascii?Q?sbfBTNJ+IAcpFfX/XZyc+VoFYw2mCmr1wCrf7UGXPH2XA3oJBTAN9x4FT+0K?=
 =?us-ascii?Q?kaFPxBj7nsE/vCBNpyWHitcyEzU52tz6wwlj5ogPZMO1XJ6WcK9IyIjLznUF?=
 =?us-ascii?Q?SFVSQvWJvLcCISWF4ctJVCzbEC4kwLlOsqDt5Ajqc40lhFOEmgGfZDlrFhug?=
 =?us-ascii?Q?EfW6776uWA2yXLbofk9l1L40XMCkePKHTgTEcrZ+LENShxPVtCY2yCRgbtDs?=
 =?us-ascii?Q?6DFuYm+/IzHEILgoE5qiGmqLmlJnAZswgYaj+ZXyHfUa8mdnzuTVlf7daU0K?=
 =?us-ascii?Q?Yxi3tfHv2br6yGRljSGqzBz5VeUXB4XswcMM1xJU74pYAneQ3a03GZyX1wGr?=
 =?us-ascii?Q?KSVo3Y0mDOY+ynRklyGJUOk0uTbVf3GieB9UlwTGhpQ/D9jnm9thFbwUR5Uv?=
 =?us-ascii?Q?moIpyn2qZuMt39seJLdHlObLa442uSoFTcSQYpdHpucOhdu+PlieK+mYdRKo?=
 =?us-ascii?Q?oGwHwETm6wHzcV01njrkFa89Wp43Ky1oNV2n8zqjGgAxYsNn0hhjisw8MeyV?=
 =?us-ascii?Q?w3r/lHzjd9NStIN/nFghmK5MuWDnMdmHVaPD/drpXtZjpWSc6F2vk0A2FRmY?=
 =?us-ascii?Q?b8awe4PnsOE6v0GLGO4NDR+4nTugJGHwihvCxVlcTCFb3AI042qynf9XDrHV?=
 =?us-ascii?Q?aGaCNiD5wd4Vi+ksyMBpesqaUD/zhBU6caHuSxlzl65AUtB5ugJxZUaHhHFl?=
 =?us-ascii?Q?k+QMFkIYn726B4gA3/CZPiAvT+68UbLrjtLlysNaRBSmPrgyI2B5O3OrCGXi?=
 =?us-ascii?Q?e9AxjENUgENIQC57luLYgNwkXKh+5/wYn+SXDl/Sg+KO84i0xUx4GzLg/IZ3?=
 =?us-ascii?Q?OIif0iyFt36GndEHalJLI9hMMRpGN17O3dvAIGJ7vU6lfvtePywC7QsBMfn/?=
 =?us-ascii?Q?t95pZh459F0+ujiuRmhEqicCTjp7vNHYmqrgpuqafmfSAvG4yyooDno/tzpb?=
 =?us-ascii?Q?iUI0VpCgDsPWWbHsLkXkBCT3Iep3xFJJLxnDSbPNxu1aJFbo5GmCEU3E4qSl?=
 =?us-ascii?Q?Ljt57nNrQ9Lj57VZeCjXO+pY64c2oCdljhf6D7+f/8YQWYvyEtVeDfTBPXgg?=
 =?us-ascii?Q?2VPGrHJTnae+UxxtkzCbqxPVYvsgwdHHp7pIdfUv0ixUgUnZ2mDIwinon8Ae?=
 =?us-ascii?Q?sCE/HhHUDvXhoSRgFfVT97U7yGrVQdVxs5YP7fsIEpDt2gUcNmb7v4u/hm/H?=
 =?us-ascii?Q?G3FteG4coH7WhINZ9jsdVMjM93ccwivYalM4QGbg9A5wk7YQv45lQ1L0FtHv?=
 =?us-ascii?Q?/ii08JuMkFndwlUu4QPnaWn/5vP3D/YFjbG97sxdBdsBwXOSjUnUOzBVKJeP?=
 =?us-ascii?Q?yBhBxWaceEWv8rD2hf28Oc6KTGXRSm6x2QypknSqq84TEITwux4l?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ced75ff-a198-413f-f281-08debbbb9873
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:45:52.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1B8rYtfrLYDRkgeFFJ+MI5IterF2eKfUM86iuH5t3OLEXzL2jgh+xkxXTebhdjVtxjEfNHdJa1R95FLze5QmqvNPnNxPI6kSY2tUPuy3K+rhfxGNnmK1/el3CZy5HOY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13430

Simple-Card has created for "platform data" style first, and expanded
to "DT style". Current Simple-Card "platform data" style should not
work during almost 10 years, but no one reported it.

No one is using "platform data" style. Let's remove its support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/sound/simple_card.h     | 26 --------------
 sound/soc/generic/simple-card.c | 61 ++++-----------------------------
 2 files changed, 6 insertions(+), 81 deletions(-)
 delete mode 100644 include/sound/simple_card.h

diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
deleted file mode 100644
index 2e999916dbd7d..0000000000000
--- a/include/sound/simple_card.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * ASoC simple sound card support
- *
- * Copyright (C) 2012 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- */
-
-#ifndef __SIMPLE_CARD_H
-#define __SIMPLE_CARD_H
-
-#include <sound/soc.h>
-#include <sound/simple_card_utils.h>
-
-struct simple_util_info {
-	const char *name;
-	const char *card;
-	const char *codec;
-	const char *platform;
-
-	unsigned int daifmt;
-	struct simple_util_dai cpu_dai;
-	struct simple_util_dai codec_dai;
-};
-
-#endif /* __SIMPLE_CARD_H */
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index b24ba1330896c..b4957e0252113 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -13,9 +13,9 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
-#include <sound/simple_card.h>
-#include <sound/soc-dai.h>
+#include <sound/simple_card_utils.h>
 #include <sound/soc.h>
+#include <sound/soc-dai.h>
 
 #define DPCM_SELECTABLE 1
 
@@ -708,7 +708,6 @@ static int simple_probe(struct platform_device *pdev)
 {
 	struct simple_util_priv *priv;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct snd_soc_card *card;
 	int ret;
 
@@ -740,58 +739,10 @@ static int simple_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto end;
 
-	if (np && of_device_is_available(np)) {
-
-		ret = simple_parse_of(priv, li);
-		if (ret < 0) {
-			dev_err_probe(dev, ret, "parse error\n");
-			goto err;
-		}
-
-	} else {
-		struct simple_util_info *cinfo;
-		struct snd_soc_dai_link_component *cpus;
-		struct snd_soc_dai_link_component *codecs;
-		struct snd_soc_dai_link_component *platform;
-		struct snd_soc_dai_link *dai_link = priv->dai_link;
-		struct simple_dai_props *dai_props = priv->dai_props;
-
-		ret = -EINVAL;
-
-		cinfo = dev->platform_data;
-		if (!cinfo) {
-			dev_err(dev, "no info for asoc-simple-card\n");
-			goto err;
-		}
-
-		if (!cinfo->name ||
-		    !cinfo->codec_dai.name ||
-		    !cinfo->codec ||
-		    !cinfo->platform ||
-		    !cinfo->cpu_dai.name) {
-			dev_err(dev, "insufficient simple_util_info settings\n");
-			goto err;
-		}
-
-		cpus			= dai_link->cpus;
-		cpus->dai_name		= cinfo->cpu_dai.name;
-
-		codecs			= dai_link->codecs;
-		codecs->name		= cinfo->codec;
-		codecs->dai_name	= cinfo->codec_dai.name;
-
-		platform		= dai_link->platforms;
-		platform->name		= cinfo->platform;
-
-		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
-		dai_link->name		= cinfo->name;
-		dai_link->stream_name	= cinfo->name;
-		dai_link->dai_fmt	= cinfo->daifmt;
-		dai_link->init		= simple_util_dai_init;
-		memcpy(dai_props->cpu_dai, &cinfo->cpu_dai,
-					sizeof(*dai_props->cpu_dai));
-		memcpy(dai_props->codec_dai, &cinfo->codec_dai,
-					sizeof(*dai_props->codec_dai));
+	ret = simple_parse_of(priv, li);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "parse error\n");
+		goto err;
 	}
 
 	snd_soc_card_set_drvdata(card, priv);
-- 
2.43.0

