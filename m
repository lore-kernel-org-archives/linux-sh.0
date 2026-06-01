Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010037.outbound.protection.outlook.com [52.101.229.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B0BA34;
	Mon,  1 Jun 2026 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780289420; cv=fail; b=MGRwdOxYGzyIR5vVTe3Q0Kdi03pDDW+vDOAe0NcCZ7uSdmeA9fzyzZsYyTzprrDdbbsR+TSf6fif6cL2hnrZFGeFFbM1sKuU/N7hgaRHJOMT+P2hfz0N01RKMTLfshm6zm7KytRx+SH/bot5O2xwMURW9QkzIH+kNUeAyFuF1uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780289420; c=relaxed/simple;
	bh=z3/SQSo+WmFTFA0zA+kxvnq05QCVU200Zqt+u5asjd0=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ZPSReUGegH2oUaoEdJxtGs5je5xt6PjOTBdzH0Ga0AAO+IDPXyoEuXjFrT2eKqai2bOn5bZD5IpSgiugEL4zomRjejBgsv6KcyenE3I6vimrpFmM0JWPdnXdo+j/XowFBDpLsorzttDsR6kWxdm2yy2ej7uwJdnMZyg9W372Fr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=TghcvUgv; arc=fail smtp.client-ip=52.101.229.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="TghcvUgv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnxaOEt41UsIzQOOyBJzD3sqcd8ymqIfIrYaPehX0MTSyC6xhlD4zV8nEus7+UOEENIJ1KmsiKmY4TcIqrRw9kKDXVzHavwbBi0ebmqXv1dNCgII6jRj8BofIvBj9brJiBr1qTa31zvqBXUnLB+0Qn4Fhl5BzpgTm1f51aLKpNKAD1H1idQx9ENpM3PsqFer1rvN3IIRGPfdQC/H6BkI3gh69RXB6mOzJsD4crk5gq3ifdVhSm4JWKSy6o9x47zK3li4pGbJ6Jo9Pvm2Mm1QikTtROPjCPxvkCXgViYmkD3MpqDIZrXQdRcMq6HJ+nq2tArAsoSi8CubFKIeC3hQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN1hnmcMWuc4uec6uVmWxJnarsRM+HMQg73ImIANSCM=;
 b=L8Ap7AINibVCyWUp5vsuaFJUxbMpuX8pkKcZLCHUdaUNdopeeUOGRqg+kYq88dFUPNXb4GTqZQLb9c9nv+PT0kU8AO6R1GiZIJ3A5TgI8DRfQOwNc+p/cQ1G55aL/W7AEw2SBvETkXdtDdELy7T2+Dse0ae9Zepewwhg92Z1gkB+RyHHYaVZEnQ1B70TRSKmlOAU66VoVRqFUfwa4kzkvHCxWSGhzUgWdjnBORcAnz+R/RLF9FZnHyQbB2RcTdMQGpIPMBgg5fDvoiPpg+DwEqgn+n/CFGNR93llsKiyV1lQXn/NWxOC+9KBKzoBIegm3q+yT/ZglIlSuW8T50PNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN1hnmcMWuc4uec6uVmWxJnarsRM+HMQg73ImIANSCM=;
 b=TghcvUgvSTLsviBk+IegQtSqmAPWFO1L+rohpu7vWNJZCpshk+kPjq2KYVcB2pBW5FHTF1WDTRaOpMveiKJYJS8MheBtXVaWvMm3NYeespsfQVgZYoXM5CrLIbZtQfhLLbhjLQr3rUZ0LgDT4w6wi99kzi1oxe3BP5Xw2O5h3lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by OSCPR01MB14869.jpnprd01.prod.outlook.com (2603:1096:604:3af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Mon, 1 Jun 2026
 04:50:14 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 04:50:14 +0000
Message-ID: <874ijmc1a2.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/2] ASoC: simple-card: remove platform data style support
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
In-Reply-To: <875x42c1al.wl-kuninori.morimoto.gx@renesas.com>
References: <875x42c1al.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 1 Jun 2026 04:50:13 +0000
X-ClientProxiedBy: TYCP286CA0222.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::9) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|OSCPR01MB14869:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f571f4-673a-496a-b4fa-08debf9944ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	cTTtPXz2PIgzXIT+CwLoeuq1z/ucGq+Lngukmak/sbdj6m0eJoFpQ1iy49LBVfuFrU2eHfjK1JnsCHeOtXYmzVDJOgjkUovD3kD6H9srkxuwmNaapthqGAnO++1w6YVtjsPaj5PbRPkciAAaUyEvw/gTGVsYhsXK+4p9U8L84gyrRPDGxRowMmMB119x/43TuFVrtGcaxztoQoIESZZxZ0kkLKgeF+U/NA2jDBFWVSHeP+LZnxH+x8QnS3+VHhWz5Pa9EfOw4bsU8z7Ioh354II6BLLJ5zDVJPS2ptjenRUqcx1xx0vhOfFK6FxCZdZPO01/ulmk/aeyNuBcF951ZOhCvqGepC+t/EXYuYvcPrSCFKZegEC09BilO+Rnth8Iwz1L9xH/k9XHVX+naNLqyYjriHihjus+E/f4+sE18pBBFrSea7fwh0CGEv5SlEuTBlJVbV2t3UL/x7VuOTZs8X4ANG7NFfsFJs9HNPsPZ8N/HQYd8Fuz8N8A6B66J7IIbxwINuGqVG77ivTjY+ZDJ6rZ71iKkOyXiDTofT86mUe/69Jl78O674xnWNDs1oPAkJJUq5LH8XHoCSbVbNwHKhq94jZFVSEDPXnHPNmNNe23x0cpisVfCTbBY+18u/DPQrrMp4W9ISmT4rfK5BNcCyiButHydEE2Am2LArdCeLeOo/h06nXnwmf7Li8vB70bskjXCV6jfPBZ1H2CxtG9LYts+nytUHDmgceGMNZwvpBMs+8MFyQiL8vxfJ6BWUFH+71cYl2UtdsXy7N0SxbP1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FU3VsHC7xkub1vjS+cPoSP/T6rcumMJ5EZ91pMKDemwn/+ojyl1ZQqHAVhYJ?=
 =?us-ascii?Q?tM7yWFm4mx+/paX4czwJPSvFBeLslJabwWgMbXNeMJdqawvRYd6nk0mmpziT?=
 =?us-ascii?Q?vWYWFY2aErsYI+G1tdNJdgahu0If3dGHwknTDeCIhwINKXZ5HJqL4nC0hw/G?=
 =?us-ascii?Q?ooVI8GpoiKE+caQtMCYgHoLOF6GIL3nMI6vfhYHTIjJLsMYfpFRrKTs+Ayge?=
 =?us-ascii?Q?jDzxa6IhaakftnNzsFgzWpXHBS5jBXMVYr0ahpq5wVYomNmOO3Ch6LyrBsrC?=
 =?us-ascii?Q?dDbCx3XiKnted9vEIgvGZRDJSAAv0VSxwoFhRvTF3X6uB+4xOgSH1RmcmRZj?=
 =?us-ascii?Q?mUwqYR1vkiEnGjy4F7yrwHT33phD0zN6ZvHmzsS5Y4KazbxOm/dEkvEyBPLp?=
 =?us-ascii?Q?VrWaFZWc2Wm2zne3et7i1fgvXsF4E1i1Qjw7V3VSDbfivlbLmy/1xgw9uG5X?=
 =?us-ascii?Q?sBv++aFN2I3hVnrefzabXT4KZMzElL+kjX5Do6xgist9KyHcAxn+yvERAkR/?=
 =?us-ascii?Q?FjuFVT6NrMJU2EAG2rmSJSNhJS1/YbaUNrwLhpfEYM917Xb4LwJu9EqvwHn8?=
 =?us-ascii?Q?ux+rwIlik/vyapn+/mfWutXcbOKlFNHAYNILB7uN+4CD/r2XrTj8tjbDlTSU?=
 =?us-ascii?Q?4KNtxq027vRe4et6xzsQ1KAInKmMAW4xZb0C0FnNMJ19FOEQMxUPvAYrKQhp?=
 =?us-ascii?Q?mmCyhro4Ie+RXMr8uQH6nC9ddlodYijP5Dus5lRg5IdKkOiPZQ/YaVFGqdXH?=
 =?us-ascii?Q?8yv2O9nEp4IevuUEQvPk/PUfMjp2KyEqrosgnZ+dMj3Ml2cv6UQdROUeGQnw?=
 =?us-ascii?Q?LD5FD2k+bl7fPLwGya1UvIk2bFYk7v1vMaWAr8WRLvNRUrX7uGl3viYwowBy?=
 =?us-ascii?Q?aocNKRfcngZ0/DS3kxZr+BH/eSb9c0eJ601asYS1Zsl4M/IWLKgR4Ku2EIG9?=
 =?us-ascii?Q?uFHpmHaTYv0J/xAnufS7JHhQVXI6IKkezy3vms0BCoFNOQ1d/p5gUXNB0tn6?=
 =?us-ascii?Q?bjgc6RxaykB10n0aWwZmMZ/6DNvKlOCDsDCeKWYo+nL9JpuKCSKmvIXxcujc?=
 =?us-ascii?Q?pQ5bZ5YdepZfvUcOOWxyMjS5mADa8PCLuafCJPhC5tGf2iy370b6bUU2cY8f?=
 =?us-ascii?Q?TTfJC84qXgLK+PjSwifvZ2Dt0z9BQbcbc8c/rzIuzo+6oYz+gJLdDLayx4Jq?=
 =?us-ascii?Q?yRoltDCury1fjwhq8Xw8DrGOu/DdrnQvTJOLGmfgqpJpANGuUtXizHKDabPQ?=
 =?us-ascii?Q?ohKjS+c3lol+NScmwburg3irwgW5U0XV+m+EYvSy2z1IR8DcbyWeZtUUCx8g?=
 =?us-ascii?Q?iXY/BIHgledDY3H7OuAMpVK6xvkoltZ2mHTyyPP5ickYv5J5rAp4cllMYI+X?=
 =?us-ascii?Q?/HfqWKsEJh/S8PNpkMds33R6FwPgIB6Nuy4wiqClQv+Y/RAfFxrd0ZkxZrny?=
 =?us-ascii?Q?hd/pBH1ryNSsNmEhO6ypuBmLvlfq5VuJtHihfYcSQ6tj8bb8g0bMW++aMkmQ?=
 =?us-ascii?Q?U74YVTr1aHnPZgViWFPSc2s5hqe635+1TsKcBiOAou88GhHQAr47InwHSHEA?=
 =?us-ascii?Q?EPI/YLM01H5TYDitcYoosZLUomSTEjW5IC+zxsI9DK7FNSTkQTOkK2o9XPXl?=
 =?us-ascii?Q?8pTlS/sLoPv2oL7fTze/U0nY8C1Kfgy0acyopK/vqt0LjvWp15JlrnqODMoJ?=
 =?us-ascii?Q?/xQa3/+aIObQb3XiJPa78QCXRL6Mk5y+lcq1SSAg5P+LZYf2gMJCHZawVK4U?=
 =?us-ascii?Q?GRWv03JtLn1ezwol25cyKR2dIQduirm+TmkpVjnfMYcoHkOjsmk9?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f571f4-673a-496a-b4fa-08debf9944ea
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 04:50:14.1617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAaSBifkj++cNPeguBKc4WM+tf7tZ5FPchaPRL9M9XEzS4aM+Pw6+lpzWcM5GfBnup4bOo+1sqPSTgE1vd0mWprM/N1qmDJPO8lSh8I2JEoE8oZjMYxxOjftMyLbZAI4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14869

Simple-Card has created for "platform data style" first, and expanded
to "DT style".

SuperH Ecovec24/7724se are the last user of "platform data style"
Current Simple-Card "platform data style" should not work during almost 10
years, but no one reported it.

SuperH is planning to switch to "DT style", "platform data style" is no
longer working, and it seems there is no user. Let's remove "platform
data style", because keeping compatibility is difficult.

Because Ecovec24/7724se are still including <sound/simple_card.h>, this
patch keeps it as-is for now, but it will be removed if SuperH switches
to "DT style".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-card.c | 61 ++++-----------------------------
 1 file changed, 6 insertions(+), 55 deletions(-)

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

