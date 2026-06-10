Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010053.outbound.protection.outlook.com [52.101.229.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18CC1F936;
	Wed, 10 Jun 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051083; cv=fail; b=i1hj0PJWYUGR49OXHLNVGrEdhxkhSqgX0ZhA4s36N2yVtCys2XUltO0u75EZXddN2jDTvLkrMhgYL4rsYjB4qosWS6EvxVvBMTfb2nvIhzMVJuNKMXY3/LMkuAnwki5wwjg7bxAn+J5ExOlWhPh2p2uVhqyQsj3G8UdwFMj7kuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051083; c=relaxed/simple;
	bh=FumFNJNjs9MuxdV9RRDVKsK6Cb7sNWsNPlIFY8nqjbQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=vFkLmdOT2czApGCme7+DJgCwAofg32/HtE0NzcYSvVNzFL4sb8iMewHMOybN4FPKH0bywNfHMYwkq6JZ0jXJYhkG7cLIoJAbfH88qRYli9wMdrzIW/t4ZPW1DZ2d52ECgwz2xRjh+UU3UllDZOWzM2CQ/syzH2bYiugIxyh4ZyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=aOiCWTY0; arc=fail smtp.client-ip=52.101.229.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="aOiCWTY0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNSI1fQYr2fZ99iuX/M6VV/7C+h5pt5f89QQIuhWLZEd1IYJTLWm7kEkYvWppJFuPNLp706vsWumJoO7DXuLvuoQVjUNRkfsx1xc+uECHWCPwMd4mHZCdA0ro7lcnAdbqLKkMv/P0FcT8flfvtsYMlEbqf57Zhg13zP3bzd2Gjn++Fgg3w9QIwC1l/4u9+gwuNlz+3oY2K8WrrRtQeD3CPa8S5/wADGTFBdiP8d8r8faBTsC/GarineTggubOTvr7dUivyN/h/GkNzpGIfJAAgQoQnNFjMAybyCJvI+LOHAtJdSVpArjZoVZ/swjUYPZguA0CZ0NRRpe80u4ZJHhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FumFNJNjs9MuxdV9RRDVKsK6Cb7sNWsNPlIFY8nqjbQ=;
 b=j2mgErfyO88Z7iXbeGQs9tKsR3xuZXIyKnLYg6trQURD3A0JBqZAsnteAAxdF+uVIgA34eflSHImUDotjAU0PJtHspp4UlehCuEzHzYE0ncx2YZ459XrvTOJouRBph27Qa720HQi9Ak3hNIjoOWx0xBjFFADHuOaUXrXuxTmz53vz8AF9QUH772zZI2XOFqD9+e7HNW4b0jg5ohrEPNAXUxw4KncHJp4AoIxHb+2KZvVB6mmYxZqnUqA6c3UT3CvxzzqpY+LSQkEnI6ZVdzWMNyLXKkGKf+DWpeCD1qgnTzWm5kdrVY6zg88Ezb+ELWWjvd5MbcpHWhbhexLd7PVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FumFNJNjs9MuxdV9RRDVKsK6Cb7sNWsNPlIFY8nqjbQ=;
 b=aOiCWTY0pkxjKr7/+I7egajpH31/gd4mFDl0FETvqCFLHnQFORlHSERpdg8X1Evg+65Qu3HiBu+PI8vU4rJIvYVQ58YR4WLLdaPhFEUfL9KQD5v5snGkCKQbmrofsdao2BoyIbQbDV+X9AOlI9O5L0y1Zt6r75jLN4Rx8yWFYK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYCPR01MB9781.jpnprd01.prod.outlook.com (2603:1096:400:20b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 00:24:39 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 00:24:39 +0000
Message-ID: <87y0gn44zd.wl-kuninori.morimoto.gx@renesas.com>
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
In-Reply-To: <871pef5l0o.wl-kuninori.morimoto.gx@renesas.com>
References: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
	<178094130630.20828.12708103059145547835.b4-ty@b4>
	<fa7d7af8a780c27f85e29c518ba45e39ab18abad.camel@physik.fu-berlin.de>
	<CAMuHMdXVWPxu-5BXAgWOBoWdNXxZ2zeAfTovXxftXsKuCUUDww@mail.gmail.com>
	<871pef5l0o.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 10 Jun 2026 00:24:39 +0000
X-ClientProxiedBy: TYCP286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::8) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYCPR01MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: c71cd962-0083-4680-cd47-08dec686a8c7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|52116014|38350700014|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GA2DWPtq3oZOLhmLEOv996YBAqvHuhM3MZ1gtDn1CPfjI4Rz/ioDZX0qp8FjdJLTBfv2v7ZmUlQaYYUYKXOvL/PelnrcDEFDE5Gl3ucqVhct98nYT2Yb/IW1RS2leSIt6GNy0Y0VijX/gbWlFgWxp1Cy/TObexzz0l6Hy3ECuXoPZwYTCXee6rxFQRy4u895rkQqlOGHUCBy3KuE99FKk18rCFKXyqO8c1M/596UR6pxJ0R3hU0JOlbR719JiErhT39hE+WJGWfCLcj+gvjJKMRmKpb7ir+OGDiWD1TQmoY/F+Uyka3/LmJlUP3IGjEWOfVLbG0pcei7MVOifioGYq5e7S52UdfwvBhqfYBqxcyyy/7dC7P6UhW48QAQ1C4e8RcBaWlxpUifd2lzUsIAEysYMIR4bZIICX0JfwpaMvAEiX0M3Iq/Ou4MfsTomC4NVb68tbZVLtOBFIGhmiTWgzTWacfhim7yTxyaRxsrDG7cKk+QrM1g4B8lwp+pwkRB0BpQLvv1/rhywWF+dvUzNE88G0JwJSKa9QhXkzT9aJRHUjsqtffswOFHXyfFMf0ihB1+ELby+SCGXtcBk5cIT1jJCTXkasylshr948aBiMXs0iP3BeIpvA9XZ7niSOWM59Bcf5QpY1dQZbHQP2sKMHY4Hbm6V7P2iYBQl0Ickz8FzQ5IlATfBKGu+o4EYY+LHkL1wtvNGMHueJhHipdAITLNuIZgkPTp1IWUoLvwsIa2fG52C3m+fxlZGbCmbUxK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9vQ83DQ+sOWq9BL1MCbEWjA4jQzS0NVxPiaRXUnOSZ5J4I5QGx0UVvsP+Ol5?=
 =?us-ascii?Q?bW++c+wWIi0q4WKzJ6xQsmXQTrRthQ+y8sDjAqpU9U3yeG9l9tsCT1xUfA4+?=
 =?us-ascii?Q?V9gnxKS5IWYEkHoZlk7v486g2vLLnCDELc6X6z+1aoarbOTExK5Zdhqt4Vgy?=
 =?us-ascii?Q?nb3wYvPXq5gLg0ZDlsTA47vKIfK3KGfr9dA/qyNDZHuVLnZ/76vlXXUvIfZh?=
 =?us-ascii?Q?5vWTUhXx1jMOj64E7HNyViMyyPHsp2mT3dHMtGdZ5REg+dgt/unfTreMFdPA?=
 =?us-ascii?Q?w3illDZTobZDiSa6oeqEKABXrcLRx4RaXEh0+2N2RcoWvibP7sowQeW380qU?=
 =?us-ascii?Q?uhkoHNi+RHCLkIKLnAAujX+50+oINOsMwn856/QugVXxf5sV7d7DyD9LluTz?=
 =?us-ascii?Q?+WvnySxCsuOLayUGD13RGmPo9nq8lwKjDcfEUQla2H9Ma3hVZHGWNaH9sNyT?=
 =?us-ascii?Q?k7Ihz2ojArmXXdZgRb/Ys182ktNuBFYoSE1Qzzuk8DUVA4gly5knS2bXXwm4?=
 =?us-ascii?Q?gTDhTp3rHBTn4ePlqO41qiAOeEZoSxRqgXbs2c5wmS4oTcfN4Te5sl16G72H?=
 =?us-ascii?Q?pV3Ep57jPhZ1KuCa7eIiv5NvP7Ol+eVHHPNc2pfTRy3CCGn36U9jSpeg+V7e?=
 =?us-ascii?Q?pjFcbTW8E2Wey65p1YXLEitZxXVwW1ddl43vuHVTqmJryyzpeN8IPjiXZ0dc?=
 =?us-ascii?Q?8bD06b9AhBHwYGklloB6FaNNAJS/ZxjPMAGkJ20Kmzkauyntpuoppdi8eUaX?=
 =?us-ascii?Q?GNb5nZcZDCB5M3LIqFPYq2T+2Kk8Ih8bc/wxgYUmaEOErKDZZJIDu2W9jjwf?=
 =?us-ascii?Q?qvLgvktwHGBQFzfilyfnmvd1erMn3wDwd6wb3XvMQW7KQ+8Uaad9t6YY4Ivw?=
 =?us-ascii?Q?PMHDnU4v8mifW9AsPtxQ+LlSPddBFOW+kNycyQ8mLDWUSGnPNde1LTay11SD?=
 =?us-ascii?Q?jwnnydQqSpkS+shOnPtNw5PUN74yitGxSJmjjMBsQMtPu83oxxai1s25Z7Tt?=
 =?us-ascii?Q?dDdMsw5UnPYrWN+H55ztViIizj6rW/VQVfCMEDW24B+u1GxBFTsCfx/WJVd/?=
 =?us-ascii?Q?L7kymoekCpXFjfdAkvt8hxVxMgwBUw+lCnmYLuKsIyiOG15+f+Zmh8bGe9zk?=
 =?us-ascii?Q?nLDu96SGcwj2V1YMct8gN37sj+Qz4rrX+AvOf649dJ9xoBae21qHl3pSSvMy?=
 =?us-ascii?Q?1PJC1NhXDX4ui7OjGt8BIN0BChwZVBuRpmQeTkCPf5xopEZo6y3sGYi5e1oA?=
 =?us-ascii?Q?jlLbdeKZFQhOuTdcCIbYIgz3kd7iOLSWnaLFVMW2iGveSuDVgpV3Ln54tKfR?=
 =?us-ascii?Q?bya6HkVYNkTJiWNuVk0ByxwA1d3HzHk2aVPkYQHfcTMAko6dMt8B7jXQvuoY?=
 =?us-ascii?Q?aXZntMqu7NvMilPjqNt0H4q5H3pTf9sncJ+7+B2/8zUpT2jryzfbfgcZ2hTq?=
 =?us-ascii?Q?E8xwHmpjM2OLpOk69ly3ZzVqvfqR6kH4d5c9EgS8gePXV9V54Ch/irc1sioR?=
 =?us-ascii?Q?xhoim65j6U1aCb2lvQ83OWoy/BztFAn/xuvPRWdFea2x8hDkBpkjER2dSb+X?=
 =?us-ascii?Q?gQFbVr5B+v9ZEWzfD8q+U0Sqz9AMp5jBiF70xZty15VaGEhIWJmA5eWbW8h+?=
 =?us-ascii?Q?fZjIc/WxjunzvQnMZWqBT5K6uQ/smV97ZopQUI13ChUMKwSND3N7VXNzQHK7?=
 =?us-ascii?Q?9aJv7HjSvKsJu9yOdV9zCKLdcl29l4auxjTGE7GXt2kK2t4aLqrkHlUV0UtB?=
 =?us-ascii?Q?7mk2BhR39mFKD92ywUtAqZREnA/vCa4=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71cd962-0083-4680-cd47-08dec686a8c7
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:24:39.4619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iog4i6Cl1BrVoCNxRmmDda3SNf2XnSjM8f9PfiJ/Dp7mIpgFuHMXI949SgID/Xo9EQUZ+TSD7PyaBnlL5832mpIthYs0/81YSa/xuMeepB+R5IcZzAlwhhn0qh5ICGWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9781


Hi Mark, Adrian

> > > I actually wanted to keep the driver and convert it to using device-trees,
> > > not remove it. We have an out-of-tree patch for switching SuperH to device-
> > > tree support.

Oops ?

I have posted twice the patches. Basically both removes "platform data style"
from driver, but 1st patches removes SH code too. 2nd doesn't.

Sorry for my confusion, but I thought that 1st patches was rejected
by Adrian. But it seems 1st patches were accepted.

I will post fixup patch, soon. It will roll back 1st to 2nd patches.


Thank you for your help !!

Best regards
---
Kuninori Morimoto
