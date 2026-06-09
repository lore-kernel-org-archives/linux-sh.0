Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010053.outbound.protection.outlook.com [52.101.228.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7D34250E;
	Tue,  9 Jun 2026 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049180; cv=fail; b=boOmjUJkxgkLGrUIsc30WRTsbRuL1ywj/pUDTZV0jKfjRg/c5hMgMHB5+fGmp4Av5jrUjuHjY7/CT2cc5eMlWc7t5OLvcEV7NCMyGU2z/b8O7PABqcR84PnkftNxMtfrWPlCVwYcdDluihzvwJ3+8yoImYi9acwNBLIztf5JHeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049180; c=relaxed/simple;
	bh=egp5LTiELn97+Yr+YqlBZmZHb0oMz2HQ4ewm/qX54TI=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=seDFXBra0D8Wc4ChbGDj3h3+NwPSM7fuy2bR9lVkcSSEZnmGd+leuM1SsRfKx6jwESp6yAoWSDbCPl6E++0rlOSwbDONtYjolhZnuO6+gB12u8f3aBFU7P3QTHc/Bv7MhHzrvyMyaTLaleoOI7VKWEn9zI4xbFy8u9amcZU249U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=WqSXBrzk; arc=fail smtp.client-ip=52.101.228.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WqSXBrzk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKDY8ifhCkqQSrlGYvu8uhMUAtXuJELBVpYL/p9dPWHNBWA1Q0kVParrfu8isMKQ1nIHT7iRrHt01I7C8SEjY5z5AN0jpU33s61FW/tz8NXImlcwUbJ/JoiwCvS14Ls28y6hmUogEIkhWbNkZYnBC6pbrp3ma0fADFO7CrYZz03o/XeImKsEk/Lzqaj7seb6eQ2E1MnNOlPrzrGQ7/dSRqS6SBvn3sNan8bCEzTD5wZuPds5HWo2kkYHEd6ofighg/+EbEaPjJM9L5ufnX1tpzUcRihwszAgD4LBMX2hJtQRRSswqQkoiAQOzxqkstJQFH0AVCibdbfzz3zmsmjXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiXNwJ4SC60mM0/5AQSGJCdKZFgxbsFPm17J5z6+eWQ=;
 b=kbwtkBDT6BLAJXvWu7D1e5Tzql3kgmNHwmH/A477+BTEJYEghC51O9yPmBvaYxwMzhZhQsbRD+5iIXjha4HtB8PLpz04AvIz/CsncLFtkKKzPUvUadY1OCp65VHgYXDDwAO3dT6FQjT0SORWg7/qK6eFTO2Qv3UQ3uVT7WJvMUXODWi49zLd1qh7Lb9H0eo/LyLu4R9cFE3IaEtSiFaSiK+Bp/84NGxr9epO5/gIzjlTdyr9Q3A4BKT3yj14OObn4723bdWM8GPbiez5ZyDRtkSqRxjW5ODzH0ijgK+QuKJqa6MZgJGqYGPC9LF3FhAs58DmF7c9OPlyXv/zB5WSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiXNwJ4SC60mM0/5AQSGJCdKZFgxbsFPm17J5z6+eWQ=;
 b=WqSXBrzkqc5YoBSLUeHT5UR3RiKC+AFgQxSLi4VlAdumixnVgQLSZPtd4XzngqbY0vUGpbz61BKmAjQ/zzYqQk7YPUOgUjTztJYDHu67oRyJlpaR2vmCMYR9YS+RdNfah6GB8XkdyA+pSLYxnVxXbApLKQrVFP7zE7Ht29qVnf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYVPR01MB11247.jpnprd01.prod.outlook.com (2603:1096:400:364::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 23:52:55 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.21.0113.011; Tue, 9 Jun 2026
 23:52:55 +0000
Message-ID: <871pef5l0o.wl-kuninori.morimoto.gx@renesas.com>
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
In-Reply-To: <CAMuHMdXVWPxu-5BXAgWOBoWdNXxZ2zeAfTovXxftXsKuCUUDww@mail.gmail.com>
References: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
	<178094130630.20828.12708103059145547835.b4-ty@b4>
	<fa7d7af8a780c27f85e29c518ba45e39ab18abad.camel@physik.fu-berlin.de>
	<CAMuHMdXVWPxu-5BXAgWOBoWdNXxZ2zeAfTovXxftXsKuCUUDww@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 9 Jun 2026 23:52:55 +0000
X-ClientProxiedBy: TY6P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::18) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYVPR01MB11247:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e3dcc4-8920-42ea-8291-08dec6823a0f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|23010399003|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	BlKipoeMzv7nzQxuMeZp41Xybn/pu4AaiiZXNc/P4aw2V1QMlY7rOB6trIu+vpMwFySJ+kLsTKyvbefOkEiFZHhegNEcjIg3kzE+NyuieLttKdPjfXJsdWxNkr7AbuAnpZPbwXjyA9MiqnOeQSBNntFVfbeGFJx6SnmMQF8Q1jKNrR3LyMq9h8VJr/GxrWsvkjLvFAbKi2QtBOoCU/Z9si2WoYeeC+Sgqg6CO9YddfdxPwH24Wi9bo4mZSmdZ36SImtgZFxLCl2doqh8gQTnRaEaZRdwYbuoTM23UVUTP8gpYaaanGB+hvtbso4t5Mt8yzWWcBZ/vs4fyIQIFmAVbg8z3nFEeGpl8ApfItIJr2EroZXN94VHGHuJfV4tHlqfPs3qvTMsTtMQFd3tBSBPXpug/XdHHBVpivIekYnRFQovugRL9Jy8yUkgoNp6xtJvc3iV/ZfPwQg58rhZHv1cCNViyrJJf998XDyMwkYDJURh08oBajtU9qHP74s0jC3bK0FxtYtpey9aOFHRSXCI3I2lgF6l9/YVCc0uzoBsEtMJ8PQ5ci8N6xK5EUiAVcq++rfsW6NJ7WnxD9IR/xjrTT7vpJuVdgOWySEdx8KxKRF78y1BuoAd8TCCUYVHk+Eiopuwi6661seTtVr8QGgHlpFt/+zolLjdiLUGU4aWjmZl+lOiEPj5jYaHJ1k5EGAJTc/yVNfMPSi2OyKmEs2c0s6Qeu2nOb7KmrNgw5KNqNMVSi+utSUgB9dIyDU6ubgh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sdb0+CvQsFJk/YOH47x+4x/WWILMwbYgchmV9L2FBsJCGA06HawnzM93HKc3?=
 =?us-ascii?Q?Xyxxy4+kVW0CgTJH39X3WYNzlOfOXygK3+lZuhAziCyB0ETqynfupLc9e+Pm?=
 =?us-ascii?Q?kf+5h416B+6RNswbjPR1u0NxAOJCcI50qxrIAhbmbyPYjYlIt0SzVyOSBpN4?=
 =?us-ascii?Q?h384j0YRus65o6fmO6DY4X+nbijNClXDzva18hv3zaVoLCWMNxzUz4Ka6khG?=
 =?us-ascii?Q?RlqImw5LVuHlX98awLYDJ1XxsdTs4Y7B0tFrp8cY5VHmMw7ivJolH0RpZ03z?=
 =?us-ascii?Q?SUt0CGq9PZNCTI0uGpsHA/u5w3hnJqDcsxr8HZHs3QKSO+JZP26+LoWE6R8i?=
 =?us-ascii?Q?QzeAnudbopvRrQ8pvX7h3pxDTNzNylUCuNyO77zusbAdxAMKGDVfgOKdm7dJ?=
 =?us-ascii?Q?SRgkb/Yapp4Fg20kGAWUThaWzYq8FP2vA9CjFnnlG2IV3i6zqGhN2d6MSZir?=
 =?us-ascii?Q?zSUAGc+o25JY4FwTbCx+s0ADjcoBD/qMxUhXEAqsRM67cysYbgQF55Dn9Bdi?=
 =?us-ascii?Q?Uz0rBmmKnuGGbxK0RFmCovtY4zE6QOrShCGjL4ukyZdJbhkGfkXDR4h2o8ce?=
 =?us-ascii?Q?4nAgpbG98FXnhzlukjPNOQLUp1NNfVnq9qd/JzPqfwRRm2UrYHoEY7w7/luv?=
 =?us-ascii?Q?F5D8MqWGxtK+gJyd75v7lwcZyMmbsFpGyPQa1pgPQOXFQYJNfxzCwCLdokwR?=
 =?us-ascii?Q?G5EkdajV93yXZMiHTXrwsaizK/dN+2Q/FzOkXbAQHxH/Ec0cD2uxqQ2Q1TTf?=
 =?us-ascii?Q?ntW1YzFa2Krvy2TfarrqgSiMI/6USc6auqm+FvBeO8OhJtajo8oOshK7pd0r?=
 =?us-ascii?Q?WsiiIinDPyA41dmoWg83JafQdMIaBKgMZhUjkOZ10E6YZYlSPOOTThWH7JHj?=
 =?us-ascii?Q?cRwckw/jD9CP2d6yp9apmgLV46evCE4Xy/BocDH7v/odVDQ9xwFWcK/JuSWn?=
 =?us-ascii?Q?+5T0ddpB8FUfI2B4MyiRcHQLvI6JRHr0FwkWghlTE7DfHPraSQxSrmZ7w8XZ?=
 =?us-ascii?Q?vuA5nM118RBkOCyhgy6iqSvpTnJy09NB/1z0oooz25cfsQSFKFFqr1u1jp+B?=
 =?us-ascii?Q?jvBFgqYaVuqpTP43A/+psUD7bFzwy60RXa1N92zjGpW0v2+E6LEoTz3Z/yxS?=
 =?us-ascii?Q?DqpEcn3O14DNmvhqff6cBiwHnXIXrV1EqrRu0UxBbh/TK13PgEZr52A3s1ln?=
 =?us-ascii?Q?qEaSGfW7vTGze0/INW8aJJiBKfx7vUjxymIbqaypv8KKBNpiAHw3a4deU5Pu?=
 =?us-ascii?Q?OtQ4EvH1jg6pccMzRed1DaSZkUa2mqkXUeJtWkqhUUsPAFGHQyMt65cMPflx?=
 =?us-ascii?Q?3lmaPsfMW8AWqbZHGSXhmhIFGSkirZ9oZdfnK3N8JIWd8vb87jEEnyObBCiL?=
 =?us-ascii?Q?lmNaGyMSPB9ZNHPqPIzzaNn1OB7ISqzXD1UGdxeoAI31mIBnZ0/6uPTT2yJi?=
 =?us-ascii?Q?JcGK3BXI3n050VnliSkqIA+pFVRqQo9h+bwTxwOJPcNFBlYkeAydYZ8gLTha?=
 =?us-ascii?Q?FzaBY2bE8D1No9NKH7uwG6WM3+BufWU9+8belblGKWPVJCcyGb8Icd2AicvC?=
 =?us-ascii?Q?BZE8l2SUFxfADq2qZYF0kI/fjXcdYv8aDw2q+C9rNrib+HaOyKzExv/QMBDs?=
 =?us-ascii?Q?ydgVXUkUbsU06KkXeXwuD9iQqE/pfp/IsY0aMV4gg7CZidw5sRobZ3Cw9GfS?=
 =?us-ascii?Q?bjBkpD/HELrjSxXs6p6tg7/oC130YaMStRye5ZSpReJlYKtfYf4Ogv+fJ5IO?=
 =?us-ascii?Q?eNPZXeGqbtzuyQ//8Fz7UTcH/ydTbY6QAI1wDGuCH51dfjaN9hSe?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e3dcc4-8920-42ea-8291-08dec6823a0f
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 23:52:55.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEqjyZAbD5tlfw52o3qFv9AIdxYifJNnFzn1H1tQBXkbCW2He8zHj6CAmqKHCoEn4UHWEd6Cm/iocPYZh8cjBVQTvqoQgiqmhJV92LRekzZfkApRiBOgIy92kDg62VUr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11247


Hi Adrian

> > I actually wanted to keep the driver and convert it to using device-trees,
> > not remove it. We have an out-of-tree patch for switching SuperH to device-
> > tree support.
> 
> 1. The sound driver is not removed at all.
> 2. s/SuperH/SH7751R/.

As Geert explained, removed was "platform data style" support only which has
been used for non-DT user (= SuperH), and it had been no longer working
anyway. "DT style" is still supported.

Thank you for your help !!

Best regards
---
Kuninori Morimoto
