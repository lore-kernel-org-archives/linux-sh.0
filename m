Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291238910F
	for <linux-sh@vger.kernel.org>; Thu,  9 Jul 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595895; cv=none; b=jXtioofHm0cNDm/uFTnZZs7VPvisZ9ZgLrm6kWHPkJPaTl7saLlmZ5Gb2Ylcut/wTl0KUB0hw9M0OXvYsM0lvXcnmNDLu0eK272fv4lSh+XqvQQrqdxb0oTWwYC6pO5RiXJiGP1+Luzl/OtRLvwtKQXRcEsvUiFJLw/W+cjkh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595895; c=relaxed/simple;
	bh=JIbY68pv3tLScCT8hJ5wD/twH9VZZ6GeM09XMVAWRO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EP2oC1amaT3ydtXFlVzi75xEDRhwC6Jg2zKCJN4WQJARNJKcf+mHZ93tN8L2cdpAj9OtZJwc3WpOzHBYdHZcK7NXBR3fgh0nJTiH/JEX94caN8kxvoTDTG8FYZAsQlFio2UW0pMyKAhPxGy3TGteHEBNCHL3lweaovAF8/3kAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fyY0pNu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/HUYHsJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fyY0pNu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/HUYHsJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxQI31435023
	for <linux-sh@vger.kernel.org>; Thu, 9 Jul 2026 11:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=; b=fyY0pNu1SYakkEnc
	jiua1Bz59Z/HxTO6ZZj7/6VoWVtUtY1ICmo9H1Pd2QjrZWC8gJfOm9T5qkA9XEc9
	zZ/LvhTR9YL1D4FRKeeUPeBJzIH2ig7MkQc5n0wn0ncq5EOUUpyCj9xucWrHafNA
	Mhaf5VX3wvgWTqgyvze8xNYS1i224SoOljNif2MkoC4501PXlkZEU2tlj13tOCVF
	k1OcXw5rO9V9U6F4nqjFTDFlr4SsHrosvOnlojjBDdlvWI+//0MRkxof7+sUSdLM
	DMKQPcPOu2w9XU1PRa+80kn2vAWE27oY8QNhmoRslamfrHh0e5dTRzAtOzXXQfwX
	yQEHaQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwftvda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-sh@vger.kernel.org>; Thu, 09 Jul 2026 11:18:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51a87ef9713so8501801cf.1
        for <linux-sh@vger.kernel.org>; Thu, 09 Jul 2026 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595889; x=1784200689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
        b=a/HUYHsJbOFVJwiRG0RQW3NNKqU/49xLeQWT+/4XZQfImsPMD5gE4TyA500tJAQbh5
         lSVhkRGTSMHeFp7jrrELc/EBVaP+vqpvtGCr+IbQUI03ePqJpd3O3TG2L+r2wdu1xxJZ
         7bSiKGtmqWVBZovpbQaJnslJQIy3uPwn5zokQuJ8IXdMplF8QkRk3HeGebnUP+spIa3V
         wvUPRi9IV3PQTixkgnnWVLlM63x7Fx4O1H0JEBDz0sr3std8kiQkO+Qx8dRBK95XsXdK
         cgPRYwdQx9ZDNnPa5Owp0HwVPhtfgEYCNPMaVzMUaNFixzVfVv3vcN0iA+QS19sqnA6P
         B6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595889; x=1784200689;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
        b=cALM9gDOQJSkd3y9FntP5wou7MW4Og+ujuwN6Y8w3sJC/ooNay6y8H2aECkUbtWuZH
         pBqhscRBVKyTRjeS+TDcAiwNuXv3jYFBRFlT3miJRmU8kVP10hAbq9zOnnATYnCF/Zoo
         KjLdwm8xNmWCkqdAKI8T3dMKwBf4QtbXvXlPvuR1POB4jVKFx8NWCqDjdvrQMx5c0Lxc
         13GGRQDTYL3u69FgnrM7s15ZvVj3eKbpdwonUH2nBjmBHW3M2iiNamuMRfBUEjQyrla0
         DqoUSBxe8QUb4+ClpG1pxuiZcTWk2JOcyfIN7B378IqdXSm+29YiZDH1RLKjUIvW+VSe
         FaQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrwXK0UCOFHqWjU8evVw+IMw0buY4o2uZW1+mYP/0xfjDuwX2A5Hn/fnRMIHVC/x+ahblje4GN/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTaELdmaMjHI0ZSYMPn38HXI1URTo+lWyF/TzzvQHdZFmrcRbs
	wehfk6fGk+2BTTlejNAkyJ2xifr1iAZVIJpLJ47CkLJHXHPAQ6/i6+WLz/+DUXJmIuXM+aFZuCH
	PYNduMfllUe93WOP4ffq1fgXF/iZ6zdJCHAR71dNPwqUm0Zo0F2R0rW3oaK93rg==
X-Gm-Gg: AfdE7cko+Ym6xEnWvUDhVZanrkKENEMbab0Q0/P6Ca6O0W2V+YHRB9HXVC1uaKKC7jm
	w0plEjVx+jwZ8WOfKJIV/9IlFS72qswQlzkFBajroV5jL7pFFwuZ1YolhoeYIXmLhEp8d7qKAp+
	Smo3EddfkuP3NU1P5Ev5eBWmzuxdtET8+2T5toGPvC7RfX9+yVTRmRxEEUCaUC1M8CfSU9bQCMw
	ugtxgo2xtDFzb++RkZDzlab8jMNkbK54hIIebxoR4c7IlCT84szZadKgbjUSBw+g7BfeExvPgsF
	NkYoTtHoGEWBreGTphev2cYTfbgCSTuFFE88qz++PDETucL6qhhRN7jFycVwbrgH+h9unxsCGDi
	+g1CdaQQtfaQD97kNN1zsUG4njMgUv9e8VMfElapXBP5TJbFP3R40k8t52pz2tQ==
X-Received: by 2002:ac8:5d06:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c9b9c9812mr22454341cf.27.1783595888715;
        Thu, 09 Jul 2026 04:18:08 -0700 (PDT)
X-Received: by 2002:ac8:5d06:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c9b9c9812mr22453591cf.27.1783595888214;
        Thu, 09 Jul 2026 04:18:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm53036115e9.6.2026.07.09.04.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:18:07 -0700 (PDT)
Message-ID: <e89995a7-0da5-4581-bce0-5dafc377e9b9@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:18:04 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
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
 <20260707190254.079478122@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.079478122@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX2y0SkqObavGh
 Uh/q8oM3Gr7ARU5fKMAuhHSt5BCbPZQaomMZlL6jGCzVpmrh1adPllGtyYSTxUIWdLxw8bli9hO
 nfPi5AtukVjxFPB5x1ZHQOubx8g5W3PMUkOYfGRzhpnWbHBu8/AAO8nBvLflXKFLJQ4PnoY//sO
 +xwXgENQIVyjlcd3D0o/wTYNNfKYNdlJ2wQQCx0SlIj4MnsLjJzYfwjxH+5Ny/o0S85f9LbtPDj
 7f4Jses+WqBoUqfgs9wBMFscfuixCUNK7qi2J+OkLvh4+EmXeSCasdJJpjVj3hLf1hFj4fUuzWy
 I+3QZVXRNprDzMY4HncmvYgEfUS5Zn5ZlQnY2Kou/9XwFPv60KW5NK0ckHMB3eOKvDZhhciaYxC
 kpSPxg+1TEaHuxwfOn0j3DXF1krb53oHg9EUFNDMEdSH1J+VIzkPv1qwCH1I4jxUWg7h+TSLtl0
 2lKJd0WrDpKOFF+e6kQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX3+CUDe3TMQLW
 oQY8lu0en/klYueSd6Gt1h704G3UPHEiU/LdszesdK3WXAT9Cvr0IjtZJUzusLLmasMOG6qYgA+
 z39mI9V/QX5RAhuI404K4tYjOXlUezs=
X-Proofpoint-ORIG-GUID: IfWL1pOM4ijSrgkATYzcBR4AUvW2fBkr
X-Proofpoint-GUID: IfWL1pOM4ijSrgkATYzcBR4AUvW2fBkr
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f8375 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wOAZ5We2mjvvK_q5lLMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
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
> These functions integrate the stack randomization.
> 
> syscall_enter_from_user_mode_randomize_stack() has the advantage that the
> randomization happens early right after enter_from_user_mode().
> 
> In both cases also the overhead of get/put_cpu_var() in
> add_random_kstack_offset() is avoided.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: x86@kernel.org
> ---
>   arch/x86/entry/syscall_32.c         |   19 +++++--------------
>   arch/x86/entry/syscall_64.c         |    3 +--
>   arch/x86/include/asm/entry-common.h |    1 -
>   3 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
