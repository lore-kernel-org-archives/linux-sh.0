Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010035.outbound.protection.outlook.com [52.101.229.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE53ACA6F;
	Wed, 27 May 2026 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864331; cv=fail; b=JTXqBWnAKmna+ryr/sbbfnet+2vVhcWrNtwE/gRF2bX3p1qZPVomcKZ0/H1Kw8ApYlJLWpW+YlpHN3V+PbITpPdMesCcpLl0scQBexPa/JWo6kgkI6fZZfaNc9WhieLyNwbTuA2yVMiQdT8FkxL9ZLUKCJrasE9/aKM180FNYcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864331; c=relaxed/simple;
	bh=wJc+AgUdSoltVtd4qjdav1iK2tK4dCQLzfPeSmLxnuI=;
	h=Message-ID:From:To:Subject:Content-Type:Date:MIME-Version; b=ToTtMRUrA3vFwNre4Ur/xGxzyOS5Uil+dUTHV+Ge7UlvxER8GTV1HW7lihxNpSaYHH7R7HEc0nnGSp6vic3QOLufZiRMWV6xIV4iPxw++LDemhtj/JbxkFsxBgw3URy1fLumGwAKkdXJ04gdCh6ZvUImdz7CcOUToQmVcVpu5WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=FhYYLtuP; arc=fail smtp.client-ip=52.101.229.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="FhYYLtuP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdwOchnNKq/LCPpLJ4IKO5JHh2CXv9UT/KdeDFMnATe1IMiRf9+3DjpElgbi4sAeVGYF4gaL1I/WXiqJvK12swEXXz/AcDPcLhh+s5o2bo9y9IL0n5R8VcLjSq9jL+Af21+OYrr7HlSjROlnVNBTmTWYkZ9IX55yJ3sP/vt9pYVwrPh48NJJSAkykRk52X6mynp0UeFNlyLPyLrEsdDUTCn7ZYGBd71Iu8FjS/VOvqgYWINt8WUsI1IMTu0EWn6Vqj3gblrM2OUKPuxYXCcfM/7FOxNy5C6M6H32jRbCIzzZOpxp5esRRbEAOz/cYn77In5CDFSIdjScflrFhUAy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnuFBzA28rW6AuSM+sNwH+dUXbiWY3g0dDat2hXTtes=;
 b=rt1iWwsVfLfYfQKKNncoRjiLF6Ps/S48jIbOotzwLBvVUEa95MEMvndybDVsQna/XSSejp2KvQiMvuDDChmb6HtcePy2EESjFMI1kLQsKq1Mb3Z0N5aHsi0fQGznubJN8ZwmVJ35Obz0Y+Rqe93Md+BQ+iMaVzebgTMVr32viJ/ZzlYbXdJQJJHMErs/gCHXsl9U2Xhy/t5kMDCKzJRwaXR2j/nXPoiBNT/+W0bpuAyhLODyFvQMpd0AoLG2SNuetL7mSt4Johb4jcxphjjZUDwUfpzaWlXnaeDkq02+zWmhCwmg4UGV6QAp2d1knvhGl+NT1X+IlUysYx+YaWwaHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnuFBzA28rW6AuSM+sNwH+dUXbiWY3g0dDat2hXTtes=;
 b=FhYYLtuPiCgjomHkWupmDaF0c+H/EBjpI9QRhsXakaORQwPy1ceqgNVISCAdneOVgp6q/aADJf1WsgpXrbzsCBYbevl8kU8rBfgedOQFXDFs4cA0Prb//qM0LWqBOh3JraWEmq3N0qUXHPCy2GA1+R4Yk2dy6W70TF6NrwVwYH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYRPR01MB15880.jpnprd01.prod.outlook.com (2603:1096:405:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 06:45:26 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 06:45:26 +0000
Message-ID: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, Mark Brown <broonie@kernel.org>, Rich Felker <dalias@libc.org>, Takashi Iwai <tiwai@suse.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-sound@vger.kernel.org
Subject: [PATCH 0/3] ASoC: simple-card: remove platform data style
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 27 May 2026 06:45:26 +0000
X-ClientProxiedBy: TY4PR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::18) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYRPR01MB15880:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e559a79-02dd-4248-d340-08debbbb88ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|921020|38350700014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kHEPwXHwQTXJ2U6kBTresuuV2jhyMo+bJHOEQ/BO81eR63Ct48sC8NTrZjKf3erp/njyzTvPa2ajDLxrGbWeBjyPS93LNmCTB0a8Mq/XgCRyfHdPHYEnfnolSPT0soB0A5zClfWaZeuCViGhK6JXAmzYtuyBJ+O49lIaziO5+wiiO2MPFLGMXmNL3DfAfpF49JEslKyDorwQ08HPCzwxw40sHUiD+GOVVyp6Ll5WXmlHZFDRPJLmjb6CdvEVU/DQpLAHe+t4IIxGrZkdjDEYLl7d+d7Yw1jmu7+mjoQRiIbHD+cNjJruDjxRVtQUJsYpOymL/aPdEKhAnTpsrL1hiGQdH1rMrFNW7BO3bFntmhwYx3YyfjUWbK3F+hRCi9GboQOLJjM1R23efvcQo1My1xCe60acxqFIQI5JWXxMAISdVvXpHLHVB++d85+p01FunIt1OjPRhgxdkvOiaEoK6SSzJad68EZRFvx11spxKCtkuRlm/s6jzBZyrZj7GtfJ29bnxlv/ZO8uuHX7M+iururDb0Z4si2YN+PLpE7m3gBdDrch+zloOtAxsr5GnNO0CAhWosaF1bxQ6baVQhemABleQuagsaMJloxkVO+fdNblPqTS/bX+o0GYsWV8+T9yLbApSotHzB44WSC2UWvcKPLi5tufYGTVv5fm9tgZOwPHY09TCV8mah75SCPR1LM+AnIfQqApb0brmDSrfx8wdM0erqzEyrwVi44xPkFANN5UiymMz05UjlGxd6tMrK6hG41OEeLWe4Yk9eoFJ1IL0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(921020)(38350700014)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yZanzrUDcmsZTS6iUPy+hYuAcxP27lX1/hgNxKlyzR9hJsuIYlDy5doJ8wiv?=
 =?us-ascii?Q?94U3pderNEOu08lCms6awA82TaQoJl9Vqrd3wsjx/rzI3YXQZPJXBN3FGPMl?=
 =?us-ascii?Q?foDZV7XWjX4QuCeiytt9m0yKl8oK0jC/oTNHufa6T0SPSylrr4Ed/13reALP?=
 =?us-ascii?Q?pu3TSCwMnYOtmvFC5MO/o/15exw3hdSQEh2POm3HBwyRDxXRAoSV1yvc8Tks?=
 =?us-ascii?Q?tr2dHQ7DUnRXzfn8WIOd/sabLibo1mMMmgIaMVFKNFl4eaDk860wAFvFEn9j?=
 =?us-ascii?Q?YAVLK39emkaCFEXrGIt5qfJxroZ5Jv4w7NEH0itDEnh+JjhZ14reZ94qOInM?=
 =?us-ascii?Q?gOSKzXT2XymC8V3EwmWcSrDhGP69wOMcohwbJ8sUyyw1HhF2Y1IFvJ/9c38k?=
 =?us-ascii?Q?Wl+nvQvTsl9fvKyflwO3aCEc8DQSSEKIYb/zAjSCLJSiSjyTAVo6ybUHjMLp?=
 =?us-ascii?Q?3se8yrzdZZ0R1ZPcu5R0GTC82ps4zbqqbxpsJV50cgUfYCk9zYpcBh3kglSc?=
 =?us-ascii?Q?FA/Vwl1WlhJ5uglJCY+d8pPjWHdLmgy++sUTmRJ2PFj7fRo+gbQ3Sv3hfQ7Z?=
 =?us-ascii?Q?8zkupG81vLbS9lJL8bw0AsP20dE4FX2OGZV1SCMcZOoLgJMaKpa4vl9NTqid?=
 =?us-ascii?Q?kLAW9zMK4zxOg+6ginXV07EhBMqtBi2a1Jd5rT+IIr95WvPnDEHaQsqSexew?=
 =?us-ascii?Q?Qg9te+zgZSppsOKDGiCp8soIAxIzEcbTpnOSFMGqCPNAUvwWa8ZZUIf14y8M?=
 =?us-ascii?Q?4TmwuzfcTtK37XS5ZXuatTKYBevkhWlg7v9LEYl6W0dsB0G43wcDeZf6nrmU?=
 =?us-ascii?Q?1i1rH32V7yO7qJLmsW2t7ODFf2knA28M6xvYZSwa1tbJz8oz9tECv1a0jOek?=
 =?us-ascii?Q?EHKiL76C508hQcYI4kLKbftQw9HmfywkxQjtxxqXGiM1KHk1aIXrRS0pzuO/?=
 =?us-ascii?Q?jMl05HwHiofjr2cyM1OkKJ2pEmhaDrc7Y+G3MFcZCDe6//nfXWcbwZ2SDGVd?=
 =?us-ascii?Q?WGQnaIgZdIwwvidm3nzkopKSact2tatyDGCogJ2iRudUPb+eh4rvJpEUdwhq?=
 =?us-ascii?Q?JOLqtz4AeMTapoGKX7oC8sfX7jAEeHxErfjUreL3mJwD0iEbgxYvE/pla9hC?=
 =?us-ascii?Q?Axb5ZGKumlVjnvr8/kbCQb+BZslyAbARxCgvvdsY7T8ZUTox+e1wTnDoTCnH?=
 =?us-ascii?Q?ZK5RsEfdV2VtBFKnNTcN3ZtggZjKVwqfX4QCQbie7mg9LdBS1CTI0iUWgcx5?=
 =?us-ascii?Q?xEFJztkJxQeuibmxf9CQ8Sh+Vq03qMB2fa44fbU+8MhFbTFkHPvpirR2CQE0?=
 =?us-ascii?Q?zf0xtBxZDbk6K6iSly5OM8gjComWgFSuLG/Rw1907NJOPYz73E7YfHY1AySw?=
 =?us-ascii?Q?zuAc+qATUT4wITf5MJkRVXygLUzFDEQAXVR5PufW3uc9yWbv5JDWYJzUucKt?=
 =?us-ascii?Q?B/Cbp7eDqxxZgHWqQQMWsFeY1RqQcRUz4MiSCyq5RIeGAnHjLVogXC8V0cX+?=
 =?us-ascii?Q?e5SrbKC/hTVqk/qnZYt2f04NKLzJO9BT7JIoSk2aFHjUXcID3xw1fnH6Yteh?=
 =?us-ascii?Q?5I9B9qOfjImBCq+IkLfPdEhkzs04Imc11hIha33QZliJHSf8iz1Kd4/esX3s?=
 =?us-ascii?Q?BOmJ3ouCrJC5lYwC0t0nd5weOx352Wu+SIKvUuvrMvoQCBmzDLRGPFSwJmhY?=
 =?us-ascii?Q?RbxvuQ2p0KsVGDWtsdDkaM/qAdCQG81+xEMKasa0PmMpL4XZ+oP6RxsFDMwe?=
 =?us-ascii?Q?lnLNUW1wMGdq7UW4vLBUd9Q3j0SEZ1Vv5TWwgpNqPfPQN/5rBk7G?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e559a79-02dd-4248-d340-08debbbb88ce
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:45:26.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owdmJLp3uNVynX5mG1U7Yx6Btwci4vYnuQ7syFQxvDaXAwdcDO5eCyFXcnmp8TGFjfuXKy+i/2RE6R2kAF/CZLp3NGsa6yPH9Cj3XLJo3II92XIMnNROGRs+xzfxChNM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15880


Hi

SuperH ecovec24/7724se are the last user of Simple Audio Card as
"platform data style". It is mainly supporting "DT style" in these days.

Now, Simple Audio Card "platform data style" is no longer correctly working
during almost this 10 years. but we have not get such report.
Let's remove Sound support from SuperH ecovec24/7724se, and remove
Simple Audio Card platform data style.

Kuninori Morimoto (3):
  sh: ecovec24: remove FSI/DA7210/Simple-Audio-Card support
  sh: 7724se: remove FSI/AK4642/Simple-Audio-Card support
  ASoC: simple-card: remove platform data style

 arch/sh/boards/mach-ecovec24/setup.c |  90 ------------------------
 arch/sh/boards/mach-se/7724/setup.c  | 101 ---------------------------
 include/sound/simple_card.h          |  26 -------
 sound/soc/generic/simple-card.c      |  61 ++--------------
 4 files changed, 6 insertions(+), 272 deletions(-)
 delete mode 100644 include/sound/simple_card.h

-- 
2.43.0

