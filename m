Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013033.outbound.protection.outlook.com [52.101.127.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4513AC1;
	Mon, 11 Aug 2025 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895965; cv=fail; b=Rm0LrfVevdmgm9azbXTvCKt5oLhFb0rXLuo91op+xK5XlKmKh7x3wYuYyNkozwceVLIJkLsIKVKm+5RWyNwDLQ32WulSbqEEVWwd6yaLlma4EhgDK+8M9QlDZQzFIsCXbVHptWET4M8Xf5Yvij2BOUop3UJliIeX02XZ/nqjeRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895965; c=relaxed/simple;
	bh=Dir9tKZ/pPb0Kab86gxBtQLuPu1usX8yPxqnjbE+eg0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X2pDv6yURzr7hrGFrC4TyntcBrQQ9/5AEZQY1rJBKQcyReXt+gE9dwJISk+LTYcbTd7z/yxAqiBjU5U3FEmEm1wy6m4Xj1ZbLbLRB2qPnUBsAjBYH2/4+XsELO5jTRyE/89z7OsNHsqItvxqXbderh76iiLLn9sa+Rp+m3dI/z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DHgszwVh; arc=fail smtp.client-ip=52.101.127.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DHgszwVh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyGpsf6xItE3ZqeYYflrP4x/7NykKGhtmR2VU/Wm1QAy2Aw7vd0DJwbjZ04mLjSKZs95ihYGi3In407RQQEGP/A9qqIG7Vh15kNYodJwQRZPJP5A8WE5G8i6hSr8AXYE0YqWWo8EOQ4m3gVqg+Lll9CXJPbORPILqEhOGKuF9tmiSJwiFJKzrWn5YTTZWZZAW+dK/QQXhiNRP7t0HUvthIxiiFwUk+x+qWIF9kzzqwZNJT7ZDaPz5145iCsAVc0oVCBmvJIevZyTYk4uW6gBkFGBx7SpOZ3mKvUzbTbl196dYXLoNWP1nRGXd4uZAUzjr4WnhEeWSHUg8pDEJ9ZkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8u3nDtlS0PM/t9Q7IlhaAmKTEM/e8xbNfjjbtbOd6E=;
 b=IEpxnSEzy9VppgwsMci0984OcqFaI9EW8IdLLs5VtmGGjwOta7tPJxvM/cp0bW7op7s/i1afi/OWI1ZL0lUjcpO6ToBEut+Ek3CiqD6q479KlYwQBhezj961XDcWs20U8WzyuaSrZkXBGt9+ejqHgSCCf6y1ouY6gJB3dXuLoHbwmSBDOXS9PpWtt5afqmYas+MnvrTvflSm/zFpbcqg9dZbMeq42z4DVloGk6ouPbMWsGWjyh8XVmBb9ZGf/Gh4lBfyRXowf6JJyLygbJaFWNhV9ei+n7wSfkPaHNfYhhbe1aAaMlb7ORXzU/fZn+eG17CYfpwDKWQpRg19QbqKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8u3nDtlS0PM/t9Q7IlhaAmKTEM/e8xbNfjjbtbOd6E=;
 b=DHgszwVhnTr4oP6ZizJG4Jp+rxuUVFyivjrdaLA5GuaUFOqjubgYEirRrf6hZcbfGZD9ajW4V8Cg8Sdlk1qwtATdn8xMNSIss8Ir+cL+k2U+08LSwvYRNDFHbj/bAY0Bv/o1E07wvVsX2fzj9WEcglnxaAWyRIlOsKBSCfWear7BmgTfz4JUiIp+8RcH2xpIQ0Tv157lnt40aNBTe7k2ql91QW2lvcxDi4L4ApieLSVGcLa2XC04z3+PQCsYqRoE3GSNFLnzJvwV6288Ln4jXpNKqeYwzU/i1n3KYM/lEcoD6JCm1bIh7UGd3WNFZ8EPh0D9/7O7TrJSmdCegbWpFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 07:05:58 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 07:05:58 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] sh: intc: Use BUG_ON instead of if condition followed by BUG
Date: Mon, 11 Aug 2025 15:05:48 +0800
Message-Id: <20250811070548.352955-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::20) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYQPR06MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cca3f4-fa40-49ec-834e-08ddd8a585eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQ1IVKlrRyL1s/gXRQHH4M2k8151/G/9zUrwBLanfnH7N4tF9s8MllxoVO/Y?=
 =?us-ascii?Q?yEZKx3UJ+OMz6C6ZbTzhogBJHBJ6wl3aoHf1eha3QMd7dshd36uMZKu5QFn9?=
 =?us-ascii?Q?xPTPJU6yGZq4RfMj/MK0dv6YAMPc8d5dqqU4mF9ptxxkAR2kfeXkkjjzZom4?=
 =?us-ascii?Q?+lml+u1qIg1yaqcids/kAa+Ohl7//2NoeIk5XVUacsh8u6wT42EH+d2AN7g3?=
 =?us-ascii?Q?n3Adx88O8jFhZXhIe5f+RsSPzTpK1WH0JYe+CpnIH+S0MiV4gWldpsbfuMIu?=
 =?us-ascii?Q?g1xXkN8wz5GJ9mG269Ez5PR7jhB77vKdQ5QA5qy/8cAyAAjJ5KPJvRY02sth?=
 =?us-ascii?Q?315IpFLpKKnIuzYejA48mE4hEZjY/1Qh/Y8X/QpbeN2dCA1GCslcbFnCCwdQ?=
 =?us-ascii?Q?nmsByAe3eOGCPB+pwwN7xNCAObh41bak/xmfR0ReihFJrXsrFze8GYgCn8sD?=
 =?us-ascii?Q?D54PmfqUTYROQSt+DudGAlrlB7tEPRJeU3CNm5kWS4u18YgCERMtD8FM4COj?=
 =?us-ascii?Q?x1GyD6Cufif7PB+EoPKBUS0TfqxOZuengRkb0iRJxaVla+whV5UyhuBwz7nZ?=
 =?us-ascii?Q?d5Jq9LG1lsaMU9Mwr5vcRTipBXf53YCG9cYXUNk4LWC275CERJyIFPmjhUnG?=
 =?us-ascii?Q?jqPajZbvpH1WjJSnAiWDk2ERT5H4PJ0cP7HQdExX3AHFQHwTb54eNlNNwuVG?=
 =?us-ascii?Q?Sn0uYE7ZI+mfIchfG7ngH4KGDngL+rekuXMnR7+OoXMCMjg6oCGDd6rF6q89?=
 =?us-ascii?Q?rs0mfrHgPg7PcuPOQzp/IczfQPXoBlDbU5xiyTryD1MdkkxK/33MIMRo4EMY?=
 =?us-ascii?Q?7XG41M1Y5fZ6nTjwAYwyDSsfZHAy3vKhh5awgf3iB4Sq2+VBjs22M7Bd6hJb?=
 =?us-ascii?Q?kDvsFaR1Dy26ZpATTKvks8H3gpfbVtEBD/8VGBN28OP74lMzeNiKp08Ql2ry?=
 =?us-ascii?Q?nhKiJxOrTqylfXkyKZlmw2FDe/ozBDgD1bVY+jjfywc6WNP9Ms4bvmwtJx2Y?=
 =?us-ascii?Q?HpDWJM7nQQrb6csQ5Yzp99MSihs+ngCwTRW29mI9Tyc1DIUIDZ9K5aaKNcUB?=
 =?us-ascii?Q?IAK5Gm7RBIYD3/IgLnSlLy080AcTTWCg3KofXHLOqMoziOjAkqZ5HLcsxe++?=
 =?us-ascii?Q?ovoIbhpz2XISbSBnSRRvqIrGcCKODku+iq9/M72rkfLFM+CD827OiGhlkSIV?=
 =?us-ascii?Q?W/LIjGkSBmMYyWJbEIRv+T1pUyImBUT9NkqbOHze2qy6vguEmFZih8h8Yt+s?=
 =?us-ascii?Q?rUMKVMen/M8gmyQTNWWm1MVr44t1v6MOFtiHRw19AwqrAq4zjj+UOciRSINW?=
 =?us-ascii?Q?D0Er8i4H3AVoj5NEHfANSWQUpKG1r+NU/9RTbLpTYPXoQJW4PyXxHKJOSX3+?=
 =?us-ascii?Q?AmXZBaoKpF3oe508MRWQj3jvXygGDRWlEU+wVI4/OWjlcaCnuLs4McIQnJvL?=
 =?us-ascii?Q?F/jz2Mn5ZNieJ5m/eKcPUjZ0jp15zujUyF6EgD3T5rjNAgm2I1s+5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?56oXLbYlXQVf+SnPuoFNYxJ2Vs9FH4FJbB4Lgk+hziFm6tfGs7hSzMqkpJpF?=
 =?us-ascii?Q?wTqk+7dqvPP584hmBO+wOehCkwfkIKdXO8MU43+Q0ihAq/Hq34IlCRC/S/vL?=
 =?us-ascii?Q?GzL8GtuMAkYqmDCX2FppNSEOoV7au4+UlgO14BhcNav2RQg6fi3mRGuV0sYK?=
 =?us-ascii?Q?L4ZLXI+FHjzLCBfLLQiKP1K5rLPBLqOnkLTDMsDDInlficDw6oKkytAqDQpr?=
 =?us-ascii?Q?T2PVchMYIXjX9Lpae2jLn0CgxwktQz9hMtz+oDGOF7wpaEYXV9PH6zpeOgWa?=
 =?us-ascii?Q?MVXBaAUAAXo7eyGoa5lqgR3HbzqRZkpEionvxZX20idhIIMP5vf8nqgkUb65?=
 =?us-ascii?Q?DNns57jJJuWR1RY3lLuFjtutHIwVj67VXkzJHL/7hAxT7rOIo1JLjwvz0fbO?=
 =?us-ascii?Q?tpEvfy0ItvB+bT4MtRQh3LhHp8lmJKUvdx/ZqcYYMGz7h0DSM/suB3Uk06Aw?=
 =?us-ascii?Q?ehtbSIMKICl9nvbt8dtqpp7X93uSTUx4P6sl1EL5KQ6GFdSRMtW3d5tcv7oC?=
 =?us-ascii?Q?+vJyVKupvL03O8zrVuhNpnbgUJQS0+PeQheyUijSkKzcG8ljJee5wAfWCZeO?=
 =?us-ascii?Q?3p+Up1U1mbN4ijYND1T9f6d4KkBKEzQEqKtfwYxab6qdFHY1wMDAPPNs8wFs?=
 =?us-ascii?Q?9L6vHhE97S3e7U6aIXmeCFzIegWuOwnB77CBBudTPbDOWUqJDYxnJhmMR4rL?=
 =?us-ascii?Q?gPt4bd7HTAZHGmwd3dJq9pKLMbaQQ0Pg7+bccrfHUc4fO7hamMRe5P5TvL2V?=
 =?us-ascii?Q?KvRiu2nU0+iVyzXAbU24so87k7gEFAIdtG0fzCZtTJn7XnilhXlH1xNesxnK?=
 =?us-ascii?Q?jIww0+hFwJp0HZVmYyvispJiv31yotuWTJO82fQwrLO5uqvFFF3VgKnchwpb?=
 =?us-ascii?Q?tB4rNrF2ecKIV/prfuG+/ML4tjOZJPL4kFYJvaHYXDIocrJfMGyAWjNKvQT8?=
 =?us-ascii?Q?zLJxz4RpbPMpUCm7maO00a/E57iyzUAtf1P8KZzdk8dmuIgyIJhCZrVaYJrZ?=
 =?us-ascii?Q?74Lpo65icz3ac+9zi2HogDQ6P7mfjghl2h2yoLw113WATVQs7QZJoz/rDFPg?=
 =?us-ascii?Q?7Jf9wZ3Sg/CMByb5LU8VJ2bc/qDX4SlQ5ylkMior8D9TJssZu9qdfq/wCAfm?=
 =?us-ascii?Q?PJAebJj7/798gXKE2P4dKAe//tMXPKdabUBo2qiKfqa5u4wh1XquIDMYqidv?=
 =?us-ascii?Q?b/jMJuT8C0RX/6g5YWKoMj+U9R5A8GcjZMkDPLT9c9ItAl+zBhZzx0VuJLS5?=
 =?us-ascii?Q?w7XYnlSfwbP/ZgJtmwhQYms2JVKSIvHOFIXg2q7w3M2+mAlLYouHbbulaeQ7?=
 =?us-ascii?Q?47PSfPLuwRtmQ5H3jCKeo7BJ6sUVoqqvSaRfPOlzEgH4iek77VfPc54/LiUb?=
 =?us-ascii?Q?QxCaek6lUne/dmX7/4k7YfUyfp3hQIULkfWzjjp3Pw6eh0We8mh4jSbj79RJ?=
 =?us-ascii?Q?LQgsGL/d2b5hSiIuOyKPDN7lklgc58K8XOnv3hMtPtkoP3MbKT5xnJjWkFVz?=
 =?us-ascii?Q?dntfrGODTXnhjgNerOC+4pctLR5fmEoj5Ex27UK/0diUBfw7/AV2VdB+aj47?=
 =?us-ascii?Q?xCaVxR9AStO/oDYk3Do2e3uDTV94hymQkfY5CALz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cca3f4-fa40-49ec-834e-08ddd8a585eb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 07:05:58.6546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiLlqAQ3Fg1/HQBKa8Aba11/OChuLaYbqwyH08/29garrZIGfGOpRIvkGh02JJdcoyu0if2Z3yi1zVNooUWl+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085

BUG_ON uses unlikely in if(), it can be optimized at compile time.

Usually, the condition in if() is not satisfied. In my opinion,
this can improve the efficiency of the multi-stage pipeline.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/sh/intc/handle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/sh/intc/handle.c b/drivers/sh/intc/handle.c
index 7863a44918a2..defa8780b566 100644
--- a/drivers/sh/intc/handle.c
+++ b/drivers/sh/intc/handle.c
@@ -128,8 +128,7 @@ static unsigned int __init _intc_prio_data(struct intc_desc *desc,
 			} else {
 				fn = REG_FN_MODIFY_BASE;
 				mode = MODE_PRIO_REG;
-				if (!pr->set_reg)
-					BUG();
+				BUG_ON(!pr->set_reg);
 				reg_e = pr->set_reg;
 				reg_d = pr->set_reg;
 			}
-- 
2.34.1

