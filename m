Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010003.outbound.protection.outlook.com [52.101.228.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE389EEBA;
	Wed, 10 Jun 2026 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053336; cv=fail; b=Zufll8pGfGPXCpImFArcBrFgmxsBPG2OKtlfP7fzZzqV7uJKKnBx3k4Uf2nzZRLLzZiS0MG+G+oXkg9JbSebyV9Z2fMA6K8nRyTMRZu0YMC4+RSz9haKMPk6tKw/tmyRHFPhAT2F9rHb4E6KMDYMK1DC4i37kn8oZswb2uNTfDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053336; c=relaxed/simple;
	bh=6NgZHwkMQinsigLdu2x/OX2uWV00/fpf+k3MJ62qd2s=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=tlpueNKYv8+ZBq3ClGuXLbskOK3LcVYHe9FhIff1ygyqr1oMfEK/sqB0jXkwO+SNk2XitxfYegbq9r8Z0VlELbRaQO4LAUWmDvbRsjKp0TbAev9zjqrgC4bvXAF5mmGdqi8DqWUVeQ4vcgplR59zr8XJzHEAyDQwpNOt60KWShw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=BomOAF9f; arc=fail smtp.client-ip=52.101.228.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="BomOAF9f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRNiyPubSAadC2QKgyAiYrEz1PrqeEqEXzRR2QacnN8h609NzmeSokUIiXr/Gmo3Il3arpV625ummrlpWNOdEd94TYB+XyiK+vAvWtawO3m9P4Wgo6JTCMlad0MU6NhVOKIPXxpXw5Ek2BXm8Bl+eGNfc4T3Zs/BIP5Ce4Apq0AITOzyoL+Ek/AiVdV6PGzBJ7nmZoIM6i+Fi/2NO4kuTiXobca9xTTZusqYLTRSNSl6rEfKqmMN81Mk5YSBhRwjkIFIaT2/rtx8e0f98RYA/CMUWnWZaWPrxSVYMpsFJVwbJaNx8szPPNbbIBAJ9ksOc3++MeH3um6IXpqtBH82pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaXhdMI7+Z4K++eOYSFh7ZNL39IYduIaMOCcMeBNDRI=;
 b=lyCf9UgYci0qdipu5m7dzAP8qOlj5+lUtH8Zsx7ogo5u/VtZ84exkAa9J1lFYdS7RvcFpyzyKNAiIlFR6Gmhbp0x3IEgpXAR1dVYZpGSoeHaaDePvdfwWcIl71gt10alte4uvGF5mppZMSDDLpC4UKOEt5YkzUMnWGkIxOOyln2FckQ+CfpnNv9TYodD81sf7i4Nhp3KM5Qt52qxl4Ygk9CBXEY4BuXs//jxXkUHdKHtZwOW0wVaafNPTw3l/Jr5nG8no2rUmWwgLtA6/OhR4bV9wzH7BaY8Q2+aBawk2jH13shcV7IR0aZuTu2HbOekyqGPMUB0vcdoa6VOI2c9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaXhdMI7+Z4K++eOYSFh7ZNL39IYduIaMOCcMeBNDRI=;
 b=BomOAF9fVavgHPjBDn/qo75oK97WP9IQfhI9HqUkorndFHAcsVV9/UZ6/sGZ6LNl80WGqZPkFhhayTSoGmlV0tPX3zTYSSQG6UKH3+LciEmm85SHbR0bUXLSh4a9zCRqFQuT2fnctWA3tApWs278DxwKHcK4QMqMRlPUImSxC6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYYPR01MB8046.jpnprd01.prod.outlook.com (2603:1096:400:f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 01:02:11 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 01:02:11 +0000
Message-ID: <87se6v438u.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mark Brown <broonie@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Takashi Iwai <tiwai@suse.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: simple-card: remove platform data style
In-Reply-To: <87y0gn44zd.wl-kuninori.morimoto.gx@renesas.com>
References: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
	<178094130630.20828.12708103059145547835.b4-ty@b4>
	<fa7d7af8a780c27f85e29c518ba45e39ab18abad.camel@physik.fu-berlin.de>
	<CAMuHMdXVWPxu-5BXAgWOBoWdNXxZ2zeAfTovXxftXsKuCUUDww@mail.gmail.com>
	<871pef5l0o.wl-kuninori.morimoto.gx@renesas.com>
	<87y0gn44zd.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 10 Jun 2026 01:02:10 +0000
X-ClientProxiedBy: TY4PR01CA0120.jpnprd01.prod.outlook.com
 (2603:1096:405:379::12) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYYPR01MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 515ad942-374b-45b0-3615-08dec68be661
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|23010399003|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	gYDneOJUTR3QxcYEvh349PIBQPmf+DPbK+DKHOuSTYiakEAfHPD5jEVR7h4VVKXJT4Bc5FgPVfx5c6EguWT0IC4jnneGJOA+mLC8FU8PbEBPWo0ey5drcgzdnROO0yulOsrVSJ+vQ0EOJnNkjS7cs92GcZw3vLxFmz56fhAQgBWAGe5GKySU0Ia6Gkb2HNouskshIUBZrwa+/aIyfJiaS79dKWhdoyHjxyofnGBro+KrmsLT6iY2oiez9q0j47PEQs27kvjmegnlOBFpPNSz2kmwTTBsRsH+V9HyQjYA4TctGbAYlfshp0bz8jg2+YxuhMH8Vyr5uMTY9ZGVZUyZqiZMHD2diskF5EOCZ/zYy+gP6Fyzp+gUPepKqEpe+6q7VYGWZcQKx7ECX5/dmua3Umrv1DiParLy09CJ+q8TiDfK/P/5LNy+Thwm5BTZ39jsjhDoqJHXwCG2iSD6k1xgbi0fF7CgwzEd+UR8CIXTWpXGCGrqVj2/vqLEDG4aJIFB2rD0c7c0OHvDttlHplNX8dN6bKmMXd5ZA7MeQkgIYCIu63GmspHjEFtJx+9eg4hZN4Yu+aN7QDLOqW581jl2YEOFR9QggOzrsUxbcoNOPy90+mN3P/SSsVkWlHC+7zjsIPn0i6gD9kpYPdcTdF25to0pb727+fsZWXk2x1+ZgQIyMGLNL8/E6EtN62l3p91ommsTyi0ywiOyt5KOWv2EXHxrDJCwTsR1qrnou9yZXMB5ZEcclZxjmwmRx2ovSsri
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Z2/qxZ9d/GJhbd8allvTmzoqZfqQEk/enDt8ZTNfLFSxustQvXOerKGEtzT?=
 =?us-ascii?Q?3vxQBb+3VmF85zGvbUxChtuqgs0p44G6sXOGRPACNGabwgQGbuJsWS7Or9r9?=
 =?us-ascii?Q?MjyohgTlng1/MRNDTL8LmnfXCYxXP6jgevplHYA78VMVTm+07BiM04elsnTK?=
 =?us-ascii?Q?Ua9XUKdDxISyaBHTJDPE++Glh+L7lTXS7kNxVRQttx54KBVkyxG/GIrtFMJm?=
 =?us-ascii?Q?pRpfpUzNcbTZfbRPlHGBd35b/wX+9BT7C7LbP/N+Cry2CFtkGlDBGvHPCz1K?=
 =?us-ascii?Q?4qYRCYuOqsWvPsbYyUOlsCvI68oytgJoM7Z62nJUgR3Vt9TTEIuh2KK9BtSW?=
 =?us-ascii?Q?r9czSIGBnt7fcWmUBKip+joBbXzKZyKRHvNZNthiyB1XMXqhloaoI0kI2IT1?=
 =?us-ascii?Q?SyKjbmFjzGlze8PbK8CmCIc1fJpX25C6N+RbeUxOgmz7w42fRAmjaysQREHM?=
 =?us-ascii?Q?Z/iiS+esvv5MmWNYELqH+AQVOIG7Z29ICr4JGhejUQggt6emos+zQc02QPRI?=
 =?us-ascii?Q?XwzmYeJ6MDqmnZPidCi2X9ygyUCSfzlpc3fb3lqmQZQXsXcLRnDK2jI9J3L5?=
 =?us-ascii?Q?jgQGlGFRqrdL1lIq4d7Kn617DTS2lizLk+Uxa+Er7o02XbesfOZdAKrqMgSb?=
 =?us-ascii?Q?CMlCb3U+hcqgY2WV6vXwiW2K8z9gYbs6PBkpvK+v3T3I1moqjd2df/FdUy2z?=
 =?us-ascii?Q?qWM0K6FcKAVlSBGOPygQUHIP3DsFfgC6jCiKy3eDYjt6Qp6oYh0r4qQFby5I?=
 =?us-ascii?Q?pCGGqhwyR9FdCsTwM26GKbmIx10/QZIYSKSWaidLTx4YS5EzsqGZo5mdCqDj?=
 =?us-ascii?Q?sgwc9uqHwcxhSX+dTRMC+HlyzEIULFC+zrYzxOP02H96q3tp2AUVLAqgV4lN?=
 =?us-ascii?Q?uMHjZuzHVnsj4vTe80ALRmwLlwYwdfDlY71m7F+DT2zoTWigmPUVhOUa6/ot?=
 =?us-ascii?Q?NeIm7qKuz7um+DLcWv7KO1yNx/LSnM2enN9wczfDaqz3Cj3b9tPm6b3UxhmS?=
 =?us-ascii?Q?LThgOY+1JylEFxmGJFMG+kLi6NXZ56t9V2rKGmNbqjzwGWV+XsJVtJ9n+BYm?=
 =?us-ascii?Q?CPu+sEvjGvYCYZ61J9xpgJyMiUmzBpU3EvJ4dXBZFiNcRwWqtfkBwd6yUIZt?=
 =?us-ascii?Q?tW5NIOZohBUb9K6GNrzmKWrOX5BqZMFDfw7ryMwK5yBQPulDDUPUzFmhnOYz?=
 =?us-ascii?Q?Rhn5OFCiJRy9yWK1lwF0RESyvbEiVeUPGLm37zLL1EqHQwkTeSnwRWe7dEmo?=
 =?us-ascii?Q?RQ1YFHg9YnJ9VY0fkPNFWe5NvbGK8cA/6BvNQqYM/WDop2bI3lEGuIgfnAHX?=
 =?us-ascii?Q?aQ7O7iN09kLc89tZpkVJBxMCqBtBSLN1ho953R1xb87jaSnynvsKMbXi1oCp?=
 =?us-ascii?Q?AWMUmxJsqn9QS0bleKX/j4T8QxjEX63iszhKNtTvZE8RgRxIMZKUPa2SdIa0?=
 =?us-ascii?Q?SLwl/ZqEAczpvn9UtGFL6L4KEWCHCIlKEvZD0VjFPOuHVc1zfZR9tqa5YJdw?=
 =?us-ascii?Q?79Tie1sqxl7Pu5CRt9XVhohvmXblV/RhjXWis1xfrGisCHAYbPe3abw1av+u?=
 =?us-ascii?Q?7AklEd5TOaLLwvz6xKVrjEZj0BfPDhVKMv5SK5GFmN4a36aX++KjZebglq7q?=
 =?us-ascii?Q?nFtqCjSAM9CUheGmIeWsAm5za9QgqoWZtLnMUzkAicG6/kw7WCeLPg83Cu/O?=
 =?us-ascii?Q?pM3tGdvDfnIxi0+0PWAghzqHb2BYsL4NL/yCC2izyHoV07g++jLCJFnYERQ8?=
 =?us-ascii?Q?y5wazMAW8ApSjEMC8gL4zR5A2Y+COoqvMvJiS2aqPiTVRVUlamAj?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515ad942-374b-45b0-3615-08dec68be661
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:02:10.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAc1TVVw1D8tJyJyhczfn/TYheZFqaf6aiwqaA4fWEhRcV8NXVXtZdCnXmYezIdtN3GhsL22ETsSTsyLzH1YDfJjjzVG/e5tG198X1VseMGqCV0o5kqPHU/v3nPm/9kf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8046


Hi Mark, Adrian

> I have posted twice the patches. Basically both removes "platform data style"
> from driver, but 1st patches removes SH code too. 2nd doesn't.
> 
> Sorry for my confusion, but I thought that 1st patches was rejected
> by Adrian. But it seems 1st patches were accepted.
> 
> I will post fixup patch, soon. It will roll back 1st to 2nd patches.

It is complicated, so let me summarize.

Simple Card Driver
	- Platform data style:
		- Removed
	- DT style:
		- Keep supporting

SH (Ecovec24/7724se)
	- Platform data style:
		- This is no longer working while this 10 years, because of
		  Simple-Card driver, but no such report before.
		- But it should be kept for a while untile it is converted
		  to DT-style.

"Platform data style" which SH is using is no longer working anyway.
So, its support was removed from Simple Card driver. This is OK.

But we would like to keep its code on SH side, until it switching to
"DT-style". I have posted roll back patch for this.

And, because "Platform data style" is no longer working anyway, not only
Simple-Card, but FSI driver also no need to keep "Platform data style"
support. I have posted it, too. It was included in 2nd patches.
FSI is still supporting "DT style".

Thank you for your help !!

Best regards
---
Kuninori Morimoto
