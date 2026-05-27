Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010057.outbound.protection.outlook.com [52.101.228.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7F3655CD;
	Wed, 27 May 2026 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922936; cv=fail; b=sAenn5N5aiMAql+OdglyGc5vskuve8btgpGBMilzBRn7//MZADGUufS/5zHSlj1O/i7trmmoNzn/LZ4e151bSgM/P/BCvcwVIxJMBaMG39AKsESJB2I+9263yXfX+8HpZA6lNuV0xyhAZ9g7Dn/k2ktAD6WF/hOD/b06bcX02eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922936; c=relaxed/simple;
	bh=YMTBRviKJwiZJanXfhhl5vtHF5XX3BKtkbEKB4TLX7Q=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=h9XkN4WMe+YT95wly4eub4pAK+GgK9Wi/th/NeP0pKun9tjldtPuY5ewBb07Ox9XQK4FUlcn49+skTt87T3YsVEHc6CG/bJ/ljR62uaCiUfTf7WpQHdRjFj8WSlNwjLohudGPkFk7+YSM84igqS4+ghrHc3nCvZV6Re0xOq3EhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JUy/yV+8; arc=fail smtp.client-ip=52.101.228.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JUy/yV+8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3CQDjyFyXhqwPfR2Ts8loN29SMtExuPZ9Inf8qWMnWWzTI6vOzWwFTtI9vrlDrKg78oFlcLq2P9bI8smQi5eETJX5KDnPhKOrhj7wPeJ7vHsYLa4BMrA1b4O95RrPIuUFtXd4dRtSlxatyimnh1iwJpP6KV19rebGM+PDIYSEDqTc97o9NI/LYjWJT9xB/a5YqF//4m0QpidlmfXei7vO2AN5cdGUyDOVYR7pONg/aNtxIWalkrXiBpLxPnIGzCO/gtSF56becIjNM/7kT/WEk05JpMtnZpkXcZ/o9ze89Ln0JdGQbhp+cjsiVKHvThh2f08wya/1nkvnqT/j3ACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPlUG0FSbBGhgSMq9S1g853muhUHR8sH8AHTXJtwr6s=;
 b=EDcakcHC3hYjng450kWQ4TULalXoqvjQXyuchiG7ajU99K/VIjVS2Sd+oCrs48TfPyreAPwZXPveC0/Pdaou/vbXIGM3Sjm5SSf5w23oOxxSsXYvfBBsrWF7cezatqQp/hPNOg45l6Ot+ISNW5DqQ+z5hTMoP2ELo9NlMxf3lgd955HEVMPamg55ftFKVa5SrG//neFuHs7HhGEyOLRLTFIG+jupWyo6C4XgZVeu6CYp2nnAM78oiRK2rV/g+GP8KMo9mvCYADuNypufobGeDuE4XwBeM80+vYnCHovfmPsAWocDTz6kmh+yB6TDNFaXQWeKo6mkyjIgbfGWCGsf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPlUG0FSbBGhgSMq9S1g853muhUHR8sH8AHTXJtwr6s=;
 b=JUy/yV+8I9kjpUP4Mm7wnZjCwV8KYi1snN74Z1TPBYn9G23GJgxrSC7WaTabPqA4L08R0/kIcJXXeTfR8HvY4EePQMhEKkSanRAPOQZivL9rS2NQcBpy2BtVkY4R4LBCWgsQZLMaz67Cr6RYHlE6M4eGMq9gFeZUh8Z1nTDWtYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by OS9PR01MB17953.jpnprd01.prod.outlook.com (2603:1096:604:46b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 23:02:12 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 23:02:12 +0000
Message-ID: <87eciw318t.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Bartosz
 Golaszewski	 <brgl@kernel.org>,
	Geert Uytterhoeven
 <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood
 <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Mark Brown
 <broonie@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Takashi Iwai
 <tiwai@suse.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/3] sh: ecovec24: remove FSI/DA7210/Simple-Audio-Card support
In-Reply-To: <07dc3a3a89cc4426955820a39c2b59c20995ab2e.camel@physik.fu-berlin.de>
References: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
	<87y0h5e4ff.wl-kuninori.morimoto.gx@renesas.com>
	<07dc3a3a89cc4426955820a39c2b59c20995ab2e.camel@physik.fu-berlin.de>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 27 May 2026 23:02:12 +0000
X-ClientProxiedBy: TYCPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::14) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|OS9PR01MB17953:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdcf8f7-36b5-41e6-a7ab-08debc43fcb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|18002099003|22082099003|38350700014|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CQs0j8k4WpQKUIVhqzungV8AQxnqppvIDKEdwiA8HqSCFki5Y9dNkwimwmookOjw8ka3L2dXQiXOisjOwGiYXbaV1zOWjqBq2WbBx/IdEiLjYNVPV1/2XHnBx4d/Xz8E7Ss7aQzxszTDv7YYxRcPw3zmXfpDVLSkhNoCPNoTkzbOoCY2meKAOhj74/87E6Wlsv6k+UN6SzBfv/0XYbMuIYYkJXfm7KOPsUkLzGl3mLy40dT8xB0FP/CoFxKzwm+FhEu/d+DxTAnOjTXAQzg/1mXg3YUTYjBVsAI2xL28uC/qdKjgjvzHZzfNqBjFKLVf6njQRarfkUaTxhmK1hLcnaOMfVh7z2EDnic+h0cHLKrPY1kPOlf7BRhT+t6h/PFnRgYwQCJ0DJnKoDLwschmCu5Tu+qFHj3+FN0w1BzGVNdaFvR2kkglA3GDY34hc0LveE4ERZaRrVBL6EV4FwT1aCqfYmcLCjlbebC8CLh8iP8n9Gw+1CKD/gWR0sI+NJ4rZQuKDJ/gbTSvRW0nRGb7NP68LrfKXYs8A8P1tF26/rBX5dO4VxD+Qhp2b8P03gpN8u2ABoYc6HrtHl1DZGRqzrM0V/WIjbU4igbXb9bBksnKYGwKlML6IA4CV48x19hVqC7CEKgpTp16MUZ7kNv3qcKEK0G7Ym2Vwv5Wllm1WjRZ2cPnhNDtk2EuWDjmyLKC99yNVi7/V630XOWVuxnRvxNZfoLt/K+zpl5lC/qYwMFYV76nJ2h3Z0J8fqPAEA9c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(18002099003)(22082099003)(38350700014)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXou65nfJ4GELPJY6rAEzSrBWnpK991nrJnjP/PodMbjN0eefBg29PV+0nwf?=
 =?us-ascii?Q?K7XCrkrz1PSDLG6C6mY2deRAqmSihWpPHtZJdxqCJM1ByV0k9V/t10QQ+mr9?=
 =?us-ascii?Q?RWm0oJdJpkjazcTbkLH/mJAf6fVXh3ejM8WWpItV+aH5vGGlQqoHeRtWsJ1X?=
 =?us-ascii?Q?XCTC+y/eljs/Mayniw7lNkln3EatNLf/PbCuv5KqmaaSW+jj9eRV7cawXHIv?=
 =?us-ascii?Q?jgh25uRU8zbdE/g8qGAcEW53nYxWi1TEvmWYWj0hhUPELr5k1jGn/oTmwEl0?=
 =?us-ascii?Q?2eY2EMJHiFLizrDB1ae/nc+KoGk9WMcIUc58dBtOXrjjk4l0oOXngSULGZ4p?=
 =?us-ascii?Q?tDh3D3HWSmW2ExT2jWFvgGmTsl4wQeIaQrH3zfCuGQeaehAC2CiEf6jr1tAo?=
 =?us-ascii?Q?k0qotCa8YTsgfU/WmdaWFRz1lCBOMIFZnIPVUaIClenxK0cPjCv0a36Q2SUD?=
 =?us-ascii?Q?LmIAmVLaqTfpwEIwXVzxMtCPPwHpYMHj/AjAAXeO32mTS+9VUaB7+mEuRJ3D?=
 =?us-ascii?Q?Ap+WpfdRQ6PR6my+ga9vnyzx91sNhn6Mr0ipU7apczA8ETcAdL5W0iZcng2q?=
 =?us-ascii?Q?uGkYcKjNeNnuhKM+pn/K/dhaox4Hev2hL73llZ1JEpKVrF8FR85m9Mxve7XE?=
 =?us-ascii?Q?J4j0oLk1muAL90j5qHP9bZ+tSWUYlGPub1nxsk6d01WHiOQ4QnvWNvzW3JEe?=
 =?us-ascii?Q?WMFcUYL1pjiXlXoJ6TaA98lGR93eDee2psD2gO3FQorFx5e6vrZf8+aY9SD6?=
 =?us-ascii?Q?dS+8MjGT3XxqGRPEFRfIiRg+0w0g/XYMzEzcpV3HgiOIzVn60Sf/Tt6oZc19?=
 =?us-ascii?Q?mKeF9drQ6YKiqi704oz+2GPS4L9cHs8srWK5FgkeaVgUgw64Mj5PBBNQQwcC?=
 =?us-ascii?Q?J0ZipKfSAradB/thQUaQ9o6H7DSh1EUhBFKqx9aE1RjXy36EBlmcy0Okg4O8?=
 =?us-ascii?Q?B2TPMDAGwahV3XLwiP4DT6r9WQ2IGcHYcZ48+aQZjeCV9fPw5hWhyc3Xpq4e?=
 =?us-ascii?Q?IahOfDtPL0cuqES2AZsMtB7fIRUtP7KQC1p6I9cqMdrOc56oZ/sdT256jOV5?=
 =?us-ascii?Q?mxFWkdczZBm34BX/xBWs2AsKOBt6H2+8JTNZA0lm5eA4QoFfJOTPFVGtYmBR?=
 =?us-ascii?Q?gN+sq5G+yb3aKUpyYY5qjY5QEvrdimSUH9brVzWmub7jWkuxIphhrsEsb353?=
 =?us-ascii?Q?oxCtl3J8g5PQreQU1HNaiwbnN4hraP7fxH7v8eE+Q25Stx3z7Hsr6I4TiJwU?=
 =?us-ascii?Q?LhqqPagOyrpyXdc84AhbXNV/st+lIfK17g1ShuH9AMjQ5y4luW4iR4+pagXd?=
 =?us-ascii?Q?BD0RwH/RIvKRGXSFcIpBVjiboseP/HfVhNBwQIEZGABT9/sx2FtKEvRyW1Zg?=
 =?us-ascii?Q?23Sp9uWbhgUOCHpB9WZo+pbLM0kYZO5rXiqkdg/MP4kWpITFXj3WIhMoIN9Y?=
 =?us-ascii?Q?2//1QYk3v2lYb+DItS2Zbr+GSflieBx0mqSZ48U3jMMKfRpFtVLCSaQbL0lw?=
 =?us-ascii?Q?fXNxkM1pP7eLBTMlJRT2Sjcd80XfkqGhGfCPh8X4Phb4/2I+96z19rOuQuvc?=
 =?us-ascii?Q?i95+kLOAThhsGFJLMmgspcOYqkoHhxDKF4bmODUxcpEnHmsmADeJwc40hthV?=
 =?us-ascii?Q?pTZ22NaUlRua4ZZyo9XcwCAeomkas2ECvLhCjf7cpGv+VFfrY9hF6Uok0H+W?=
 =?us-ascii?Q?RnW1KuwLUb3GKPeMc22W8XSd9x5n8is+qXX7ZlmiqqGU8z7exr6S4dYluBUm?=
 =?us-ascii?Q?LqlB2fkZnn1EeVdS74KqEtF7NFR/kPmuiAIA7RASSpIu//Rt5vOT?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdcf8f7-36b5-41e6-a7ab-08debc43fcb0
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:02:12.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5KS9wSsWLcCDfRtCj2QtHcFQvmIzxkt7gTZsh+EV+J9O2y49zDPuoeV1dNnxewEQF2TyTzdInZ8nD4dx49lTBReml4QgsPcPZOjTJwkLfo8QDjY9rWKW5bPfyre9l9b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17953


Hi John

Thank you for your feedback

> > Ecovec24 is using Simple-Audio-Card with "platform data" style
> > (which is mainly supporting "DT style" today), but "platform data"
> > style is not working correctly working during almost 10 years.
> 
> We have an out-of-tree patch series by Yoshinori Sato to convert SH to
> using device tree but the patches still need some work, see [1].
> 
> Do you think we could save the drivers when switching SH to device tree?

The driver has 2 style of probe

	(A) Platform data style
	(B) DT            style

The problem is (A) is not working. It is very welcome if SH switches to (B).
Then, (A) is no longer needed, anyway.

In such case, is this acceptable ?

	- Keep Ecovec24/7724se setup.c as-is
		- It is using (A) style, but is not working anyway
		- they will be replaced to (B) style (?)
	- Remove (A) style support from sound driver, anyway

Thank you for your help !!

Best regards
---
Kuninori Morimoto
