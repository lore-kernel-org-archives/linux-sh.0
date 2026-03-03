Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7E36DA1C;
	Tue,  3 Mar 2026 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571760; cv=fail; b=EZtruwOhn93g4T1im2TitQzU6vkv+uO7we10yFyIGuqiwAaHSI7jbWp2X6CrKZ1s0VPIzFrqyuym/g2hSFzUAb6J/uVQlDLKHY10eOCCZn/aTaVuXxE9K2LRXO5JCpWyQ/6SAuDvE09LfLyOJ1BGvX0VsDs73PfqiGSPEAsnzJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571760; c=relaxed/simple;
	bh=Udtw8gh4Mhw6JPInsulmwV4648EpTVuiWI6ZHgysYNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bjwbW3CmqBSTQiwjXrRPdngsi1EVx+zZ5iRbhoxvsQt8tqUSVvXhNn3qmwitxAjnOFrjnks9Pge9jCjqCoS797gSGnexpf173Pr1foyuySFAekLgFrWTTeLoLErqWPgbgJNEXSLi07EsmWjTZASgE5CiKkL+/eGizow0drmPBok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iiXflk3R; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iiXflk3R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YffXXcWPBlrjf6bmgVNntGdXhPIvCizNF9DnMTH2Q8WukwxhOkUjUs3csOFAKIzQ6jP15H77OnqBJVsUJuHyhRS0uu72KNr9S0tcwUSPhv9N5nbRwQQPD0W8npSfv6ATiXLLxm6pOQkS4DgEmrUwpP8YBociJ244fbrt7c4/rR92TbSWdEJ4DkiCj+so7VginUWZ+msIf2NNpd91C54sChSNuj8pXbE5U18GhKMu/Eu6ckYJlf7NHlOflzBo8rWZJNLI5CDw2zFBqHLSnZW6Jiiszu0bFuumHT+IX99+vPt8Nc7OTUJwH8Q/zm0qkNat4fyuyHM0TBChcEAaaRC+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaXxkArHCSi/NEXnz5DLUehmyFKrQMcbQzODcSzt4b8=;
 b=Q/k1t/uDt0ZXkgEKbSF5otlSBeBTBfzmeLn79QcRxowY1CjxAAxDORsmfBJAnqbKsT1oGeJOxVIZPsAVNtaMZDcB7M9W6BNYQfxvKXxRs5TsezaclRd6y/4YWBP88kypSjjjRlaQQnkNR5+nD3mba5EWWXxYxKKkN1am745gSYonvmnAIzKNjbzAOPBIU1LjckrVz+sJizocyIDNMwJF0hGGySH7VHAWyBgXbZ9k9ZMwHiV6pmb1lV1Jn23AX0m3iyNiLlgqXz+WX4uzmdwBpqjKjiBk53oXIhJH+YhHgE6z51g0LtgYGEX5niD7K7XDdgRQ//d6XZn87fRPlzJtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaXxkArHCSi/NEXnz5DLUehmyFKrQMcbQzODcSzt4b8=;
 b=iiXflk3RPcNFWbW8n8TmMSsyOhtb1eWleDm9djD771Bkyw6tvjGNtXabRVb0hQrN1zdDYhMo03h8mF61bgVLDHg4wR7lMPDV2VTKsArMe4bWCSQ3k+5jDUsAFoX038SSl6taQc3iBo7vB1DfVz/kn/U+1n57oaYtPpgPDjofOaX3mZOoms5uvggXLqwxR4d6Y4bbqqyCJnqTZQL5zBuW1zFpvUkd5DdCHwYlIq1z85hGo4DFwG7lYgQl2KNp1dH8fbG2iPRgqlrioN1yleOP//mRwDTHkZIGXNm5yG2m3maWXbb4213TqLxDquvlQpVJ+qhigkudPCCThOXOAEUy8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVUPR04MB12217.eurprd04.prod.outlook.com (2603:10a6:150:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 21:02:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 21:02:35 +0000
From: Frank Li <Frank.Li@nxp.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	hanguidong02@gmail.com,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	abelvesa@kernel.org,
	srini@kernel.org,
	s.nawrocki@samsung.com,
	nuno.sa@analog.com
Cc: Frank Li <frank.li@nxp.com>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-hwmon@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 2/4] docs: driver-model: document driver_override
Date: Tue,  3 Mar 2026 16:01:06 -0500
Message-ID: <20260303210131.2966214-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303115720.48783-3-dakr@kernel.org>
References: <20260303115720.48783-3-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVUPR04MB12217:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce6a5b6-8f00-40e2-27c0-08de7968321a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	Ca0Myl0wyx91h07iDvLJifKhCXfG2H5UyS5wa12yldeoFAwPFekF76VijOTiD9E0ZdcDK143txqsapmkYxVtqG4J7wqoGKlI8tLDXAjaYByWX3kPJWWiBN20T7xTlCRuPBWhPDkWaJ0hO49y1cMzqK/kfrvpoXxXzEMewlAI1fPURGDuFW//1Na88nkAr4h5HbtRYH+rLadfkB7iNHuxzJNSk5OOJdZmbaR+BAxqbVyB57MSgX7pHTZ9jQxXQG8wVTukxl2htkSVPUb5h08h7V/Jv7l8PGooXTM5qH6+ly2GmXmM9+oM96v21sCg7DcF9xKreU+kHfGfvtpLTOARG7/PMDkbuMkqCAEDAu2UZx5xIOpHBgRMWOnuaeyavJempIwacaDIB87HShq6C76vEzvRfbYsa3nilgjAxI9pOcrOcwAJFANaKhQ+fAHzc/fpBVgAkaUVeAnKbPut/4Bh/p50idNCadWnTVsNqh6X6xTikAZkKD5qODO/Je+vIlhKq+3vLy/XhckBCqSoc2egaMEmLyqd3abhUyrtTbcSzfkPqnYWrr2Uy2lngLNnaBsDbm18dtq8O0QyLzUgmuX9KtfvBlH6PShA3GETEDzBpRQlT+aFY2HdpyUV/v+VCLP8u1TEvsjBCQcuTciFvRAO1X+4RtJ1X+9ZHPSUXREEEq7TWOK/GIy1A8OS4zmtjbsa6f1Pv3iiflV/sf7PtoReimS4PZyMRIa/te78DiehZq+ysZEjv+rXA9eWR/6guJKruoOSJ+evzH/RcBCRTM6t0lINI/Slz5WYwMU1LDjfTDE12iWAArwaQ1ss68eYTHmw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1pBRTIxQm5ueVFWRWxzR1pOdzZ2czh3RnpqaWJ4c2Z2N0g3Q1IxYzM5RlE5?=
 =?utf-8?B?Z3A1eVg4WXd1YyticnMxbFJJV3pqTFA1bVp4TFhjNjlYMll4Q2xYQjUva1hZ?=
 =?utf-8?B?ZXkvWlQ5Zk44a3UvdHVma3dERHZTd0M2L0dBMmlFYUhaZ0NmOEZvYmJIQVNz?=
 =?utf-8?B?SmlIbXptN04vZ3NIQVpLZzAvdExzRUdpTWlFaDVxZmVOZ0dPVWJjSVVBNkxF?=
 =?utf-8?B?cmVZSU83Z1dNMFlzZS8ycmlJaldtRVdVZmdRcER4Z250eVZUclZHOEQvQnlv?=
 =?utf-8?B?bS9qMEMydUk5NlR1cU4zRUo0UGd4OWpSSU15dEN4ZFZ3NEk4MnA5U05ZcDNr?=
 =?utf-8?B?dlBzYmhIVDQ4ZUtvanl6OFN0d0h1bDB2ZlBZU01LYVZuV1RYc09yV1dqOXMr?=
 =?utf-8?B?b3cwemxpK0VMZElpZlZMQ0dzL3BVYlpIUDdMbEozbGpOS1lrUzNPc1RBR2s1?=
 =?utf-8?B?RThFeEdvdjFoc2lscXV6K1BlanpjbDZMb04zZW5xZ1kyblJ4T1NhRitSVHo1?=
 =?utf-8?B?dERTdTBsTVNKUGJoc2pnK2Y3WEhXaEk2Nm5WaGk1c0xIaFU4ellzeW1ja0Vj?=
 =?utf-8?B?dWs0aXBaZWxhS1Z3MG02aTJPc2xZNXc3K3VORkVaTEwxRXpzMldzZ2xCS2Iv?=
 =?utf-8?B?SkhtV21zY3h2NUpxd3NXZ3IxcHJmN1FqNGZhR3BhUTljSTNWSlZkbWZLUmwr?=
 =?utf-8?B?NHBLV2VDTGVUc3FiYTNJRjh4ZUpNRklUU2Z0cWV5MFZDelZoS3BaQjg5dkVy?=
 =?utf-8?B?Tk53cGJhc2ZKV0NyYnFzL3RFTmt4d2JQWDNGWGV2YnFkVWt0Qzl6bktlNmx6?=
 =?utf-8?B?cW1qbTJ6MVpFOTc1UEhxckcxak96S3czbVhrZDB1QkRaSEk5eVhOM0ltZ1Ja?=
 =?utf-8?B?dlF2S3VhT0JKQW42L2FmM2pkWjBMT3FWV1pqeW90ZDZGWW1zQy91aWJaUHNy?=
 =?utf-8?B?RW9wZ21HMFZsK2NFT2MxTlR1WXhmRGRHUldZVWVVR1dDaFdBMlI2bm5qT1FJ?=
 =?utf-8?B?TFFNeENYZkpwVHBEb0RvV2RuT2FMd3lhMUpOWWwyZVZQWXR0SGU3dTVxVlg0?=
 =?utf-8?B?WUZ1UnZrZDJPU3BWamNBbytKNTdSMExmcHB2RW1Ea0FiS1ExWUFrKzFPSkV1?=
 =?utf-8?B?a1dpbGZoaU13N2VJbkNZdFpvK0d0VURuSEs2azQxeTJhRnFVaitXU0JnK3NN?=
 =?utf-8?B?Vmd6Q3lnbnZQRW11TFZoZ1dzRWtHSStzaDJjdU9vSVgyZE5tRFBNNnp5QU45?=
 =?utf-8?B?bkh5bVBaNjQ4T1RrS3dRNHpSeGJsQmptbmhiYk5ENHZ1dmpTNnN4T09TdFlU?=
 =?utf-8?B?UkZ5QWdUeitUTGN1KzVhZDIyQWM1ZW5ZbmNlTkxEV2NHZDNFaUY2U0tSeHUv?=
 =?utf-8?B?RkliMkRzTEtSeUxyUStwaSttNVFETm5LOHBxMVhWZHd3bldZQThhNXJ1MStD?=
 =?utf-8?B?eDR3RFJWVjFQaVZxQUVyWUhPMS9CQmZSUWRUNFprWHFxR1VlOTVVL3FqS1BM?=
 =?utf-8?B?WlI3czIvV3lybjZ3ZHJ5VmtJeUNCZnNNa29hSmEyTFVyQ3haMnhMcEVMbEhB?=
 =?utf-8?B?RFdWOU9qSml2MXc2VG9Ia3lBakl4NWp3d21KV3VMWWx0QURzRHF4VlVnU3Nz?=
 =?utf-8?B?dkRwdndWRWhlR0o2TUhyQSsvVXpqSlNSTFpla3d3cVFRQlZwNU1vOVpyMUJP?=
 =?utf-8?B?aWprRFJEaVR6d3EyN1NFTXNVTFpBdCtmV3ptME1zaXV4dC9FNSszLytnUUJy?=
 =?utf-8?B?K0pva1hjUVlxMlBQZGZMcHJ6Vjg4VS9ZWmg5UDBPWDRmNEd5WWJUSTNqT0FV?=
 =?utf-8?B?d21rSTNCdDQ5b3FSb3F1REY3MmZWK2NIdEZCSXZncUxTRlpzRGlUV0FMMU1r?=
 =?utf-8?B?eVB6MjFQOTBLTmdyV2RQOEpkRXhUZk45M2RiM0RVd2VqdS9ob0plYWkzYmtS?=
 =?utf-8?B?bWFYVmJybXpiOUUyL0hvUzNPRGliWElXak5MMFBpU3RDc1p6dGJCS0thMWRW?=
 =?utf-8?B?cG55R2twTy9Cb0ljcVBEQVpxTytoQU1objZpdGM1OXAxSlpJWWNMNlptWUFi?=
 =?utf-8?B?WXQ0UEhUckpnZEJXeXV0ZTlkdHNMYkEwZmY4WXRvTDYwa1FMSFhFRWJDaGZU?=
 =?utf-8?B?MEIzZk5xc043T2F0RmxlQWM0NnZ6NWNIK1E2RjgwTEZ2V2prWjlvLzcwbmpH?=
 =?utf-8?B?WnhoWUI4ck4rTE5VZlpEWjl6OHFHRXdtcUJDcjNrQWg2aDdXZXVxdGdjZE5S?=
 =?utf-8?B?bkc4Nk90R1g4Qkh5Q2R0ZVJvNzdvbzUxc2J3VGdTTmZ2ZjZVV2VNRWswM0FR?=
 =?utf-8?B?VXVFaHVIRE9ob09uK0lnN2R4LzJZQWNLcHlOaTNJOW5EdnNJVUZ5dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce6a5b6-8f00-40e2-27c0-08de7968321a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:02:35.8709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ldeeoCeIRDTV5jFGLFZ1uowFH9K/oSUT9oMQQ3gwTmG4w0uXrgVKpMdhT3bjgdMyFf2B/RIA1KZNUmdKmI9zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12217

From: Frank Li (AI-BOT) <frank.li@nxp.com>

AI bot review and may be useless.

> +Driver Override
> +~~~~~~~~~~~~~~~
> +
> +Userspace may override the standard matching by writing a driver name to
> +a device's ``driver_override`` sysfs attribute.  When set, only a driver
> +whose name matches the override will be considered during binding.  This
> +bypasses all bus-specific matching (OF, ACPI, ID tables, etc.).
> +
> +The override may be cleared by writing an empty string, which returns
> +the device to standard matching rules.  Writing to ``driver_override``
> +does not automatically unbind the device from its current driver or
> +make any attempt to load the specified driver.
> +
> +Buses opt into this mechanism by setting the ``driver_override`` flag in
> +their ``struct bus_type``::
> +
> +  const struct bus_type example_bus_type = {
> +      ...
> +      .driver_override = true,
> +  };
> +
> +When the flag is set, the driver core automatically creates the
> +``driver_override`` sysfs attribute for every device on that bus.
> +
> +The bus's ``match()`` callback should check the override before performing
> +its own matching, using ``device_match_driver_override()``::
> +
> +  static int example_match(struct device *dev, const struct device_driver *drv)
> +  {
> +      int ret;
> +
> +      ret = device_match_driver_override(dev, drv);
> +      if (ret >= 0)
> +          return ret;
> +
> +      /* Fall through to bus-specific matching... */
> +  }
> +
> +``device_match_driver_override()`` returns > 0 if the override matches
> +the given driver, 0 if the override is set but does not match, or < 0 if
> +no override is set at all.
> +
> +Additional helpers are available:
> +
> +- ``device_set_driver_override()`` - set or clear the override from kernel code.
> +- ``device_has_driver_override()`` - check whether an override is set.

Minor: Consider adding a note that the override persists across unbind/rebind
cycles, or clarify the lifetime semantics. The current text doesn't explicitly
state whether the override survives device removal or driver unload.

Also, the example code comment "Fall through to bus-specific matching..." is
slightly misleading—there's no actual fallthrough; the function returns. Consider
rewording to "Continue with bus-specific matching logic" for clarity.
