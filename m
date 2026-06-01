Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011012.outbound.protection.outlook.com [52.101.125.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD0306776;
	Mon,  1 Jun 2026 04:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780289440; cv=fail; b=ZItuuyZ1c4ByzWWm2t7vl5Zkw0QilRAYVoqdD0ol18eIKapidul0kp5Ji3X5x7XKqJiaMZ8wVhXdmKzhCVMx9yZ1RYd0nbVfZeJqrPjM9ZOMqo6Gehlnk7YtU6+pIKDEiAbM8VX2ymITXHnZxk1D4eJxMeE0tkmzFRjLECxygd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780289440; c=relaxed/simple;
	bh=8j5h84yZCuAVhj9UZSPonLTbz3mcrBbSAPYdiBrbREs=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KaB16cTVeEbwBjyi1SJzQQfxV8Hp9ENgDtxn71cGPQclxLLyGQh079wpOMdxdKPit3ZGlvMRrdurcOfJrV2ucIF+ax4UFLOZfIN++bjn2xklv5Ca8fAMtyIndj9+5ZwZjSbqy3XGsGlB4uxfO0Rz2oWTqDMf77nQRdDEzm9uqxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=DQgn7BRk; arc=fail smtp.client-ip=52.101.125.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="DQgn7BRk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC7WPsWznz33yzl1uUZSuSzaFwNVK/jG5Qk6Oh7jLC9aAz7fuqgQJ8LTWZRzsblBOED4S8BevfO1mdIlSbfVGsrMGYiiGeRjrIYOPH7R0ZaNNcmBA8yGra52fxqPLX6sIb21e5zSEc/1rzT8FMEd5AN4yF/aIJLLNHj+jm1kvkdeza795KVX1tPB90xR62sTmUmOaGCpB92Ga0zJFuvls20Gw/zKV3L0wv0tv6NRUA0stRXXFd9FsMQKjV9vf9rfdgfKtiC5QDFCXdb/XrGCiEVouk6gc4L+U2gnk2m/OojtKU4vBck8PVor1U7o7MgB3fEbgfEp/vkswkQ7n2PjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvGEe8xywwqv8Z6AjnXsRTT+eEnCA5byXFbunW2jCS0=;
 b=FtbZlf7iumwk6Q4MU6Nx8zT4GPPo4FirCO8H0rXjM752nhbAxpR6I9D2AzUUlTLg6skaS7T2XEXrsY+gE9RRF2DS/e6SEsmRf6Uw1R1O52miHOOqu4lgUqaLCx9mKEEnqFl/e3K+sVNAtkZfZNznaO4yWRwkyyfDYYdFA6Bg3xU/N7PkNbS+pstgIrxrEhezBLr82tsyU4I3Php5EgEjGbAQlbJPF1mH8PmCKy//kWG+Q4jM5Zzo9xkUVSlTrZynsFq/JXl4XBk1Vo301QF/p22G3+wwqITmVLII468R02Ayt2ZcXHYr+e70WbUM18p9izf6tgrgz18ARQXimhlv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvGEe8xywwqv8Z6AjnXsRTT+eEnCA5byXFbunW2jCS0=;
 b=DQgn7BRkBb0DtWiS2jLLh2RS3kCDZF80WSbAywPov0oq7geO3BRiTGR9bY+QMS+0ZDClkZs6QmC4v+8BPSeQnk1Cufk2qNRwnIroOZsHdv4+tHPkoZ4lPByrCmesCCNA/soXXHgrZW1HOjxMEvY6f6IOIlLgLWQXGzEkavsoG8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by OSCPR01MB14869.jpnprd01.prod.outlook.com (2603:1096:604:3af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Mon, 1 Jun 2026
 04:50:35 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 04:50:35 +0000
Message-ID: <8733z6c19h.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 2/2] ASoC: renesas: fsi: remove platform data style support
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
Date: Mon, 1 Jun 2026 04:50:35 +0000
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|OSCPR01MB14869:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e13b1a-78f0-41db-0198-08debf9951b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Em5dByAta1XBN1KHUCkh3lSsSHCoLp65Rao9F+1nrF4YiwiMHYSUZdNB0mo8t3zXPFIJv1X5ivP7AxMmcaJ1wz5do43NPV1o8BEZm97vmvRr+MB9JWVCvJAs6OGwLSvlxynYp1x8eIXZXCpbjuflN0Ock41/6n3u4thbAXJXYFi0+99/jTnR1H/lYRMzZNrk+pbIWQnFWSlkH2Mjz/SEXcv0yuVnfvzO8NuEAtn76YZuziuMRnuzG61jIPUKW6+CX2wMD9VSzZDwgynCFlekBJs1ZoZHc9zi+uzNRoqfMD7Tvy/Uqb8zitGu59YsJ1XjZtFimVMEojJqqaBi2TmEH6KVvGg3mBY/ttwVX9yIDLKQjlggmMe5pW10PtY1IrNbdnDSVSe5aMcz1kgiwj2qMo0OvKuzUOiJoK1liI8qlltk4ZKtmNKBG4QbUXnX848DH1r/CqyPTyLKGaWrBqE4G/6n1aMQReDE4zAwSoqLhK8RMgpxK7lWpTS4ZqkofxVC2Eq1HzUqgFRhDisDb2aZTemM+/QvbO/MxrvqMaqpV/sIeiH78juO7KLrmJK29rhS1+BDpvUTolNji6zzmAR5vAAt0QboOJTuvWHhIFRm6yngO0kGg5z4Wxo9SSBKdfLK2gGFcMEtf4k9eNvaSvUj5zJcA5PwSAXWtNCNsYhOJzssZGYwz/CYgJHHlQh2J368zsOeFkX3uDq7uPpmaTfInVX5y4yV80duXbjSP4tba0qRU0vYh9KgP9Hj6bMDsJ9KusO+xmIG5Gl88kWt1OKUpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f+RyxjWtXqxT9h0oOKmItxKuYf97vYOoqWGD5zfJggdD7+ZUGPVkgkDJ3627?=
 =?us-ascii?Q?CYlwaKqLtxp2PTXhaL22qxYsHL1168YW7qWgVaenJ5JbJ3XKdtcYpgsGT+iv?=
 =?us-ascii?Q?Kfe8Obps0PWUVhpJKIWqTSoKNabAtSHV2Gq29JRtE/sdvBqDBB4vxUeaavPV?=
 =?us-ascii?Q?qXQi5vCt9bUvagjKCMKKL+usMLF/VjQ/idnVhxTIGFvfhW0Ai0zQUlajln9d?=
 =?us-ascii?Q?c0Ejzp/LAPl79q5sCkdVRgdum/GnSMKjKX7Atd6fU+t5AITi1wztoO4cZwrx?=
 =?us-ascii?Q?uiCq7p78uRaYz4bd2x+u+jE59Q4PtBqvPKIClY+1+V4iJJ2EshSC5+4dtxsU?=
 =?us-ascii?Q?EOvv+t6MDWIjrHWmFQ6Bv3bmZkvOTofbPQWQzO85GRLY5He89XOm50jjWVbG?=
 =?us-ascii?Q?vHtUc4Ew8ZbHhNYg4/xhrYWB2OJdHU4dkXbRTrCs8HMF/2ATJBDsc1WFGPBc?=
 =?us-ascii?Q?ef4ue11LJiv/WbMykUCG2jcQriuSVtVuzmuRVM9tEwL4DJAa6cFkldq3Hwud?=
 =?us-ascii?Q?FEhXLOe752BwK7ekZNEf3BKv359rpZELFcPjZKNmi/sBeTAq7PUrTaFZQfXK?=
 =?us-ascii?Q?wO/+iIdcZT3khYJTuBawvni5tWCfCQbLdrB5rWyLqnPL57V6bH3rKUKdi4V4?=
 =?us-ascii?Q?LVtyZznq6t9oF6qF/qKc9jMWEGGQ2AttiZ6GZADHmX9hBKkyj7GtdvQ67rBw?=
 =?us-ascii?Q?7lrpd/L3Gzr7jpXmRdr4x5t8V9KAbnUvZOBp29X5EBd7GbTC0Rs//0zscpXS?=
 =?us-ascii?Q?w39wrrVcix8MxrJZ88GZa8Z4tiKtpb5gXuzbo4CyxHef37DUxWutvqPbTZRg?=
 =?us-ascii?Q?+/5RkZmM65Pd3GPx6T9siw5j9wXXZOSrl/Oj96/WTxTbadm69ymtMhE+9OgT?=
 =?us-ascii?Q?4h8ZMGk/R2BE5mNLZu2GJm+TkLjlbsMEzedAyW6Q7+f+flADM4wUcqHj3x1R?=
 =?us-ascii?Q?SEL9dwaeXZYBby9Xqtzuj4pGafAaKkVWLDu9+/+muRGlLHbMa2YN6NFeIHAl?=
 =?us-ascii?Q?gy/XhkaM6nToNgMscCfxTZvmpZkTw+4VjFD0Wy7poj4JxZphbO66UTOADTKM?=
 =?us-ascii?Q?X/mDDCpUqFHqNW7BkvbPCJ/qCoj3Tm6JMaHoq9KP9WoPuN95eZZiwIhvowji?=
 =?us-ascii?Q?IsExeq8BNznte+MOXF0Bm1GmJSvydL8jY4qyJahNmU2ozdXskyBOkiM63yff?=
 =?us-ascii?Q?e1SFFpH3Dn0tGfb0K+OvE2UuwUtTdfPoooNDWC5e6kcdUVbDeyoQTPr6BaZf?=
 =?us-ascii?Q?1ovS5mC4Is3PfCFebLWnT/fHVGDQVfc6cJCFSRM3euO7BKKFa1+J7JHLwrru?=
 =?us-ascii?Q?4XP5FmrTu92cCdii7S0cT8FP+n/2B/aOHKqRgJcBgKvKbsg4tdqViaEARLO0?=
 =?us-ascii?Q?xZm6jUY0eu+Fv8Nvmx0sKUdw1z4BufzUBmaq//OrqBLy44w9YJTDP9L05DSC?=
 =?us-ascii?Q?sDauN2/rLwgWgg67tmpkmVRkC/OvnQ9nUXmkEdPDzGwt8zmJYBtLJ56tPqDw?=
 =?us-ascii?Q?C/Yg0shhM7wsmgxmjVLPFSu4kfYyWUvoRkt7XsNCGtEjlq+UjuWgyj4geIHI?=
 =?us-ascii?Q?d65hzkIUxUM8s0iLZT66dsPUFiTrDxaFtxklbQotktdRQOz83bCdG9YN4c2l?=
 =?us-ascii?Q?aBpt1lnREs9NFb2WuyOJQKEF33yLFmeyl9i8gJgSQ092pElxauI1oRAORZMW?=
 =?us-ascii?Q?B2sbZ98gTjM32H0vxCWhKpWFbuBqSbxhsMiytBlo12u1z9xhp1c3WIbx8z62?=
 =?us-ascii?Q?VrTm/I5cK9+lRZ0cb+E3XDp6/8y6VFutw7sLdgOryrEPqdPu4PSD?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e13b1a-78f0-41db-0198-08debf9951b0
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 04:50:35.6130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqa1gMTq2lzWidM5nuF48plPqpJEGZgjHMoD1vYCLGdXJ8bOQQxgR39swjXeZY/zmgOnd5550bKqYrTrpM3sWHxdxBSzYHE6pKeAZzzkJA0cWIuIgI21yvPwYX5riA4v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14869

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
2.43.0

