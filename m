Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA633BF696
	for <linux-sh@vger.kernel.org>; Thu,  9 Jul 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595819; cv=none; b=eRbthAZ+BNdi8PwdS6ghpW5fcINMFr+BZPq/sviWS9Af10Voo1k0KgNDLNDF+0bp6aMlZHsWsUA0w/SW2g97RDAPigt//hTmjO/829kl9aBBzF4FQFg9p2aQkp2+dgN6tVf3RkO5WZxg5ejIARP4ABQp5OppLH86dZECf8jwof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595819; c=relaxed/simple;
	bh=tutnNf9YAg3H/q95A7Iik+KRuKDbYTmWKhCV2b/wa50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UasgNTSLRO0wa5yD7604sZDKbrenvxkhud86Hzb/6dbUeY5Evx4gaL7oMLYxIajMnZwKBZslndFzctJh6vNAFwLg1CoGsBsWRNuJ0YfNq+23YIAKDl6G7uhNrRBwnIUfUynAqEWJBbU8a0DKG9McMumUA1KS9IRKJ+nyJS2upM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bZBcJAam; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VSW8VSNz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bZBcJAam";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VSW8VSNz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AwrPo1470045
	for <linux-sh@vger.kernel.org>; Thu, 9 Jul 2026 11:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=; b=bZBcJAam+ibbXFwx
	fYme4cr8sBqjGZ8/bhY813m3zZdemgRcv+ZZn5hEkMKaS7vw0Lsk0C+lZaMW/4N7
	48Ti3b9W5djrMW6C6sRvr/fRMwvlr3Xwdk0O8mST92o98b2JRkz34WzfXmdlRdyc
	+GNzKHdNyJRx4XFA9Y/FW2dL+68kjj0jsC9rEzLvB9U2wtPREHvCZncHnjBH0nco
	DqfIf8EOVkC/PQXn3R9FFwNfO+c4fAiAxBDB9r3vKIUe0k0qjSg4thZ00H8jr+97
	7VzXtBysfy4u+kGoa711kKXXJoacuD/Fbabaj49b91/ZVeI4dz7AgvccLaeW9YDn
	oHnuIA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u3ga8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-sh@vger.kernel.org>; Thu, 09 Jul 2026 11:16:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1b4d961dso8967951cf.1
        for <linux-sh@vger.kernel.org>; Thu, 09 Jul 2026 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595816; x=1784200616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=;
        b=VSW8VSNz0z/y41qH/VgzvwJBdqVhowunoibHb3jaSM+bX7g7V9zEH0ygaANE8jl8V9
         RednaI+86thljLOnpNDnLiKAQcMc2Rlh/xRSm61VMH2kSo0ndlp0i5+wJXv/mNBgIxwq
         vmRxvWP2xfMmUok5u5TrP/mcpolkDkVI+rh70ixsjpT01/vcC3qKJ2Z9UWY6AF+Er70u
         pgrWtlzueKsjuMoMLs6GlXvLRghqu4VBI3C9nli9nzcKZAWv90C8lmbk1eolq/tfYW55
         O1z+DVlO/UL9iAUgbclGKzqJ968Mc8LG64H6PGpqgm0JbwKKj1yBju1LHDTSFmF/IlKK
         goAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595816; x=1784200616;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=;
        b=bf8sEEt0UB8CSaYcAiJPt8ZJZi5BHkIaYzM6cMBxNKIvA7INuk7YZE8xxDAQcrvGzi
         hUm3bKpZPQWoE+7ILeBBJXJUhWyDUmVN22LX38li93z9jFKAUkCnfmGVsr3fJY7o54Kc
         mMcXbsFwvAYZpKGFp3I3uPj0eYnBtJ936p4o20KOb6VVgwAs1yjrqjgLRLSdxTguvdb1
         S+degDpv7EIHIIkkR5cZRIw7VrQaUXA9RWqaRxnwIlU9AYvUUZ9u6MSP+6tMUlE0dp6k
         vWAYPHtSvIUxMHsyS/dat64rX0lOt6b9HvSRaERIQn2evLWzjH81VsXhiwHjilUV+TRG
         unMg==
X-Forwarded-Encrypted: i=1; AHgh+RpaJ8+KWmDkEvl+YuHLA9eWMkYfoZnFBCLLpJT/ulUFXaz7yLmwmPmvtF7hnc3MvmIeYeS0g0iiPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU5bpo7gr4ux4VGK9NSyW0OB9FYiUI2EGhBTLZnW4kecQGf0yE
	I8UrrscB32vDwJKKxhenG3pWVv/gIbtx2vBBFm96MjBVBqEhNjt9j/ys1pvabeDWvdshHeIufoR
	JlpPtTYpHrV9sOG/L0B526npWtQsjyaEaLkDcXDCrPqdBX2/+2TkA07pM85XfBQ==
X-Gm-Gg: AfdE7clnxaLTDRhrwnRoBLiWX8tOql7vq9Ynvyrji+1XGAKBr00N5A3SRVYbNQJUdO0
	wEKsWCKy1V3c3Pgdt89pCvfx8FoocLSUww8sLFxx1cjSPXE43iSw/jd4Fwd0sRBEK8RtpUdFfZl
	M9OAjBhCBXlwUK47cdFJ7TxrTQF4mpyrqhC8y5OtbUnsyz61ww4n043BT+Uqw/uk4cVGy1+DGK1
	nbBOFbd2D9QNDQ1md4yzPTNc47/MrnUhB53UA9OalYBbbVYJFLLbTl6qhh5SrJosqQoPzNEHKDl
	5RtgVMzsiLzOoZYd+vYs60VJ1t/F8+NBvDnlS+yruXYcT5ItpQOwmG8GNrhVpssu+CFHems3mx2
	hq1Wl9pNyiOR6m6QZhTyd9e8y1KBZVcjUfTossOOqnbHPB6f8pqgR4PgU8R3WYg==
X-Received: by 2002:a05:622a:1cce:b0:51c:558:cbbd with SMTP id d75a77b69052e-51c9ba21545mr21236391cf.41.1783595815666;
        Thu, 09 Jul 2026 04:16:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1cce:b0:51c:558:cbbd with SMTP id d75a77b69052e-51c9ba21545mr21236071cf.41.1783595815288;
        Thu, 09 Jul 2026 04:16:55 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm51612968f8f.15.2026.07.09.04.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:16:54 -0700 (PDT)
Message-ID: <b2ca1416-e2c1-46ac-8a26-ce671c76883f@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:16:51 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190253.974626922@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.974626922@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX+lvOYi/d+dbM
 vQ7WttG5/RLy2fcZW50D7TecTKysnypk3bj3RoUxp8fqvolClmCmxOYbi4qjr7qwMlrmaMD9LKa
 1GxU+CuDrqfajltOdxHVWy4/0Lezle4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXzw+u0IafrhfW
 gOxwfT6pbCyYm7CkZq+544Wp4RZFasN4HzSBlaEQLFEoA834OACDE0BDo1PFLClCxHjVPEEQ0+X
 UljimnBz56R8GYQQdNTOuQrrxSXs9hzT1D8m4neuvgceey+/kVn3bCAGpEAWvS0v0aQJCw6VeFW
 Jp72rk4SRbDVHjUig+0ilbvK3qecqDyL9bcbINuFX4qXP/Po6Ebx++3c71Nfi1qCbnxA41kS178
 U41OUZzTsUTsRAkXEE8TzDZmG2g7lbHStslA71Sl79EVPutyaBSrveHawMOVSvJEUXZd8q891eT
 6Xcs2XRpN3/YaWXJFR7+GwKr1vm3IU+wvaZ+NpXFBNcewlDtQdqujfWTciwQ+/+mcRu3gQGBPDN
 dbYPU/i8f6FrMaw3h+TszpaLurAW4NrkIcfiibADDkOqt0JWynWT0y5RxoKNvtQdbcK1WE3OE5N
 gWiVNQF0J5F7Tuu0ljw==
X-Proofpoint-GUID: dk4KAoNPH9O-1MYcPWpIh8Cru2ZSvPRq
X-Proofpoint-ORIG-GUID: dk4KAoNPH9O-1MYcPWpIh8Cru2ZSvPRq
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4f8328 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=_O3DOGVWAAAA:8 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
>   arch/riscv/kernel/traps.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
