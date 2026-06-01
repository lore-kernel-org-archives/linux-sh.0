Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011012.outbound.protection.outlook.com [52.101.125.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2BBA34;
	Mon,  1 Jun 2026 04:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780289399; cv=fail; b=i+dvVSX+xfFp0SvvUT8vM5WWl0pcAza8xFev3FOOTy5TLl8s0z/r1dHCBi9GQ5QUuSgZANKrVhFkiUiwvDV97R3xXTxlaw3VA+siKc731hpa9cpSS4DT+EymyV8DIpt9cFScgihEju7Tbaus9tr3xTNuCXaq8BjKzjUNEmvsSXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780289399; c=relaxed/simple;
	bh=gf7d92dMAcxN9keht/VkUDTj+BbaXO58n4fS4U0JiOU=;
	h=Message-ID:From:To:Subject:Content-Type:Date:MIME-Version; b=gM6M02Bkyq/EckpNFHdl5MRDiNyt7MCiNZONBe8AJ5d5k/MDI8VmTfmXHPtG7gJEBVtnrrYZGxvHqDyPOA3mtuKm33xvdflvoHkT+7ph+UBWpZYPhU3YGkFR8SOB2z9eIl7MOLBqQskkGVk+xrcTRb5mQADm29IvPfw1HpuXwxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Sxbu0sP9; arc=fail smtp.client-ip=52.101.125.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Sxbu0sP9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAaHpoBHJig/K2rHq/HzCYwYXaivQthafVP23RviizY7Ptzf3sriHCTEq78Gg+3U9ZH59ZsTL4AOPdGOj8tV1kZMrimYjYyo/8TY2nu+V/HZUjmHUf9/Ou4Ud+PfsiHXUzxdVrz9Ctdbe3aOnJMA5gAMRGZv+Hv82a6ptU7it61hap1yz36jT9wSotLTVEY5ejSECN6ZsdRAEjljbgOwN3OGunHVzZQSJGfBbs8qwkEyxU57RdTMMpnFwbg/IgjTdKRFbkIaZezAA19RuJxcJIXPCbrZ2hp+YAFTq3IMof6Q4OfKzXIvRcMS3Sr8lkiZAgcjBs5KaOBu/QmPKiS8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H3RYD1mF9Ad5bG1M2gQSCxzAtnDNwr8ZaGNJbx4jwk=;
 b=K20L1Me+/q+/z6PQrDXBvTv9+jqGQeOTE0ETLbZM7XBzPhaxHu9AZ3ayBCUAMsCSH/2wqeO0Lu709z/oiU/h63lhqN/4wQ0sW7DcoV+3tCzMl4YtwQ3MiX0D0oo+RVzDT1TRR/mKHJeNa40GoqAauAWwVlGUcbckpeWRcxCCdplr5fk/Q8Z11JVMO4Jh6bTSIpRl/ZsUMoLeiyD52QMbtz61yA3DEvRDygitMckihxP9XsOLf8vjcKaPYtjtxpCqQlc+ELwNOsCC05nIEyBWwzr+gpsGkMJ3GC1TReN+bPxlogLDjTMSFk4mOmO0Gxy5CVDb4w4oUn5O3DcIiPHlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H3RYD1mF9Ad5bG1M2gQSCxzAtnDNwr8ZaGNJbx4jwk=;
 b=Sxbu0sP9P2g+1NKzq2kG5ho8ITJt6br9hSQOkyAIdeYLtRSAgHq1hEBLsMKxdHAiodU4ETzFrGalHLMjKzeFJJlnSgO6O/UCG2YknaItVphvuOURovVgiH1CIgZlZVdzAmwit9zzDDg0geDXhzNhqCDlgsUUgx+gQm8BJiqYAao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by OSCPR01MB14869.jpnprd01.prod.outlook.com (2603:1096:604:3af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Mon, 1 Jun 2026
 04:49:55 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 04:49:55 +0000
Message-ID: <875x42c1al.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, Mark Brown <broonie@kernel.org>, Rich Felker <dalias@libc.org>, Takashi Iwai <tiwai@suse.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-sound@vger.kernel.org
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Subject: [PATCH] ASoC: simple-card: remove platform data style
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 1 Jun 2026 04:49:54 +0000
X-ClientProxiedBy: TY4P286CA0055.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::14) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|OSCPR01MB14869:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fc29b7-16c7-46e1-1bed-08debf99397c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	NOseglQFhV7pDE4cmANIyo8jd4a4V+ODX250Fj+AiLKv81p7kwuNEnIjUuEdv6xM24AyDdhpH4Y7iaBiukTpbaoyhct4xtugfPmE9ihdbMm+/SCK9IkZYT/v+IEOQeb0x3dNKEPdMFIvycogIhVyZ3G2RKXOQrJ3I0iBLgi2fWAmBd8Xoj+Yf2rTTRLP085qm+WxaG+p6f4baW3MllkbQ/Px1J2elcenfXU0QiuRybv6Xi2Gt+AeFPA+EZK7E4JgVUdfueZkbhu5x+9wuDG4cOssf4Qb0DN731xpAWD3W8zG+iKhnvHXAmFdKkLftAMu9595c7lx+H796/ul/jNKA9FUpp5upnDQ+tz8Tk2chEY7lyfGC/vnompjD4uIpudbvunGMI5Y2oSPmOA57Qo8f4S2x1Yjbo6zIq3bEl1ZT1FsDaH02XbaXjReI1OEd2egeawpUgxMuGFBX3CySDArhw7uKRV5oiSx3DI+ypDjkRjHknK7N1O1CVZ+VZJnfFXa5y6Z530AcL5/j5Nhb7H3WiQeawHk83O/ejLfv2P5MVL3DafpmsR1DEkm0eI4KbXqDD3YaSV9GYxzTTe2f/fFzMKhyBI8ZZLqsfK131F+iYiXImjvxhgI8Ua6ffl7z9Y8U8oYI4xnTqLqhqr4mw42oCFz/HD4oMq6pr/djlXUEzYz+7qU6LVxL+ILlQealS2yiVQdPlaEnzvn/+Wi27KXpl81sEYBcJKG3BYq18gktqsyY0LRuv4/i219DbxCCSV55RsuIMW/i7ZrbyKht+5ZYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014)(18002099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KPgG+JEs2zgmqzLaWJWkbnkeliBjEFvWrbI5/7UlgPRsopqQFiZ4k0luOSvi?=
 =?us-ascii?Q?u3SUimZasByUFl9hXhUcHJt5yBLk6jIlcc5ldv2wKeF/XaEaNhEIqZQ2JRDz?=
 =?us-ascii?Q?1aiK/lplZU8UEcqSYIWuGjoI5uLpglcjH+oOVeZJ8zGyyjpRZLMKj9ndBSyU?=
 =?us-ascii?Q?KxOzTfX9pBvI5UAd2RlYB/t9uwZwSBsFEFIjoZvXDLMTIRZ0YfTUrLK8WN3W?=
 =?us-ascii?Q?LM0ANuXeLtG22TwOcmtH5nyknuyonB43YhoE2BTaliaUGuLwqRrEHN9tUgeJ?=
 =?us-ascii?Q?pQx9Bx6VkefHJpVjr8CKxSkNjUHJqlIr6pKxlTZa7T56oYGJ0Q5LfMVe534D?=
 =?us-ascii?Q?sGq1ZV/4YFUiQHD83isbNk0LJIAw+kssM8cz3lREc6RL+OxvRyYSV/sPFMd3?=
 =?us-ascii?Q?qb3wYWlIPAub+2T2uvbs4r5okqZIPdeJyXNNa7p3yFBTkQN5HZgDmf4mEWyk?=
 =?us-ascii?Q?Kk3JMkrGl9yBhs0rne7LKnXBh3G3KNhSYeiAvWRKJvLalZiOion8hZKjmjK2?=
 =?us-ascii?Q?CNlU12gd6zgD2Fo3pXBCslwTxtizpSg5ACAJFJOrqnpnrRK/1cX1jsYs9GfA?=
 =?us-ascii?Q?no1tqfvXG4jbgmFteXMxYLMY0VfM0wz1bxrj8uqgrwf4sihy0APS2YrJ8Xf/?=
 =?us-ascii?Q?jchh6cMzFQhHBePGSmMfHal7q0TbVNTrV0C330cLfy8Kq30hkdtgNrcw6LAQ?=
 =?us-ascii?Q?Y9OjO37CUkixsf8I6CVLbVcX+C26B2Sx1aepUeDnInt6/4E1iekkZCqXgeU/?=
 =?us-ascii?Q?/4HlvjORLaqNu2ZDV2bNYuInnJqWfmnKhajpvemwr7oLQbMcuGus/kPGM4CB?=
 =?us-ascii?Q?oRoLwArl3AVt7IFJX1UucK6BO7+T6RJ2pKAZ5IzIesiAQeiBQ4d7p0oi2Jzn?=
 =?us-ascii?Q?bnGBpW6iO7IQg4kPGGxQO2DPDKuCuVIFuqYv356HqYb3LaSzOwDLraJ0DvEZ?=
 =?us-ascii?Q?B89I7UR4UfGHKbBcYzHkJw+VawXrjXWP6VVyCzE2KgEI9bgBm1vRyEGCS6/r?=
 =?us-ascii?Q?zfLKX8z0iXqmV+W96S8QYeevDRLwpFCZyucKfNbNExdn4HxiYDo3kmziPZQy?=
 =?us-ascii?Q?Rdh/zHy90HaRohwSM6k58Batk3I9/fUBS3Vnp3QVfHLb+N5z6KJBlmk4xHBk?=
 =?us-ascii?Q?C/PFkwZcK5xdCYUAv1shZMsZvwj7snkcJNe5/2Jm9qH+TPpHsjU0fXYb4/XF?=
 =?us-ascii?Q?0kLtI08aOXKYd0kMI1hkbXm5R7Rs59LwXzjekWvw8EYeft8bjH5GHkvX6pLu?=
 =?us-ascii?Q?PlqvnV2/WVZyS85C65J2YZ/tDgE8ttGQdfCrHUiR9Ork68Qz3uwSplpEBcES?=
 =?us-ascii?Q?voPTpcQ+9si+vcQC47ckv5pnunDzz47FMuEXyyMiCrbtX7EsRlKdXy9UUfwg?=
 =?us-ascii?Q?N6mrAO/KFZmAPOrb2TQXcScm8OerTd/Fxu7+jJFRGbj+d5Y0H3/O7tnE2ALB?=
 =?us-ascii?Q?2Y005yjvOrXLn5kGyy8feIEIMAFkxAYXwj6z5rvoERpnJlzWM6a6XV7EFCvv?=
 =?us-ascii?Q?N3IBJ69w9b9FwUC7gXs861AAwc0sdWJIPJGWF+hrQJNjrT2LWCp2mukMEGvg?=
 =?us-ascii?Q?DMIXBvXM/5DghUa4fB0BYoAmfMIrnpiXDvXwmtfzmASXt7gK2ByTrSq/+uUn?=
 =?us-ascii?Q?E+a43XIlQIJ/1vfwp9Zg5TfZljTUER6vZzL0gy8I1C98ulMdvKwm7z0Csqs3?=
 =?us-ascii?Q?dJWv2HcdDNT+x6KlvGGFqJPcB5/RxVFHP239DWO+GnBgAfepiQ8tMwfiQTxQ?=
 =?us-ascii?Q?d/shG4SW1eSGkAoOcXPgmbnICsiz3aVi6wUjmRrPjn0za+hqH2oX?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fc29b7-16c7-46e1-1bed-08debf99397c
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 04:49:55.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bdc/MemxeUBm2ceOPRArRTgFJfhWTy+m3WVfXZrPX2ls7LepmODj22p6uoBtnosWqh5q6jAf1CUQA2m2yNVBmnn+gooV5zd9BV11bdrq8XKgw4776MO5nwcvSD7jxYr2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14869


Hi

SuperH Ecovec24/7724se are the last user of "platform data style" for
"Simple Audio Card" / "Renesas FSI".
The drivers are mainly supporting "DT style" in these days.

Now, Simple Audio Card "platform data style" is no longer correctly working
during almost this 10 years. but we have not get such report.

According to Adrian, SuperH is planning to switch to "DT style". So
	- Current Simple Card ("platform data style") is not working,
	  thus, Ecovec24/7724se Sound is also not working.
	  - FSI "platform data style" has no issue, but is thus not used
	- SH will switch to "DT style", soon
	- There is no active user

Let's remove "platform data style" from "Simple Audio Card" and "Renesas FSI".
Because keeping compatibility is difficult, and doesn't meaning anymore.

This patch removes "platform data style" from Sound driver, but will keep
header (<sound/simple_card.h>), and do nothing to Ecovec24/7724se, so far.
The header will be removed if SuperH switched to "DT style", it is needed
for "platform data style".

This patch needs Acked-by from SuperH maintainer

Kuninori Morimoto (2):
  ASoC: simple-card: remove platform data style support
  ASoC: renesas: fsi: remove platform data style support

 sound/soc/generic/simple-card.c | 61 ++++-----------------------------
 sound/soc/renesas/fsi.c         | 16 ++-------
 2 files changed, 9 insertions(+), 68 deletions(-)

-- 
2.43.0

