Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5D35966;
	Thu, 23 Apr 2026 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776959206; cv=fail; b=KWR0tYeaa+wi77yiOCarjeFZo8qrI0iOBestSoPZCixlVxJSEn38Nf4PfpUZY+MfRATZDiuoy5JimKcu9eS5osiv7M+/XzdATKWS/QP+FI9t1JjIcDavVIxEXVqVk2Was8Fb+Q+F/1akvtYnZssgV6jeXTpwh96MI78h7f8at0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776959206; c=relaxed/simple;
	bh=bUSgW03F0baGYXlS/AhaAZOxBvsKMTQ8KBrHXqdj3Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqHbPI353DLntBjgegrEbOZFUDVeUvl5IVnhNKt/k7tMRYCJPU8Xf56utnh1S48DUHJoZcR4foWnTQHfgpxJcp4jgdU8FSLFNBH2i6lBU0u7Nnq0QBSB5v46R7FovZtguvl98VEiAhVlUoRt88u0dd2UlvlaqH64oRbFJUbbkrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sJzHGZOA; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sJzHGZOA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6334TutPreKoUoHqLbHIYw018kRqjpwyg2Evxd+PwZgWboYe0gI7xW/zuZ9nVsm40CPC4x0d6A/1MWthcQhZzaKee3dbTNL6PVSkU/xu/O8iY5YNyxxSmfD8x8bkLHCyjioYTYfig81In2n9c1uUwsbalKIGTPia5qEVhfD+8z8wsWO2h8k9geFXlX+9QHT+M0CUyy+KzIvwW/JOUI2ZuFV/nT4KbNJLJzcVxEaxxnRNRr3pSF+QIj2OcSD7gk5elb2wrYJ/iaDuY72LqMJQAoidJ/17QrZlEixiToyfJiIkKa8nkP9DZh+ro/p8gJXWvyr8IXxIxmywSsOvLNEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpCbLirIH6+8GnqTPaeHoSMv0pFFMj7MtG0xzBYqH4c=;
 b=Z3/BQgco1HrB0Es/kts1ypccMRYL4hd+Xk/yxO3Ch3RPaU493Xx6u6WFrn2/01hX/hw0yDunl5hX1XhsCLrXRTi+aeO3n6CYlxvlo1IDwKepi+iN6RBINJ2X/zadWvB//EmwVNj+NSviFkRU3ZItQBbcEAJtvMT4VNG73SmQ37/pNzhm+VeeX23r4E40Mrb4X1ESmbf8lZnBDAVOuHAQDSA8nos26e3nHP/T58W5KWq3NYhBOONwDUWb3a55FJRSQLvXkiswkOHWRKI5vyDJCXJQYP4dBKqhu+FnqQB8w+PU7j1s6G6x99oS/lQyKMxOLyh0Nw85TtRK1RYNXq71fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpCbLirIH6+8GnqTPaeHoSMv0pFFMj7MtG0xzBYqH4c=;
 b=sJzHGZOAde532pItdBtINHxwvHiH17lA1m692D8oH4uC2P/deRtwb/jOG183Aqe0R5odYPDUi4IpRiCROpmuk3ALTedDw+ziRPM669+HSYC+CFY6NRHrxDkmfLFrlWzgJFrHKSE+jA5MrXqyjJlQvjK3CEVpGeHDkTH4oSH9RrcRpjzUh4dR6bCphifz+rb1HSz/sEej5b8HgSIU1FzCRhWfOYiFDdRVlUHOJJbcLZsYCUghJ73nXupbqt2aPL5GlAI9vdmRLBy4sEW+fIOFQ9xoOSYfKS1mTPWag5CkI3ax1L0gVnGiLQuiMDBejXf65n0gsAJaAuFbmxvYpEvunQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Thu, 23 Apr
 2026 15:46:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 15:46:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sh: cache: remove unused but set variables in
 sh4_flush_cache_range
Date: Thu, 23 Apr 2026 11:46:38 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <B1350795-6210-4C52-9100-1FF66687E3DC@nvidia.com>
In-Reply-To: <20260423145301.245374-4-thorsten.blum@linux.dev>
References: <20260423145301.245374-4-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:208:32e::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 376bd282-edd8-446c-14b2-08dea14f8368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	O4BqI0h5vE10kCBqG8+qtFtHh02Q+tPUzmW/hve88dZiE4eGCCh8NaA5K9jECoJztGjRiyZM14Mmdsr4kLDylmkqeZIUuyHDlR+sY7456U5SLtDU4kFu0qbt2ZQPmel9WxeuIvulLULurpLviDDFZhKxVmV8AqL2t8QwzpgJZKkKQU7cD2vQ9/5zRzOyRqkL5645gnebHLP782V6VPIk1/yUoNpwoY50MnHSvHGP/VAKyR/xMmtiZCPcaE1BTW7ZP4skmnrSjmYN+RZjyKHLlZSk+9ywqM3/0bzN/XEnHnfmrP74u+ZFYzhu7sYwJl6HJS/1xApR0jQbtKzqFSzYJ//FmAA8Axv6ZI5y+yKKq1JMochgaJ2ySFH2fwX8cdTSSrrOFeNiN2T+aExuzc6mzYzdVtAGW8MrrxySSGNn4tnXLyQwEzPP3xS8fq7IWGUlEGDEJ/O+88GDRJ8q8bg63RYrOc8OJZW5BzMGWqCva8SiX8GTCpXyP3nzDVBjCr0VBMpFpPPuHfrqreyZ8PWHwweZa6KNzRtBUePn1qoqwyvV/n3pUK+sBNC0HyE9mELSveDe9BAMTgb8PC5byiJYV4qAO5pZZqhBympQLqcr7yUL07sNvqeaVIb4GSYnF+2KK0UNo7HKhnmVGtRGHOeX+bfvYNUQoz4D9wpkKM2+gmPVOOzb9NL3DAdfmxyGbgzz4ERoL+pnLbyN0T1UuCfYzjdGZDbrRcIB+zBXyq8ggeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU4zQXJQTStCMUcxSTdYaXpqQ0l5dGpCNkcxWThoMER1Y1hqWk5Ka25RS0Zi?=
 =?utf-8?B?dS9QbjhSUEFFUnljaUIyeXNuWE05TlVBYnNHWWEzQ2M1M29CcXJ6MWlFdVBs?=
 =?utf-8?B?a092TWpycSsvZmZTMFdIT3dEUndNOWVCZC9YVlEvOEV1WWhYcEVYekp4Z21r?=
 =?utf-8?B?anltRFdOMDNzL2RYZnlWcy9XUitOeFFRQlpjeTVIVVIzMjVGTEgwelY3T3dQ?=
 =?utf-8?B?OGVLeG5OU2ZjVE54aTAvYWNEM3pRSWNwSW1yYTRjamJua1JySDU5Tlg5dVN2?=
 =?utf-8?B?akh6ejdycmhDMy9aOXhvSEtIVEVDanlqT0VBUlUzZ2NaV2JTNjRXZEtCQjNj?=
 =?utf-8?B?R2sxNDloaWt4UTZrR2RzK2cxYVVQZzhXWWp3Q052dERYaXJuMGorVTQ4Unor?=
 =?utf-8?B?S2d6NG0xaGhoVUJkSnFwVTdYamx4R2JLZUNHeHcvZmJBbDR5Z042Vm5Lb3hw?=
 =?utf-8?B?NERuUE5JcFNyNHpBOVBhZE1SMmZtME92ZDVWMGZkS0R1TUU4Y1k1TjhROHV6?=
 =?utf-8?B?K25sR3gyNVZ1Skluck5keUFrNmVSdVpzVzljYTl1K0g1T1FsMkNkSzU1bnB2?=
 =?utf-8?B?bDhRSHU5TjBnd1JaS244ekxDRXdQWXBxWm96ZUkraGd0MU9BTVMvVmYyWG9W?=
 =?utf-8?B?YVNrYmFPYXBHUEhiV0ZubVM0VitPMW1UT1RLeFBpbXFnZ1VXUTB0NXY0RDBi?=
 =?utf-8?B?UENHNXJnR2FKc1J0bzJvQ25MbE1DS0picWljSTdNZzBaRWY3MVNlT3I4ZC9l?=
 =?utf-8?B?WU9DVVlJZmxYZThVQ0FQaXI5anVIVW4rRXArcHlpSzJXbVVmNmUxc2FkRnNt?=
 =?utf-8?B?V2xnTld0RXc4WUYwQ3Y3RDMyTno1NWdjaXVCcG8yR0tRL0Z1MXU5R2RxUUJO?=
 =?utf-8?B?MVhiMUFmVUpzN0g3VXZ2cStSM1RWd0lGRTZ4UHFtc0NhWVF4ZDVNekJGR1NU?=
 =?utf-8?B?M0MzSGxFb0hpTEpuaFJUTzJQMmlwMXAxSXB5UWdrR3VpNEFVVGdtM3BMVkFK?=
 =?utf-8?B?cFlKNWwzZWVWUGl0b0dXZWpzcHhTOU45Nm1uQktZNnVObVB2b08yTEF0dS9H?=
 =?utf-8?B?UDJCVUk1bVh5eXg5S1lrS3JRcDYrOFZ2bkZLQ2lvYkQ0TFFDRjlhbEM1UE5v?=
 =?utf-8?B?U3o5NlFwWHV5K01yeUh0L1RDbUdPYzNLZHNHUUlESkZ6OHZZamJ0TlpGVk50?=
 =?utf-8?B?eHpWUFlCU0p6aUM3cTBwQ1VWRDBvTTQ1V05TNUUvMGVIUTMxZVh4RkZzS2Vj?=
 =?utf-8?B?ZnRlT0ZWa25zMFdCNTRZTWFkTnE4R1owOEFhZUtLNzNNSzBYSlpBaGE2RUkv?=
 =?utf-8?B?WkhqWXB0cXh6SWtTNEVGd1l5T3AyUkNwV0ErdFgyWWFxcGJPVGpiQlplVk5B?=
 =?utf-8?B?U0xVdWcwM0lJNWN2dytyNXBhUlExVW5DNkZGWXB5UW92ejcrWWo3U1oyemZN?=
 =?utf-8?B?dmZIT2RUa2hENHNEeTBvbThYcFNWb3JrRkkzeVVIVTZlZzhZZ05MMkUzTzNG?=
 =?utf-8?B?TDVCcjlKUjQ2ejNiQnZtSi9EMWtGQlZTYTM1czg2SWNpb3lsalRRZlU0eWJM?=
 =?utf-8?B?NHpBd1hsR2lnelZuR0U3UGVjZU4rb0FqamFqZ1Z4VGFXZHdJUzdoc1VDNzlm?=
 =?utf-8?B?dUtOeE5YWTk0bWl3SFlZMEpVMzZBYXo5bkJUUTY3cXJGeDJjVENySWdEOWNP?=
 =?utf-8?B?S1U0THB4WXJ2TkhxZVJ6WWY5emtqOVhYTGJYczFUdTBweXNTNDdSY1dHemFz?=
 =?utf-8?B?WTc5NGUzOEFvd2RjalVRYk1meHJPeloyclZzbTVPcmw3ZjluaGtJeFQ4QTd2?=
 =?utf-8?B?MGU4T2R0Ym9FWEpWV3FnYWs5MFFDeGxsSTdQSkN4M3pLemNyczZWMEZxa0U4?=
 =?utf-8?B?TE1OdTZ6UHdrcFRtd2hkVjJHbEpQb1hINGV5Q0VkaTRjM0hEVitDSVBWL3JQ?=
 =?utf-8?B?di8zbythd1NEK1dFWnprWWpHT2lnN3EyeTJkU0ZPSkJqZlR0SEdvUTN2Ykw5?=
 =?utf-8?B?MGg2bUdpdE1FaklMMFh5ZHV4NDBTRmFtc1BhdUNBaG52c1pIWG9GNW5LTHlh?=
 =?utf-8?B?ci96a01kYUp5UjFTRVovNkpBUU1IR0NWZHVaOHdiZWYrMUF3aFoxZVFiYTFY?=
 =?utf-8?B?V2FJR2UwYmVaSXM5UDNqNzFWRW9rdVgwZ2xUU01pOG52SksxZElkb1h2MGNC?=
 =?utf-8?B?VThKbng2VEtWZTNKQnhpdUxOYzh6NXNRbkVWZkVlcC94VXhBRFk0cUlKcG1x?=
 =?utf-8?B?a2JSRUIvYUs4TzIrQ0VsUlhlVFE0Z0l4TTBSK0FwYzNGUkNpWG1jRDFuRXdP?=
 =?utf-8?Q?1NnArjrmYqwsJMWnxB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376bd282-edd8-446c-14b2-08dea14f8368
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 15:46:41.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8HG1SVHhpXr25UErilT2ag5W2euM+vPgQaLoshRRld1aQOJ/s5avuDm9P/Fzimb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

On 23 Apr 2026, at 10:53, Thorsten Blum wrote:

> Remove 'start' and 'end' to avoid two "variable set but not used"
> warnings triggered by -Wunused-but-set-variable.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/sh/mm/cache-sh4.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
> index 83fb34b39ca7..9776027382cc 100644
> --- a/arch/sh/mm/cache-sh4.c
> +++ b/arch/sh/mm/cache-sh4.c
> @@ -284,11 +284,8 @@ static void sh4_flush_cache_range(void *args)
>  {
>  	struct flusher_data *data = args;
>  	struct vm_area_struct *vma;
> -	unsigned long start, end;
>
>  	vma = data->vma;
> -	start = data->addr1;
> -	end = data->addr2;
>
>  	if (cpu_context(smp_processor_id(), vma->vm_mm) == NO_CONTEXT)
>  		return;

Is the comment above the function considered stale too?

“START, END: Virtual Address (U0 address)” and the NOTE.

The change looks good to me.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
