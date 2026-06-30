Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BE329371
	for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857400; cv=none; b=nE2LOkD9Dj7DP47KmBHUdeoRaV7pHsWHIAszp4cPDpitfGEk7fP5vwgjyrGMS0f37PnRZjzeM15+njs9X1HItl2260NLtxNXlLx/yhr1o7eoxpB7PZ2W6JSQv6DhLVUOu/nYLQ4xXZq+/BfB+4FLOy5G+T4V1IJCHAgnkr6k7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857400; c=relaxed/simple;
	bh=lka07Gr3l2JawsdDoDkCfszFn1o8HA7+GaDRSGzKdLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZoZy9oPGWW9w7Vn+N7w/codJB1cT65gKc/2Yi+DooGsqBEeWg1sYqS9TRggfAQoNwnP19ztDEpzEkuK8T9HgAFYs40mxUz/yRyuEvmnmdC2Caftej5JzeR6SXlrHSw7AS28+E7r8+wFRUTOHnCJto7NdhGIGF3mb0EPH+yXfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UVVUyqEg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRJsyDRg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UVVUyqEg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRJsyDRg"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDkJa2879979
	for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 22:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	71yptdqayaVFzpJtAQzWI+qpR5NfHXrkWbz9ikn7Ryc=; b=UVVUyqEgI3aai44H
	QkYs6h4Sk/6/uPO94ctKOtJjj3n5+wTduu75T3lBINHDzCPeXdCe/LLgdz4BiIIA
	I6FCYJGuW6rbqCzG+PqGMHpMb6xjJcmfkHJt1PYgP/kntODh+X0VaaTTgDbDdP/t
	5mK6QuZEI5QJqRhPc//Uvx2PsEtojBE3Wf5jUoCGbxwxji82ZKuqfAGOBqi/CtJM
	MHsN9S66aTzRxKSc9r6r3jxLGT72P0S66dSuzw/gjfRycE/zeF8d/az8b9/+BxqX
	uSr2XsXere5zlNsaYwMjPVwz06xYAC/u+oMsdfeWvyWqnAZBEcPGno6XGT0scTZD
	4sRW/w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfy9d9j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 22:09:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ef8249f73fso943686d6.0
        for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782857397; x=1783462197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71yptdqayaVFzpJtAQzWI+qpR5NfHXrkWbz9ikn7Ryc=;
        b=NRJsyDRgz9XcsskDy1TCStajobjEVNxjDA4Y9JZ5YMTLcBi9FjUItPsUngOQEBg+Ve
         qCRCHUiUpd9V35DZ7oUeLzju31vveARTtZe9HrVhQDCcAJcPYuvJiG46Hv0aZK4TUEAd
         LjXYOD5BGZmYIA39/qF/kHDQRYxv4Ui7o9c1BLhA8bCMd8MCeNNEwUoVW3nW1QOL8HOE
         uRPOEvPot4OpwEeJOWmsxnHopCwAs4RQgWaTZCne0w0DuiZRruYr26BbTeTaohBkIYr2
         bvNdMnDKPbiyjlCms1hLacLCibEbq0ywkqfYCG58x374QsjTl+HiMPLbYJR9NlMCknbf
         2fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782857397; x=1783462197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71yptdqayaVFzpJtAQzWI+qpR5NfHXrkWbz9ikn7Ryc=;
        b=sT4KXgyLlLtAVXHlvedTc/wjt8DSkbmXAdShEZ/Gz4Rn81nBNZfPlZhq/3U9MA1vEn
         zgmrCKm1yD2KtsCrF2gxL7T/99ctE5UuWTiLL7vcQFzthHzZ3aaC/94+CgnSoE1fXbqu
         icEyfBJ/7SZ6x0NZAl/NTwyCZd7zs7Q34rJaKWz3RtiY1nwIPuHZuY78TXcDnjJ4gS5F
         iE57hdjZmjSMrmacmXz8F4aetDLJVdOwR4z9C9cV7E4r47aszXBT8urfkt3i8CYbr+pZ
         4gEjzsp3ZFC2OUk9ojg738ovcR0EYKJd4iohb7BxuAYWv6UZ4OtfUpMrfKiVoJCehmmN
         M00Q==
X-Forwarded-Encrypted: i=1; AFNElJ/9ulBTEBiIv6RKol4fU8Onm3argmT/JG3zXgIH5xEpNBl658E5xMBDHOBmctxv7InNQyuUGydl6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OiqTpU0UnXsRJmmFFBxItE9f0hnCrwnAIGtsWBG/Wbg66EUc
	n8zeA8NBegu3CTpTi2iqYmqqeCHLti2Wd5bElBn1uUGg9cDVY+sDgtQX2LcqvxrVg9N2bheTqpn
	JuSbpK9U8WoAVXsWsrsgAJo2Ucon0Yrh/xi6qGvxZrjZa1lOgvlvwDsoGIrmJpw==
X-Gm-Gg: AfdE7ckPMK7wmhtOrJBzkD30m7pvjz1XNmzDtzdAvKcXekXK+V586Ww3HkZQE5wWvxR
	Nzlq1rboTYhv3LbJnBk52zBKL85WGwo2IV5jLqhgfAo2+J6SSBP74R98VVho+ALh2+02qO9b1TG
	cX1xeC7ZwpuDwIv3suA9G1xaeNpeNN+6lUELHZvo25se08h6DbBwJyOWGLvG+7IHJqSwLS836YB
	nCKIkw3ZyIDxAfEhye/2edJ6++TtHSe9Aoxm/NQTktrDyAeLDSJ6PmqcPqBEf9UDd3PWRQrxv3M
	fGEGHWzjWR3b3fVPVbccrbwt5uoNkKSKyzNuHDnXZq5f17UNy8hMahFPXNEKMMG/fOJFIVln00d
	aLLa/8XrPGNg7GHvB2fcqMeZ4Et0Hn990umt+jIC4b17FDA6aqagUzbF8zYLAwA==
X-Received: by 2002:a05:620a:468c:b0:92b:6805:918a with SMTP id af79cd13be357-92e6d926a2cmr434241985a.66.1782857397389;
        Tue, 30 Jun 2026 15:09:57 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:92b:6805:918a with SMTP id af79cd13be357-92e6d926a2cmr434238085a.66.1782857396955;
        Tue, 30 Jun 2026 15:09:56 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195b3sm11865243f8f.8.2026.06.30.15.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 15:09:56 -0700 (PDT)
Message-ID: <caa30078-9dd0-4f07-a206-2dcbd2ba09a1@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:09:54 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] gpiolib: remove linux/gpio.h
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Frank Li <Frank.Li@nxp.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-14-arnd@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629132633.1300009-14-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a443eb6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: 691OYOTkJyXL4ER3eGsts3nS6apJKE8G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfXyxAWzYzhAbjb
 E5VbnG7ElypMOc58GhV2MJ6iAnNDvCpLdwQt6lMl4W2pYq9ldejptJzXVVKm3p3rW8fHAfHCZXo
 U1WJF+AUg1RcyjOMhxWiCvoaIMSKVpg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfX2SQ1TnJHlDhu
 zMFtGkcMvz5okLHuOxm2wMA+yIyNhDsYFlhF+ZmvrTgb52XO/OLRGcZ4xkYZ6+wydociXXwQF3e
 /j9Vq6L6BA2YFKGIV8Wdzh27cU4neG3xHhj4Z8z+kYAxVKVvkSp0Wd92lULUxdGKWfsyvEciCPw
 jtcVmXyH+C90/Cjzn3BibIHgg4U3U8/VF+3Rb2jExix/4rqrJdPQpSFDWEgzc0Sl0IkNDAjmQVd
 KTaVyUEhJUiigmAz8t+B2svAoYg1gQSFRm86LHVxQKZiUWcQVovERxmACeE4NRt1J+VOebcC/ab
 7c0yhm4TvN6lzvl/MikDixmubNx3s2myfKhFAoOoo3/Uvp4fFatjzvf7AtFKdqN8JrH1OB47r5a
 rtRasHYpIuwZtUkL+E4l75dufP1L74359wy679bQtI5tjooVvuSuNayHNZIRKXRZHZC9J/eFRnZ
 K07eTZd47TnKrcm1rSA==
X-Proofpoint-GUID: 691OYOTkJyXL4ER3eGsts3nS6apJKE8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300216

On 29/6/26 15:26, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After all other drivers have converted to linux/gpio/consumer.h
> or linux/gpio/legacy.h, remove the final leftover bits here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   MAINTAINERS                   |  1 -
>   drivers/gpio/TODO             |  4 +---
>   drivers/gpio/gpiolib-cdev.c   |  2 +-
>   drivers/gpio/gpiolib-legacy.c |  3 +--
>   drivers/gpio/gpiolib.c        |  2 +-
>   include/linux/gpio.h          | 22 ----------------------
>   6 files changed, 4 insertions(+), 30 deletions(-)
>   delete mode 100644 include/linux/gpio.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
