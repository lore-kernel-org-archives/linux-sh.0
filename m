Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964C410D1B
	for <linux-sh@vger.kernel.org>; Thu,  9 Jul 2026 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595763; cv=none; b=mNmmVW82rS9opuOvRE1h/yzqYy6gtfhj/GZdreOSvzC1LhCq3mNJb5qe412xo3j5tKrI2fNFQ51KhUo1TzF196mCh/w1Wrnnuc/AfwqQGEarJ4yAZ2xkWzXsz/zklIj8nUzbI2qT/gXIgE/6fEqLrhFQliLwGYlTU62tXsOd4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595763; c=relaxed/simple;
	bh=2OZyqeCMlAjx4K2K+b/k9iOm6BK8Cqfe058LfZSp27I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQEOTOVXPRxu4qkgqavJ3sX3O+TBh4sGeaEigJIDt2x7+d98R3ugQTAAShsZb16dfC/BK/icInKNPaTeQRhAqvGR0DB9GagmihFBvfnpUl53RO9yd8hmNlfdRL2k2oZbSHoHJ+l2Sy4XBHHtic37tIbDxSAQQRcLaaLjWLCa4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULLpdAqj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kMSp+MCX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULLpdAqj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kMSp+MCX"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxFRT1434813
	for <linux-sh@vger.kernel.org>; Thu, 9 Jul 2026 11:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=; b=ULLpdAqjhcPbhl+a
	9wkFVF2/lY0nTNUibaezE3oRQ6lteQ4HDVcOfqHDE7vtflCsPuubuaBt22suHv5C
	J/GboNexxusvk46SeLD4YSCgJibhGpTyBp7Ew2CmZmE5Kc85FL5xmUGbwX2SNRRm
	AUKTk+C5LBwuGwFJB3/1RH6SX3HPCEtPeI30OoMKGubID5ux/F8g5HbF1COPW79s
	OzhxWi76MMCFcorNKYBBg01ItlLF46P4rAQRFOMzzGhz1/Bz8zCwIh87EUtM9Vze
	DADpxILacbIASbBx5FZNfW6HGEmYrVnOynweeKBYk1Yd0I8v8nqfQQ/58XsDZx94
	8Wm00w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwftv1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-sh@vger.kernel.org>; Thu, 09 Jul 2026 11:15:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0199faafso12259971cf.3
        for <linux-sh@vger.kernel.org>; Thu, 09 Jul 2026 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595759; x=1784200559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
        b=kMSp+MCXIXJE0DIs7pFLHYpvXnsnX3iIWZtDgN0i1fJWjnjBoz1NYPDmjbbQCCRNEK
         vscp+wRWlJNCjh/XanhPMyB6cllBsqrXbJaR+3Yim34KJ+QqVhYiq4XnmxXbcn3+kzYX
         htjTdXGkRRCxkvb6URsJhgktwib3kHT7eKtJttgS7TcTyMyPpdBJUvP2lYCZTsqMbzT6
         53EbRfFizqInCSE9LMw26TK3JlfoQcPT/Fcg6Pw9vXT5ycRhoHqWKtMQJQ6LJMNItBsU
         p5s3qJHEUsH+n8X9iO9VfJurTdzfT3D39Xrh9IZvupN59Nvf5nehBIKJmRnYljAv7uS5
         Bxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595759; x=1784200559;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
        b=Dkjw68SDlFVP3VnGx745RrF7/PGJ71zrOM88xdg2K2qdIJHZFXNqIkp9wswlBi7c8/
         +Krjbf+1YoPOmWAULLBwo2cC0drMuMdrVNt6tb4Vz8MWzAf/p30Z460vcKShj/4mWw8/
         rU1kM33FCypGnuP7tPl7TxReKJVldCB2cltmpCAIDEQmoB/kXEW+QwMsw5U6M64JNR8+
         /hZ3vEm7fdd9ZVckJrlcVwvKzIFrDVuvAuffFbCLV4KfXNnJsfX3qjntVWsYhGnI6gUC
         3BKxhaaqALbKvrH/J+ah/nVYGXxjxWTwLau0lYDuoWn1tGIXGkTRZaoYHVkLO+Wy1ZcX
         3YGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNDfMQAKzZUMYbsM14kyDcg9O8o6sXDnvhTXFF9XoUAN3iBilPrwhiWQgtwl7UlDckro62g8NlIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lYDb/OhEKzmm68+dNzvGq67AgSiLwhj+/fN9PwQe8/5TT7z8
	0n05gmCer9+GStaS8VRskB1pX25W2/B9zTOinDy5i2DlnZLtvywmW5efE0nA/YWW/ggXIlr/kAO
	mNy2G2xsuTEj/l7lTHAw6zttrdt/GIA6G6ocWBKN2gwUeVIplkWGasmKmoKmdvg==
X-Gm-Gg: AfdE7cl4JlO6NAxh5sHZCPPkTDJDNbLo7ogY1qCjTpa1WYbhkYcmxHrMw5+D4YrUbdn
	CKjwMoHfaN8Xdf1GZPqRGnkuTMKkN/tmvJk+PTNU0ez6Mtpfm735fmzkCwfwwRuH3fLa3FLAWSy
	VFw7Gcz/cwXpfdzPB8HFMfCNoQjJXJKSNPyI0a/vvk4qokX3kP5lxphM9Mv+omAEV140OkCFR4t
	lpNOsczt1HCLlaqo4XwtsfIG4QpjswJXS8c7en8cvU4oQOSjCMIpX+BB7Z1hA4v/nUusgZAZN8+
	76xxGgnrmrADaeAygGshR6TpToqG0ZTqxnUa6XAvaQQ4Fpk8nhSKLfrmvy4he1MzFP/tbH3oXu6
	m3TJedm5hdFJwjZasE5zR/j8BsP0j1z6AcLdJ2Ly5AwHFChXch4nFIscHY0BKWw==
X-Received: by 2002:a05:622a:1113:b0:51c:1b3d:fe62 with SMTP id d75a77b69052e-51c8b2dbe87mr68191801cf.28.1783595759106;
        Thu, 09 Jul 2026 04:15:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1113:b0:51c:1b3d:fe62 with SMTP id d75a77b69052e-51c8b2dbe87mr68191231cf.28.1783595758685;
        Thu, 09 Jul 2026 04:15:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm50274140f8f.24.2026.07.09.04.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:15:57 -0700 (PDT)
Message-ID: <cf26fe68-5a8d-4d6e-b9f9-d69faa8a6012@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:15:55 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
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
 <20260707190253.865955911@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.865955911@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX/WMCcy+Xe7Xp
 hu8wOJ4r693O9L2x0Fotz6nPVPniiZOKWxHrmxcbmG4hBGBgE+GbcFRaZdxdfXBNXzd38otVmNX
 /8gqebWshroc6ZFR9zgq+eRpOgj6EWSMK2gv+yVPDwJ3grQQA9KTjyzC9Glg6tzL5D/Ak3Zd3Jg
 rv1NWsJMzVkmburFK8Ez750gMWPkyOdNRti/1FhFchJB11/3oIvsAKMUCMy3TMi3tQGwJKlUgKg
 bebI/b8jlSzj5Q5902BnA40dOHbrtWTl7WVnyygww+DAJyCZXFlZTCmjVD1X8hbo21NxUi2LkMB
 HZFQFlwqeM7VbgiCa9aEIyf7oVm37YSHNBaHvs5n2XRizZrZ6mymRKOJVAvBSJT7cX3O+tc7oHr
 QvQz1iUH3lhowEHpoGZsLsRASWVX4U4SQLSKmyVLl0haxj/EECtXYPzjRzVS2ypo7SzwYHFCy1f
 BqQT8C+WRdXN2cmN3jQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX8zUwsRyhZNH+
 fMffvpAjcNVFm8YyFFvzfueWMMU5XwlHOqXpBt9zWF8sTw4ZdWlAXhaFB6IF+GeOdwZJfud3oNq
 Wr8PiuZaHABlvMcYmJkl/jHlIqfbWiM=
X-Proofpoint-ORIG-GUID: SHSA0U5N2IdCbOc15gq2CdFS492N-3l_
X-Proofpoint-GUID: SHSA0U5N2IdCbOc15gq2CdFS492N-3l_
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f82ef cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

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
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> ---
>   arch/loongarch/kernel/syscall.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

