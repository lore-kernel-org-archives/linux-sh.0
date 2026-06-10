Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011005.outbound.protection.outlook.com [40.107.74.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5E81AA8;
	Wed, 10 Jun 2026 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052462; cv=fail; b=FCoBnUxCBU7LLzHahw0fbTqnNl9nhnBLmKqvQnxOutKS6ErIfuVQYLIQsl1fHy4QqBMnZrOd/AF0SrKkONVuQX4YH0GJqFdgBZoWR3Z99TClxNskjIEjAV6fYLHf+SrYBYNC1RRJYTdLiMPTMp8Ro56qJMGNtlsFRyXDKUyIocE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052462; c=relaxed/simple;
	bh=/bIKRL1sPGRBhWBqC+y1SXRTjEcrbky30Du1GZpTHpo=;
	h=Message-ID:From:To:Subject:Content-Type:Date:MIME-Version; b=sr3kWSRjfo7QR36JciF6EoicStgwBYligmcBrF/AT/iRnOeLG9Y7tQ9drWANwArm6m6BvM6oLQjgijsm1ds9hGnhAVTAloUwQlcPJf5CJA7kegmEcQjeOb2krviUSjstFSQUHd4PbF/rwFHgTIaJybE7uCH6Ug1ynqr7vKbdpes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=PQUUv29W; arc=fail smtp.client-ip=40.107.74.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="PQUUv29W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xl/E/CDpIW/Nfp0+j152GJ1UzjjaSuZZj6en3qItcRYeIeubdayFm+Pt2747JRHCyU5zLSHpzLGDXQ5SMzNNpV83CVZa2cH9SpPueUszaoZx/24AdFAjjz58/JjtizIt8SUp3pLA9Yh+qF4+pzOXFY4Kj9sv6p8O8pX1+ZfCTJzaviQjRNEunBINr7jymkKxLuHE8mXgX5ixnGDUM/545XVBaV/vhh0MnZoDLU4/Scelicsb7c3zzheTAwxsdIZ/utJ4CNIexhy/xhtJOJ+xqasMQ6fQW01BfYsYO8WNBbtKZZtJAtEWUJo9gPSosinAq2t9pjFstmRhQFZfi1N1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbkotmFU04H3ZYCVrvVMNQnySykG6NKkSVeMYxA6gBY=;
 b=dUe2q33bvd1gOoeHguc867VwaMCezXOS4e3MiXe3c29nAzMZNDmNaWMaHwwlSIE3r82jSGVkmVws/OaWbamvSI5XsNYYA88WtUbHZjjkhfH+DVOIZyqxGQWoRnN10u6SWW419+Ro8MkSDfAKB47eApuE/pLHGObAl/KXDlXimBmxE0AYzICp0ZY/uNiyNQy8YlyWZsRP2vGrSrvQD8AJ8uJ5M1hEs1JXukBFyGLRweOqni/QrmtBg4kOHbVwzyXnEDSuBrb7bc8cceFAFfZRGa0s5g9HX7CaKDH5pci/+Ywtw63uUVgub7Deyf+Oyjin1R1lb8N9T7QNwRM7I35l2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbkotmFU04H3ZYCVrvVMNQnySykG6NKkSVeMYxA6gBY=;
 b=PQUUv29WuackwzEUMt0TirZIc5YLVG3oPVWqO1893qvCB9DpUAMaAyjt2xIl0+2xbp0iSmG3lOJcbE4IDJLOLOWwsS48nGaYn/YjI6B/UWuTyjOwWn256hZEK3++1opxsg3E2lpN+D2GiCiHpEEOWJgxHByhG8G+wt2LYnpaNeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYCPR01MB12042.jpnprd01.prod.outlook.com (2603:1096:400:3e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 00:47:38 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 00:47:37 +0000
Message-ID: <87wlw743x2.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, Mark Brown <broonie@kernel.org>, Rich Felker <dalias@libc.org>, Takashi Iwai <tiwai@suse.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-sound@vger.kernel.org
Subject: [PATCH 0/2] ASoC/sh: roll back Ecovec24/7724se Sound support
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 10 Jun 2026 00:47:37 +0000
X-ClientProxiedBy: TYCP301CA0088.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::16) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYCPR01MB12042:EE_
X-MS-Office365-Filtering-Correlation-Id: 7972dad8-08b6-470e-3505-08dec689de55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|366016|7416014|376014|1800799024|38350700014|921020|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	c5mP9A1Z6K0OMusG/JHm7qPjrIzeOydzGu8IWbIPLVrQXb4tMkPgzKXEMdaEJfTrYcjWrDRFH4Kjrs6NPE9CUtX6oJ5/KIpJHUOZvs8DXPcAA1LUAuP20Nffqk4m2KdI3Ez0iXuekWhxNlthLIYrOFM9J8gW2kL1/yzFsL1Z/NjH5aF61Bk4iB4TqDG+F9Ic5IBWSWQtnF4GECS+cUuUG+AXTItHoXd4QXIxeR0KncSQO/fmbDc6GeKYCoHq81XTpDzo1xSyp/N9sMqfKncMsks9fcUO4oq9F422duma9Va2eXTC4xATBcxikqvIeDVSwJCFfpDEgqL+9bwcXs5jRzSNWhDfqwRDefAkW0KIX1ZdqhVUsaPsOhw3aw9CRepwCISyA+BM00SmPBD2RQwi9qVfOJB7oF+WSkEWY5OxDsuXCpvshvfvS/0j7ovMRrQbEykadaJPbR7awVwHGxvQQVnidaX+2eR/MlWnp9ATJdzZoPh0/8fcerK76ITLUMyktuDW6njpj4ZTRSLgHISQq0driQdkAuWVoM8XDwJRtavRtmuU2T9UfUwRq7o+9Moyts1vM2LcTbUSj+ELnAVudGmNEQ6lBBAzE4uEnGi6mSsdymHxjvQrBONePsFvbFvK6SbL7+hSUHxhRt1267O/Z0BXSr+v7t1M0lmoXPgooLyyqsrllodtKBYt31tFKA6NBaxwD/mPrPAySx2UFRklwvvrTMXP5ZHcb48xJldTB14Oz/+oMpKOy/P3JzmBGa7eeU1fBAsh2oZAszIravDuyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lan1JyLE3X0pxDegteTUwLiSCZlD3fsEoca4EmxzMTfE77acFUA1SjvNjfRw?=
 =?us-ascii?Q?pdpTdQUouGAo4/A51r0pE5IURyGMLbMEKLAaIfuBDnPU7TlnheWGb0PSIycw?=
 =?us-ascii?Q?xqF2wj0zAnmUNy0RZewk2ilyXHsquBZfBuThEZhxCzeaQDIw2UVZ5mMt99rn?=
 =?us-ascii?Q?S+cFKghzJIP5d7sFd3T8Qfh290DbtOeA6l+RP+ItIwIR2u9rIPSCFVrfcvmE?=
 =?us-ascii?Q?I/ewrdFT+LeAdpXOo7Ug9a7cPXH79vpcGivScE7YyHA43fBIpVwI7GcCoA9t?=
 =?us-ascii?Q?4yg9t3qn24ijDIoMMRO+rX5Nk6G0J2trO+LCBxErz7gD81vFFzsN2x6GWMka?=
 =?us-ascii?Q?NIhstQpVoJEcLwdN6venNg6b+s6aWb9gcR/muuWXNu9ZrVAuKGTjoICjXzT0?=
 =?us-ascii?Q?LxAsOPISF9okALHoavN+qaqFaPe5r7KXCaFz6pgfnhkrZcIIlP8sZaYENaxE?=
 =?us-ascii?Q?7DjCcmNpSrCJ/hArVfLskyfKa1Ogm0jhbDGpLpZk16AanKhonPPKLyGxAg2M?=
 =?us-ascii?Q?Ttx1K0cV5XQioII3E823VrQIuhbTf1HgWgNKYaF5roCDxnTB973oQu+ZoDdM?=
 =?us-ascii?Q?v/r2swarI/V1rhpMs1K2AIzVCDUoz3UBwKzmLrnDwtcdnp2tG66hc+mXNTw+?=
 =?us-ascii?Q?OzmSNkEFDX45qsRptR7XRmLf4uMyStB5b6MlnRDuwCuBkNu3DPX+AJqg2eU5?=
 =?us-ascii?Q?cs56pI4h26bpM7pWyyZJsKxe+caYpszzGCKeqwJXJM7QuBK0MG5Sxy2U9Kdv?=
 =?us-ascii?Q?yEcX9LzVLr9AbEJji+SkjPdJHyQf4pRlyIovM3Q2oLoGZwwpu2SXYmgmASe2?=
 =?us-ascii?Q?iBHdm2n+2iSN8TIKRUCBu5+qxNKc8IHVmXumqzqGd7HxgGWNCPat2STa3kNE?=
 =?us-ascii?Q?nD8Yvzh/0bHITER0ACgIGa82YS8TpdO4MY53bEvKnFUBSSGmC7BQ4B5/lbad?=
 =?us-ascii?Q?vVWUmd/V8avR0Np+VFHKimTK66baJ99nAwZx0zgq03hJJq1NUfDvQyuhW68U?=
 =?us-ascii?Q?ir1SjkiVJs1GQ1TsccwUTT0bX6SIv838C18kSyTa3uGW2YhDnryS7TWjdJwT?=
 =?us-ascii?Q?FqSxwisq3K8J6oCDbHLppWT7tCi2exSre2apF6hV3bNgMe7MVrNR4tNjOkvY?=
 =?us-ascii?Q?zDlRM8X6QKApKNGTWKOFgBkXoJt1Cyj9rjjjUBUlhEuVbKzJzwOsQ0Azi137?=
 =?us-ascii?Q?R0M2oS897Ezl1IMpnqNB/0hjS4r37NFIyO61B7t69OO86nosjyikbKx+Qt4o?=
 =?us-ascii?Q?SirItmfezK32JtWIBKKGHSZo29jIFx86wW8PR80gA7zDbOB+IZVHERGn/9un?=
 =?us-ascii?Q?vbOZmY9TqKjp/BUFza43Mj/ycYofduggjWouyDLX8YV3xqpDVA7Gbun+zck1?=
 =?us-ascii?Q?t3j9SEdmvrHtTDuT53YYGMcVzGgiVmwVFvt+md7KZCBXrCjetGW00c5YrNgP?=
 =?us-ascii?Q?YHQNmfbeVAfK/l8TVhQl9HnZvNZLJ4CfGpRSi9Tjzx/ZIrl+LcYZxtp9UWH7?=
 =?us-ascii?Q?4REyn6M8A7BqK32akJxHsxMCvY5hkY+4DmfFydLvNGBu1wMxZTQPxRVUE2d1?=
 =?us-ascii?Q?4EbqzxCleKpKMnnzW0CX0m2X+3LeYCjjtFgKzsH7vHvFsP7hGekdXjH1bVu/?=
 =?us-ascii?Q?Vs6RMJVFaQeI/swgJgWRxgApRhNGp1K3Y+JJxxmSKFIUxGNN0XAg6f5/7k+K?=
 =?us-ascii?Q?WiBG0HJS/2x7RrH2ZBYoLPzTdnuXpEa1Oh4Vv99cVWxNECE0E28npNVvInwt?=
 =?us-ascii?Q?Ke6T61E5H4uCqw28QmlRw9jND3uvqCc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7972dad8-08b6-470e-3505-08dec689de55
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:47:37.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M8vwQhEDpzMBfUa13MUq7bXe8owngJoQK3MqOMrPyb6JsrEK2pWZ7VzgxyV0D8tlbmkE6qtng71KaTD9N6V5TtHetP9PcZMoSdBr3SX7oxkU9XIjf9M5QWBmxoWiO1W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12042

Hi Mark, Adrian

Due to a communication miss, the Ecovec24/7724se Sound support
were removed. We need to keep them for a while, until they will
support "DT-style".
Roll back Ecovec24/7724se "platform data style", and its necessary header.

Kuninori Morimoto (2):
  sh: roll back Ecovec24/7724se Sound support
  ASoC: renesas: fsi: remove platform data style support

 arch/sh/boards/mach-ecovec24/setup.c |  90 ++++++++++++++++++++++++
 arch/sh/boards/mach-se/7724/setup.c  | 101 +++++++++++++++++++++++++++
 include/sound/simple_card.h          |  26 +++++++
 sound/soc/renesas/fsi.c              |  16 +----
 4 files changed, 220 insertions(+), 13 deletions(-)
 create mode 100644 include/sound/simple_card.h

-- 
2.53.0

