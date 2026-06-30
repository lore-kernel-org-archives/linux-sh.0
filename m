Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10831E82F
	for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857301; cv=none; b=ZJNzhenR4+qjIPE85iTmjOP93DbugWyN26Q7Ua2QL5tlJJFj8ERxXV4Ok8yY9mAoEDc4kmvglokMVYgaqA6Zyky5iO4V7UXo0d6V0AuSIwzXkRZertyx2KZaDuHHgVGxyvjAVQFK0J2iHdSaXQFtI7QcLDYSqMUHzi9zK9Ez208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857301; c=relaxed/simple;
	bh=XWXB5lkBc/phatIESF5YzvRqacHTijEtNRuYnvo2MIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfhJso+2nCjRXUZJcV89rMsv35BCneUSJ3bJidv8VcNAB2GXnttcaUp4IVfzpMA9Sj8wPNGzv3R9oQH62FUrN8vPx22JK3gZyMalb/seEP2X8YvTFrYn1D/JN1I429YavA5WrhKvyaB5x9aZg/XF2CSbOGDcMPn6CX2FrV3Nh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cCTN+vD4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M5IwW6Ik; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cCTN+vD4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M5IwW6Ik"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJE2GS2948547
	for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 22:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BcCIhz6+fnrglONp8q+fp9mef6PmcObbxRhKXStO7Qc=; b=cCTN+vD4HZwmI8lY
	ejqu7lzDeKTXwqFAMS/sTRNpvdMoMiAxUyoiJA4eFhpTgRLfRvMGXkbNO/sLcOq/
	Kr+o5qtLY8bZPydk48LmdD/QYhha9Mb3Zu6Jg+jFbz2OOi1lt4JlAnzouxfKRufJ
	1vGYuxgbkXfYsDebztJs91VxnfPK2OfyBaisU1JmguWpqdxoLPcaXic72syA9QUH
	lQgzTeaDRLIA5CkABN64XzCZrZhXKelOBhJ4L0wGngzhGDLoUE7KBunhksmwlV73
	6OwRuUZRp541lZkHdVRtlTvsEu9R7y1qiVobl6Ek9AO7twcGrKJzrgt8SbClgnEU
	dlxizg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4h0ask3j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 22:08:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5e38fbc5so459446585a.2
        for <linux-sh@vger.kernel.org>; Tue, 30 Jun 2026 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782857298; x=1783462098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcCIhz6+fnrglONp8q+fp9mef6PmcObbxRhKXStO7Qc=;
        b=M5IwW6IkHK0iiF66T0HlZSqYBxXV2G7M0IeKaGSbbe73F0yJIaWzFqHevIJO8uzIpb
         NJpZ5komiQgwZ5mg1Vn89GRH2bf9vc3fLtCX/yZzK0wZgX5F0ellNrWmqv9ZzNnIQxK2
         SebMjQrysqRIXgyl/cta8uiRcj7xmyCOqMJTMei9OtRlUg+Bo7kqd9TQ0ePHWoUgrR1s
         RSwP+bXBvQp8qpFWg57bFTZfYrj3FRHPWVaRSHNO46r1gP+HHFGe7nhiTjazcsh+NwrB
         gSvXCfwZirBHtsae2T5Y4kaenRQArPYJ7Aq32plSwlH1AyYSdRp27EPcvPiicehTslAI
         W94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782857298; x=1783462098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcCIhz6+fnrglONp8q+fp9mef6PmcObbxRhKXStO7Qc=;
        b=V5qis9bsInKTede+0mMzvRE28dCzh1bE67OFXGAdMFHoqiXsNTwWLtIArswP5p3oqr
         Grmu1AQdGlYGUQn8jlCylY0+Q4+HFwnn7JBNY/yiFFnqBYKUc5HFEaXrHsFmouEvNZO2
         8S+NrR+ytW6bFlBf+Enwig5K1Y2zQHWkVqgT39Fr5y3SsjTPxFftH01pvdddVpgyOPKl
         usNqO5DCyXDlBgVdOlV9bK0tXkUWzLPEuSjdwk0zGfpYXqNVMORD6IALx18cZ6sRJppa
         /0TI89fGeO8J6nUNsURmFHznsZE0F3FKUVqWRLVllOxJVoDCd6nXaHVGoPdzGuDta+pT
         zqcA==
X-Forwarded-Encrypted: i=1; AFNElJ/3g+AQ+CX7nBxG0iVvB2OlFFfVgvaQHL3Sm8RXHzhbYn0I0pUZjWmXB3lvqKyzppueLploV/0Kbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUxjtVVHjXGyOD0R34U+WU8ClRlxQT1T5lL5DTS4D5aO6oM9o
	Z23WD4Ii5ktgGqPt305Ymhk8Q79qIpxZ5m46igMpSwHjD+3DwAgxsntF/3peR8GlggLelHdq1Sz
	j21kF2XxHlDstdvZC7A/mcgKH9DuuUdh7OWXNOwgCMViJxJUedd9MBFnHVYI5ng==
X-Gm-Gg: AfdE7cngP85BdTWwCvhvcnoBbAQsVcX8PIX8CYXauXQhS7t02slkxJ7jeW3HkgojFoZ
	yGEF1Bhg5Rkrelq1Zf+3MQq9IVcGOkvBOgxQ22wp8322rWRIuSJJW12hlo6E0EJoe9uJqBS3PN+
	Gc8kjG46KLfdWetl7ruhCfhPZt3bQXamCQIm3XRZjMnzT1s4geRV59V2BJIgTsO8DvWAeKM4k/M
	2B1BY3j+Pcid9K9sM9VjYCdARmxddZgmXD0iGNOxVx+1cWAzCxTw6zdKFn471c/9y9pvjpr9tv+
	1veF3iUzlAUEyHJxidI+KefBzgRLXeSdFC1B5cWm4l3gTKQYtPnJWAUj5X9Q5JOy5JG/okZ34xM
	/AC1s0dml5OZ4kmgC/L10rydsaGFG9SxQpQBL7d8OYPahBJTekJIgMW0/vIzuUw==
X-Received: by 2002:a05:620a:25d3:b0:92e:5c56:727a with SMTP id af79cd13be357-92e627fa3f0mr909678185a.60.1782857297817;
        Tue, 30 Jun 2026 15:08:17 -0700 (PDT)
X-Received: by 2002:a05:620a:25d3:b0:92e:5c56:727a with SMTP id af79cd13be357-92e627fa3f0mr909671285a.60.1782857297248;
        Tue, 30 Jun 2026 15:08:17 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm9903482f8f.19.2026.06.30.15.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 15:08:16 -0700 (PDT)
Message-ID: <9c94a0b6-a2e6-4d3e-872d-b1d3954a4071@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:08:14 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] mips: replace linux/gpio.h inclusions
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
 <20260629132633.1300009-4-arnd@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629132633.1300009-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OuF/DS/t c=1 sm=1 tr=0 ts=6a443e52 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: g8N5U2MrbDeiSXfhfO0rvXmSLuFhqmNb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfX5UmeCqdpfDp3
 x0nBcULZatkWo6q+1fhg3JoM/flajlmSnYHG1PZXwNpmC/2K/h5+hzrWGEeSm7jewH2Ip+EYHY7
 ALAJV+WPLx3kL18wl8rH3Gp6ebs81UQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfX4ebcjk5jj9K+
 OXm6ABnP920Khx1OLul/860HcRTTfUrkdPMe1pihvvNG1vuTBk9fVwZvBOLog7NcI/LfrLZ+C+6
 dCkc8klNsmQZl7ABIjmqK44hlQ68lrsvn+GdK1rZgSn9/lrFNd8mdjXH/JxQSI0JmjiIQLPEKj0
 vSRAEyGoX08ykDNu0pF5ZyHVoChcBFg/YEMrK0LFmOA4vIC/tiiRN8SwHbGi3F57krm4nyKCa0A
 ujJ1JEdA3AcyaJ/kSMrdXQlKI3vBlSpL9dBbZI//ysEGfXGcWj9+HPGkUwvstS4BZVXjdSq2QM9
 kaq8+52ZcN8266fkWdzsg0aOlGRUF5EwVKGeWSS0IHlA4w7yvBIfZrGDXN4PwcKIwy3PWdIL8+R
 yullbcuJ84B0jN9IiudyUomD50JGvQpSxBNy4AiSKT1BzCUzqtbOoLYca332jwKNsghWlvjjhmH
 vswinQKLUBBGyoysPgA==
X-Proofpoint-GUID: g8N5U2MrbDeiSXfhfO0rvXmSLuFhqmNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300216

On 29/6/26 15:26, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> linux/gpio.h should no longer be used, convert these instead to
> either linux/gpio/consumer.h or linux/gpio/legacy.h as needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/mips/alchemy/board-xxs1500.c                   | 2 +-
>   arch/mips/alchemy/devboards/db1000.c                | 2 +-
>   arch/mips/alchemy/devboards/db1200.c                | 2 +-
>   arch/mips/alchemy/devboards/db1550.c                | 2 +-
>   arch/mips/bcm47xx/workarounds.c                     | 2 +-
>   arch/mips/bcm63xx/boards/board_bcm963xx.c           | 1 +
>   arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h | 2 +-
>   arch/mips/txx9/rbtx4927/setup.c                     | 2 +-
>   8 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
