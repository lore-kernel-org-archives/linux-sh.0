Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010010.outbound.protection.outlook.com [52.101.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFC717A305;
	Wed, 10 Jun 2026 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052568; cv=fail; b=lN/d8uffyYDInEMpGWH63WHcragTmyt5fCO7latbgQLZ/VYQMXg4EvCC1gXDc+6NDWqJ5gKog/AIMvye5IjVJNhaMC1IwncEsLlT54gn6N5s7nvhZhb/Ab/hzJ+ogBvlBCcBOcWHlWSZF5b28Y0q35HxDCWy3GFbJmVaA3G8GtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052568; c=relaxed/simple;
	bh=NptDcZ6KK4xqHSOXeWXuKYKGauff0tjt58zjbvEg8J4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Kwh+mcUOxeCcLtKsb2B1jtWHiXWkx8jT6pMsATUxU+9UiSVmf+uMcUNpV53T74hjiEKsWrU7UHOeRI35UbUFTfA0Rl1vclGxRou4yEBE4/Io72sv9lQxFFXwmyTH82hJ+cLUvR7YmRU53Zz9KmuuW1VPPF8L+R4EWXakBWBil4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=bE1WQpjL; arc=fail smtp.client-ip=52.101.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="bE1WQpjL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIsRkgQNWPQ1aHBgUKzBdR43RuegsHv9o16rcPgOjdHjzl6geJ8dIWitCnqjMjtuHKRNMDZZCpE7yBf5ueMsNFMYRbX3a1nyVlnN0I2tHEgbX/HLUzHGAId+Ine8FwPL2mwdbMYgMjx+AuDZkcqMcVbuetX6NZUt45SOvtfypXQ6qojUXsJ2hEkJ3MsJ/kLrefbJhmKqDXarEX78KoY7ryUEOUMZqOeIOJhwy352hx01R3BWy3R2fvuejJqxxwIsMMl2nuBg8wZEzSm1tZ3xIq+UHmBHfrWdAnIPbyGM0n1tcvjKHhP+8/a3lETBKtgf9AItSHccqb1hVjJD2JIX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p241W7zQjWisOY3dWVbh5TaRJWyFH9KcKwZGzQjYYzg=;
 b=ZNIuWvfVta2ogmylUjBym3E2CBBo7Rn0lUEg1bN9qUqbwHSkVEKB0KCecqX7hg0WyI1kYDBKQNsXETIi0u1ZMX+JDNZy9pzjv/7HOFpKlhdUq6Z1J6EdTBqdG7tkoJpwCI0Z1g1KUgREVTZwu4nBHDi4rNN9p/CiwZkdXItULs+YKtmlTh5zIDnlksdTAFC8k9c+FLlTDDYW+FOVeZQnrWG/mZ6dBlaLiPGHcc5tqMvs4emNSu/yXsbwZnHPPgiodZbnPPGe9w0NxZLqgwh5RNnvC9PD9GdY+Q1+8I7ttOXTzUmOAoYGz/g/EJBnOLDv97zk9RxEu3/B4RhcG577/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p241W7zQjWisOY3dWVbh5TaRJWyFH9KcKwZGzQjYYzg=;
 b=bE1WQpjLtxhAGVNodIysEoOZt7ENJXDbsRdnltR+jZlUMZgUEsI5qVX5b0wlSvIejNm9+mM+QK0f5yyeho8z8B18hxmfHivM2wvLrgvuCgGNNbI8d0DtOARP581VmYPKAUnDmqw5iTSVrtISCwc9vAnHC0kE9A1QOJ6tHkBApNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYCPR01MB12042.jpnprd01.prod.outlook.com (2603:1096:400:3e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 00:49:25 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 00:49:25 +0000
Message-ID: <87tsrb43u3.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 2/2] ASoC: renesas: fsi: remove platform data style support
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
Date: Wed, 10 Jun 2026 00:49:24 +0000
X-ClientProxiedBy: TYWPR01CA0016.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::21) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYCPR01MB12042:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ca6762-68b0-4ec3-fd37-08dec68a1e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|366016|7416014|376014|1800799024|38350700014|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OJ5mFnsGnuQe5xLVqQ3aWqSwJDFRwNqo83unwCa/MCJCW1Nv6lxta5sgjSuNu9hbpK43kOTxkZq6dXv43iFoi4LWtt0fnwR0dUHDC+tyYk7+xO80yXN+Ts3ZviWauWpVXS13Z31PnCNS+tM1A5FYL1l6fjQARJeYddx23iKEsEtGM0JJXIWwJdfepA8ctq3tFBWWdt154GlYYRCYQ9A1y9/bctvT4xP3XVFBsnYDJP+o2yD+ZD0BZ1mSOKs6HhImk2bvzoiMeHLJ6jPa2CIk/PlKwwzTOCAgpE2sOEYkz41UIaKLNHQGgHyj6+1Zn8kec1zQAbyaMuJcrNhDs4r0b5yjPBONkqPyj6vr0Ao7cTrkYrDkz4t2wlCDUGT1PTINT9LtvB8rHb+IU0EBEfbdqSNxm9PivVf8OANGjaaeUqYjQeGsGWwzUPC3Q1YcRJzBoTdhI4sA16vb5aub29+Jq7EARlib5XuhLD2RlKjZZEVWr6Wz9PUy2roAYitBwpAbv+FTT5G9HYmrRR6Nc5qBmlrtn5HnBmPWH8sG45DHv9cbSZougoVo+DuWlwD1tt87xcJt/3cEFRKvLRPxLsrKmTjJrWbtdMD8/FTQ4TZ4jR3SKY0gFEe/8xG4eKTCmneurX2Wf15M6ZpQiB2jaI0UYItwmxdbdZ15ZuIyyAdSWYmHGshW7FCclm9edsBlY4F5u5HJE0kRo3oUwaI3APOkCXRjH0ZTQKdw0Eynjki6xfV902JbD4NBtEFVUNUWCIfpGAvyEvWxEG+1aPb/zFqKfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLriBPZ2DpmWSX9zkzfK9NLCfCmKKIkf7i7FNlZa5LuEE7Ik9fUQAcL0r0ju?=
 =?us-ascii?Q?ZD3NukPf/cm1aA6gb04xiWfP/QeaR6sQcH3I8kuzosWFPjiUbw+HQ5pu/EX2?=
 =?us-ascii?Q?0cpId7xGdYVXbuTrSqYv2d8XP4epyfUTq8rxTBBKaNlQuNd3Zf1DfUU23xJa?=
 =?us-ascii?Q?EqCIRwicIO7ST5Fjra18hmQ0nPLr+pv1Ss41bQi7sBjop8XGPIh5SKjcPctF?=
 =?us-ascii?Q?opmWXh5jonanROBDgUx/D/YA8EvyRTFF8di+7gafOuodYepd4Ow24d01dF7h?=
 =?us-ascii?Q?Z5a7btsjWnQ1I3Ka3Wn7jo9hmxMFLy2VS7WtjYKO90dxAglRKBfDAjJLuvpH?=
 =?us-ascii?Q?gNaK9kbcJfDx3UuoFNANSsy6uPdYgRQiAQGjJKiVa+LIgwpzSfJf86BeCO6T?=
 =?us-ascii?Q?6rdtAp0oJoQhv6Ks1j3ZECYFu9/pRO/KsJpnBsYRfv3pmiJEDHeWrCgTAjWb?=
 =?us-ascii?Q?3xGkDJKKYqY3uvBcqZzT30ZaN3fXhTV1/UjTCeJx3iQnveF91b5NMQ4Qf9si?=
 =?us-ascii?Q?fvQx9Fm9WB+T3VzvwcyODPAK/o3+uelpv7bOpQQB9igJY7Hf3ahjxPju6Bb6?=
 =?us-ascii?Q?wQLTuksjV0rgra4hFPIy1jaEbFlAty63PUQGO/RUc60w/FFumPxEkGZfRD0u?=
 =?us-ascii?Q?DC6S/Lq0JDWnNX1biRI7odBjOIn/e5uGOLiJZkSBVNvOEbfIg4RuDXujYLnZ?=
 =?us-ascii?Q?s1o5lGC5Ivpg02ljJnGoihqK7EqGrOGBluR4sG00LvYWgQNp6g9v7SkiNRLM?=
 =?us-ascii?Q?z+amFWgNCt1d0WnVbtmcCaNYJo4mYKuly8V4o9n0VQaZhjqJlbAG7a01XRIp?=
 =?us-ascii?Q?rOSw6JdbQwlAeaeGY3Dnm3C0XRTbZ8jeRvgVwm+Fb4CNlB+4NnD+k6fN+ecU?=
 =?us-ascii?Q?gj4ZFd9mPRFXAMLQaMqJFBW9OkK/O3la+FNAEzeiebpuwUW4XC2Er4++gFgs?=
 =?us-ascii?Q?PGhAcQyq9v0b9QzVrs9WkZYIFREhQGB5z6PysOH7YgbA/YUwRvKsw2mWEkFD?=
 =?us-ascii?Q?jmJXSu/roSaVD+EsjiEC0Zvpr7PWvcONEznWWpLxhiBNm3Vu/jRAs3iEhb2x?=
 =?us-ascii?Q?lctXr2MBQICWdlFqpY4oVjaU6Tx+r++K5r/pFYyzuW7Vs8DJ72gl29m1yjgp?=
 =?us-ascii?Q?TsqOwS18SfamBpNDqASbN4jZxVqR3LaCSooU8mS9KX+t6fNdlE7GjTmUlbdD?=
 =?us-ascii?Q?JPTzOSO+pJWNb/dy+1Qy/xb6yJjTZGRKJdZGtEC5z1UmRi2X9MdxqqWKDAfr?=
 =?us-ascii?Q?XV8DgRK58dStHrUYw7QxN6aYL2owmsDypN027ijCG8mXEsPPbqaPlcw7+xfx?=
 =?us-ascii?Q?oIOfX9sYPByl5eXwRcYjdfAEdhnjZ+hFytAcBFNVGnwUvMrcI/yhnavsW9VG?=
 =?us-ascii?Q?368wZjYC7LJ22wjsu6mcZNUsODXCB41Xn21SItG2h9hYBdcAvAjd/Gw4n7Ts?=
 =?us-ascii?Q?+tT7oVWKiEF+rgg7NvIo+2xYFboafSIAM8rSxDa9vLq6XqAGI6dUgo1uo6eI?=
 =?us-ascii?Q?usfEFzDVJtv6MzjXipIxMSzqbMA1NRrw9WvfXcPhUZ+lNyWgpr2RmYU5N9Bm?=
 =?us-ascii?Q?KLSp5bF3TODiE2VNRoz95fo/pA3Cp40+8dK/RTCU7YTS8ghyAEMQiVvP0Lci?=
 =?us-ascii?Q?rv/bO0xFyW8eUY6KUntw/7yTZaMGq/mJ5IGqIBpT2VMU8SJOb/ZrT5ySr/RQ?=
 =?us-ascii?Q?3ihipXPHmBu7Azp5Xe8aZJmM6Qrgo5osaQnHafjR3JMG/yjTRkcjknZfyIWl?=
 =?us-ascii?Q?KT2kQz06Zxh66BtzKFrIGmCYz81vfg7aDxj3LXXhalC6u0XQkuY4?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ca6762-68b0-4ec3-fd37-08dec68a1e48
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:49:25.0888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v6DCZyWRaBXdv6HBxH+bTyilYQGLiK/fh/ixTmqwEObxOgtK3k0IxY/ZV24COj49E32bDRWOX4MoGZw6h59TZmDIRVcgybij8SWhYJ8HJyprcrEfT5qISKG/yKwctS/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12042

Renesas FSI driver has created for "platform data style" first, and
expanded to "DT style".

SuperH Ecovec24/7724se are the last user of "platform data style", but
its sound should not work during almost 10 years, because Simple-Card's
"platform data style" is broken, but no one reported it.

SuperH is planning to switch to "DT style", "platform data style" is no
longer working, and it seems there is no user. Let's remove "platform
data style", because keeping compatibility is difficult.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This was included in 2nd patch-set.

 sound/soc/renesas/fsi.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/soc/renesas/fsi.c b/sound/soc/renesas/fsi.c
index 8cbd7acc26f49..8b8c704ded2dc 100644
--- a/sound/soc/renesas/fsi.c
+++ b/sound/soc/renesas/fsi.c
@@ -1923,20 +1923,10 @@ static int fsi_probe(struct platform_device *pdev)
 
 	memset(&info, 0, sizeof(info));
 
-	core = NULL;
-	if (np) {
-		core = of_device_get_match_data(&pdev->dev);
-		fsi_of_parse("fsia", np, &info.port_a, &pdev->dev);
-		fsi_of_parse("fsib", np, &info.port_b, &pdev->dev);
-	} else {
-		const struct platform_device_id	*id_entry = pdev->id_entry;
-		if (id_entry)
-			core = (struct fsi_core *)id_entry->driver_data;
-
-		if (pdev->dev.platform_data)
-			memcpy(&info, pdev->dev.platform_data, sizeof(info));
-	}
+	fsi_of_parse("fsia", np, &info.port_a, &pdev->dev);
+	fsi_of_parse("fsib", np, &info.port_b, &pdev->dev);
 
+	core = of_device_get_match_data(&pdev->dev);
 	if (!core) {
 		dev_err(&pdev->dev, "unknown fsi device\n");
 		return -ENODEV;
-- 
2.53.0

