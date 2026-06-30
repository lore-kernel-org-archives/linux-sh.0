Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7F9316192
	for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857331; cv=none; b=IYF+L74Wcz/VVogFnoadlZw3yxBBekPxKfhrXb0AJ4CiwjdVgiZh90HoSBnhRFmaY8IqM8mnSLGZtd2RUPao0q6nkk2MxXuqwZ0gyEvoxYLIJoja/N1AWdW/M9bKNDUazgHr4hQfWcS67/+yTg6PyAVJGXTqZYDKcZJIPtLImQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857331; c=relaxed/simple;
	bh=eyMPhz4D72N34DaHLBk8TtAHe/1rzGfpY/U34NdyrfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTjLUdLxJZ/HP2xGcAr2ciOjth86L2UfM2b+3vcdlsqpiwUDseO10I60QOh9/+TfcXHuzDTiVvDq/pYFBYqphQqFUo1sSBeKhF5Qxm7pCNvD6TjmljrPneerH0mGy0qJjdkrAy//mw62ZbmlEYIQNr/Ipum6gkspC0PSQfpPnKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjdrKYpV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EaDRdcoP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjdrKYpV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EaDRdcoP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDvTx2960401
	for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 22:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X1ZxiCoDe6QCyz0498GlQmGlGSpLwZNnkWsIqh3kavo=; b=YjdrKYpVqZ8H9XAX
	ibF7vH/kUADBSYjVGZClU63lnyKF8JVv5GZII67PEhUmScSfLZEtlySCd/8RXj6x
	o+rkx6Eto9cTsN3V7OIW3H3NJVDGsBpAi4uBgzMTXdfS8EGc3015nJ1/UL2kEZ4+
	BA9iwT1xYJSu51qvtJlUaI7KWY9mpv+Zf/4q7MA6Zp7fhxha5a52zn6FeCol17DP
	00t0lcWini3dby7PAFSuxWS4FE74H/bGbkax08nYfIc7ANpPU3ABvUKZKfwTZ7uA
	3ZIoFEoYf5v4XPixYIG36bcjUj9HG8lp6iaVzz8ebgdDiRlDt/46JVeyX2EfpF/f
	aeUJpA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j9114dw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 22:08:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ec3314f65fso255076d6.3
        for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782857328; x=1783462128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1ZxiCoDe6QCyz0498GlQmGlGSpLwZNnkWsIqh3kavo=;
        b=EaDRdcoPceYoAWWUwIABiowKA4xewzdMc0gWkmN5YI4B5fvUgR0r97ljpcBh7pYPum
         Iu9t6cIR/v6ZyzFFS+67GAP99hO3p9A8cR5pDpNEx/BaqSEtfVfaLGdXSaGKYNiN/YR9
         7JtpB/Rw3BQinIvKbYVHwtjr7VMPL3pYrzc+BlzcGrbjuD45LolyizX/ssLCjCOfdCFO
         21fDXXr1D8DW5xVOBg3DGONiiZxODGhEBgGmB9ZZKoj7DFKhN0Y8W9nwQhEWAXhyUWca
         pPphpA+1fknebnZUlAdDkznvkTfjuXH6gej05AM++BuzPNFZ8dUStE0eu88NiOVHJosH
         3g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782857328; x=1783462128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1ZxiCoDe6QCyz0498GlQmGlGSpLwZNnkWsIqh3kavo=;
        b=eN06q4dccTPHoRpkdqFoNytJojn4HJN9UixwYFHgFd6WWx8RrdmUsr+xbm+VulX4Gb
         xo1RE0tYx5uTniu+LTnWdNQIOBxMgxekma5eH4KPc9VfAEP/Rjh0XKIDzdZp2Y8O3j2I
         LLGdJ0X0UYt/6ONKT5ZZPJZ5KIlTanS66nx2g44kdUeFLBiWS7xsZzZJsXw6vK+tIw36
         KwieeGI8AP9JSu3gLr8PvZ17RnWeDjkYa5Pn8q9s6TokIMgwBCRXFw/GHwYKkE6MnasP
         2J1njBkaQOcXpAr22gh9xgnUh404ECYnkwAIshN9ldFWoKtxu/eeIHEQ2e31clMR63RC
         P0AA==
X-Forwarded-Encrypted: i=1; AFNElJ9wXX5ofFb3sWM8s+8ZeVJWVqAPnaAqg4CUcPZWaiZnNa2K8XouTxDDBxjy1GeqqfY4CREYNR3yKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxejLQWyv7ikYgrPeYX6HUM8NybeTUUo52Veg/eMbVTgyz98e+C
	Y1ogTLSp29EHB4WjmOBLwpixfZnhc0U2tRAT4xlY71zaYBr5kqyqgCMPvpz4LQ4k/Ou5x56ttQG
	G0oTYCBFf5Q/9uDoSP25uIiJDdu4fsX0jl+MMVw9SrGQvxIpJo6eT2Baf8hl9eA==
X-Gm-Gg: AfdE7ckvgitC2G7ux8rNL15iNOqDT+dwb/bqgh/aLA9m23953DnmkHK4P3OpCAca6VB
	U2mDD0TF7SeXD/2Pj0E6HniamLW/Yz1/FaFmJLeDkWpSnfBvVZS8Gb5lZwCO8ufO7WJZcx3zFBh
	qDkomQekkYHUIBI3ZSfthJjeseoeby7SBudmNlFos72FMptSpyJaDu9xpNPd2P2964JoIDMBkUV
	bsVOtZpvOXk646cd9KctaoYBuya6cZNshqyZc6TA7g+A2G8Vn/mx6/0XLpWdIEwPOfreyqi77jM
	yybDmlmjsICWJyPC1WeT2VnnxTLRLcdpIqaR0vHDCZDuugRZr4N9BmKzyNwwOXSat7QkHv11gtB
	Qsa7LSiX8NaoORQYF5HwI8wOmDAA9+Qcmr8LXauRxtbh+zn19XSmVjoI+USwqGg==
X-Received: by 2002:a05:620a:4511:b0:915:8502:f7fe with SMTP id af79cd13be357-92e6d7dc6cemr404384985a.15.1782857328298;
        Tue, 30 Jun 2026 15:08:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4511:b0:915:8502:f7fe with SMTP id af79cd13be357-92e6d7dc6cemr404382285a.15.1782857327863;
        Tue, 30 Jun 2026 15:08:47 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4d9daasm28380565e9.9.2026.06.30.15.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 15:08:47 -0700 (PDT)
Message-ID: <6bcfcfca-aee3-42cf-baba-9a926ef26471@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:08:44 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] sh: replace linux/gpio.h inclusions
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
 <20260629132633.1300009-5-arnd@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629132633.1300009-5-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VZbpKK-uaaIQOk3RePisoPDPNtbHC2ZZ
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a443e71 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: VZbpKK-uaaIQOk3RePisoPDPNtbHC2ZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfXwOvaSNHmVZTk
 vrpmPRrDboDl8CL3k8DUeGnOBsIh/PDVxdtX8rCJGFKS3Od7AQKI8Dm+c9i2v7PBOqDZhT1oY74
 1NHosXt5tRkLr6JBze2Z2hueg04qqFkSkUlC8GZytOhxH1INvGqWIgj8uD/A4HOe1mnGFgu3csN
 qn7Y8EZOJQ5s95qi0duXE9FBSCwIjjGM36oF8eWvNOhu9Ivsp4bMPTGQYzcMU2hFJh8W146B3Qb
 Ji8BPgqxKahA7nCrhnDNIa6Yasrrfi43C1LxvW/UPzxmlqEn4HRZSppTGqAYWWIPhsFyDZfFJGa
 0h6DXkqliZdB0v1/hRZTNvlFvgH2ODROE2XF+HsEFTu4/R/n54AiDBfdajnnBfc0bpidFn23lb1
 zNODIhQlSOJmFuZ6zvhVzBt/d3EOW4tArnLcNS1fsHjiSiXswHPdVT4/UXT7alAH5FcuaVvLTR8
 iUH8VGNfxrLY9B9iATg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfX+js+sn0RJfWa
 jUs/9dJ0cRj64NOBlf1Qre5j8EbTO6i8MWWGo2wEmdXIYBDgngDxRYhg8fR7r2osvsQtPyaBuz7
 w3YYD64Z2xCyDT+hcH0HoIBwQbO/XIU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300216

On 29/6/26 15:26, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> linux/gpio.h should no longer be used, convert these instead to
> linux/gpio/legacy.h for the sh boards using the legacy interfaces,
> or remove it where it is not needed at all.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/sh/boards/board-magicpanelr2.c             | 2 +-
>   arch/sh/boards/board-sh7757lcr.c                | 2 +-
>   arch/sh/boards/board-urquell.c                  | 2 +-
>   arch/sh/boards/mach-ap325rxa/setup.c            | 2 +-
>   arch/sh/boards/mach-ecovec24/setup.c            | 2 +-
>   arch/sh/boards/mach-highlander/pinmux-r7785rp.c | 2 +-
>   arch/sh/boards/mach-kfr2r09/lcd_wqvga.c         | 2 +-
>   arch/sh/boards/mach-kfr2r09/setup.c             | 2 +-
>   arch/sh/boards/mach-migor/lcd_qvga.c            | 2 +-
>   arch/sh/boards/mach-migor/setup.c               | 2 +-
>   arch/sh/boards/mach-rsk/devices-rsk7203.c       | 2 +-
>   arch/sh/boards/mach-rsk/devices-rsk7269.c       | 1 -
>   arch/sh/boards/mach-se/7724/setup.c             | 2 +-
>   arch/sh/include/mach-common/mach/magicpanelr2.h | 2 --
>   arch/sh/kernel/cpu/sh4a/setup-shx3.c            | 2 +-
>   15 files changed, 13 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
