Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528760;
	b=bdWAde8iNauMiQ8DQRh70kOsLAeTG3SeLRyFzVczitwAJQ7/wbFxly4lmqqwFJD27pbe
	 0IM6j/KDKToryPslwV9GAoTumzx+C/kV+z8E4jrnj1EOhJDHUrwkItiURvjy0NAhJJ6xs
	 ian1KESaJXeH3Q+9ZZNlNleXDW2e4M1OA+AO2AtkPS5JVs3B6BTNdz9oidBQ8jrV2d/la
	 26Ay3va1raMBqr9aRjHlLAaL1q1MixyMBObkGcPkw9PTw7TOa22OD1ZPmWGRxFoCHd0rV
	 rMVwYAV31OjfLnw1FbdWOoaeGPzrWCBxaVffQvi/0aIiQgcv8C0Th90deVOIGktnxAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=A3B9SHbkg4CZWm8wkavxTHR67/yF+kGgAeL/quNdhj4=;
	b=ObqxOvJy2eEAg1DeZZIuiFaea3/HWqLsjK2Y2/p9NGem8oueABlzdYnps5bnlma8W0Fs
	 cN1tllORsHNQDD04s2u6XjTE/k8Y6VXtSFwhhVhpvQqVWm/SiKoCl+cA4C3u801atxnCT
	 fRfo6V4v2yWirBPk5/rD50qzbzQClUayZK30h+BOF5kJfN2ooTJskc6M63Y1owNiUL1qX
	 Z8AO3nchf3eNcsLnaX3eAaFNZosDPRiJL3EzOmJMfoqYNRzchVI4BSlfwa4qzBc4E80Lo
	 WV9Sf3iCp1PCaaDp7pmS6n+2u43l1ZJ4mOExWXv/GknonuehhFOfeZQRwcjT0cN3T5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cjon4Ucj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IN7Q9iD+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E498606A33D
	for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 13:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E498606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cjon4Ucj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IN7Q9iD+
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAuLs73541827
	for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 13:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A3B9SHbkg4CZWm8wkavxTHR67/yF+kGgAeL/quNdhj4=; b=cjon4UcjWcOCiCM8
	gWnrwDsiwp8zzMGkWAJPa9keZO2UKCWvdPbBRjeXwrgILeg8A0E6yZL/f9eCqQJy
	O96ohgLQVhZoEIEGGSYendAY0kAs4E/AMMnW7bUQvgm6QHQwOBM5GYlpnMNBqIpb
	G0+KKhKO6HwZ9cJ6SstBm1mVACHgb7ITZaNm349eAUITvyDoOK2Vhts2i71NShzZ
	aTsFDdMyLx5KEmJUoQnOJeHpgXB5N7GQrcGeLfGns3+3ypy6i0l80fMK6zj/XH4v
	ZmAfEaXUVS7MnftLthxU7ZN2TGHLRlWLMZsQMYPU16dT6qFU53GTsRU5/hGoAumG
	Y+fjhQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rha2e4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 13:59:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f5844cb60so820151085a.0
        for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 05:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795528757; x=1796133557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A3B9SHbkg4CZWm8wkavxTHR67/yF+kGgAeL/quNdhj4=;
        b=IN7Q9iD+O4F/PJc2it92D9/IjlQdp6EwM5TEPIVGAQp/v8AEcn9kZyUR/VAhDLneHt
         pdzxCFGP/NAzkGdU1isqrDhHoOxMk2h8qpS78rlgoYO8IUehw5J2N+iaPuMU3eNwEWzI
         a8o/dWwAUN6BpOZOyDZ9PvKU4PUHMoWWAy2GSsX7k1bH3Atyi61hOxt7zbzqvV1hPNy+
         zOeTFRl9M/nygxps3bdprTPVsKW1OPP619EBYe/xe+2nwlmlibFlTVrVKjCqImiYtRxa
         1nG+ztXgG/QZ660Qq3uMBEz8998p76BroN1nAbKGxFgF7/D0rdWigxIMQieNNoE9l535
         ii6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528757; x=1796133557;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3B9SHbkg4CZWm8wkavxTHR67/yF+kGgAeL/quNdhj4=;
        b=sPLcxOlgf9lDd0y2L1hTaLycr1okKeeVxPFKcwJOJ2Rn+ZdwDz5ShHrc8lcWh8RLOi
         dD4EKNy11BGGp5eNzZ9rCQGHvvCTlTWxwo+vkIu29/GpO8N5Vo3qmI0KWSiLQduK7cqW
         kkvE2sFmMDVEj/z/R7zAQkUfCxAzzXrdJc9UbftrCFJqnCSlQtXLjxjuph+RnFIVP0Jf
         5tjoYJezgBZW3c9YgIVYUkokCU7Ese9v2g/anntF2VrKvxie7uiTK0VwWZHTifb07UOY
         5zcTyKLhr9eSbkGlKVpplcxgAhb6O1JM0TvMMlILvlG+UkoNmaX8S/KJTw3EFKsW/LZZ
         KbLw==
X-Forwarded-Encrypted: i=1; AL+hErE9nuIt00Dbl+J/U73iVEU7Lnka0yuu7xEpJ24X050DDJ9XUnqHZXnoEsFB+nc0vIFuzCfbpxOrFQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/1KHZfM3SkIXGpErll7relIa5vtZXrj/Ypw1LOqOwjuNMlXH1i
	cRO1wNmnt6OD7sPADXt5dXsJ44zonCR0E9NSK61VMFVzSv4Ig7oV98H/D9uscc6DpfZ35YXnd3Y
	YntZoroF5MWYhKxdRqUotqbVFDnd9g/qYxZVBLD/CAMp7BpGcuZKDzc191wqoF7SsqAwUKg==
X-Gm-Gg: AZFdTZfpApdsIrY+muur6Gm0v5XTf13c994f0qPOYYYeWCto/+YNaR/xjd2+WYcpPcj
	vTksGkrTdm1x+mQ9Ce5AQBeSKv8e9AnimpIp73HtM/IH/tGGMb2L9VJZhpK01h4B+NI7TAl/4jd
	zk+WXKrQXp5AO2HNq3iW4ni5E7lqDW+iY5ASxKoxIzjWuf+lHyysdVseLL03QzvEiPGgwirnZGj
	T0lGEMI98SRomUYCl46Z9uwtDfsatWpQ2G7WDcV8ApTXGnbdWvCPGEmgnniGCDHorUsrbrZt8Uz
	r8roq2A1ww9kOSAW4+HKmgt+JflfVhgUxQSK+nxg8flcNm3krvv3GGzQ7/jgbAMJV9xe4IaL6S+
	/d9erP2Aj9Qoo7i+0pNIAdvDPFjvhvZ/Ioy3O7fdOtE34gPQ+JCmn4F6dPzZT5fHp6WG3ilfP1Y
	L9cDlQr03E9ULZhez0Jpm+7HX5m76KcQP5KdGxpb6Cdeh65YQfvrhvxXPsxR1WjA==
X-Received: by 2002:a05:620a:1b82:b0:946:1dc:a276 with SMTP id af79cd13be357-949b35ac8d5mr2739757985a.18.1795528757548;
        Tue, 24 Nov 2026 05:59:17 -0800 (PST)
X-Received: by 2002:a05:620a:1b82:b0:946:1dc:a276 with SMTP id af79cd13be357-949b35ac8d5mr2739752885a.18.1795528757012;
        Tue, 24 Nov 2026 05:59:17 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa397asm28945865f8f.48.2026.11.24.05.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:59:16 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Kent Gibson <warthog618@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2 v8] gpiolib: finish the legacy cleanup
Date: Tue, 24 Nov 2026 14:59:13 +0100
Message-ID: <179552875131.26219.14927804757047791549.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123085723.156933-1-arnd@kernel.org>
References: <20261123085723.156933-1-arnd@kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b059836 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5VOqrEiZFYvkFkybF-sA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1NCBTYWx0ZWRfX+z2EhraV1fMW
 POi5B8KyynDgV7X5SkisgRPn76TEDnM/d21saYysT4Qh94PLwCj86fNDbV5i5wo/0wH1lTVkQ6X
 UtaZhkeh+BeKeW5LZBmPbV4uAAUMiOU=
X-Proofpoint-GUID: RVHnnE373c7EJMKqKxjB_Hr6fXurRG0t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1NCBTYWx0ZWRfX0dog5HvYLXme
 lP8tlkkH315aknmWtrWIC9NGysMiJ7Abg7NH53+ro2E/94428vhM7p6O9USG9HLKSTQXlOEDdTc
 ZK5/gaZuwmxmRmTbDxJsSup7O5a+7ujzeFawRbSkxTspfrD3dgKh14PAhfmiQRp93zMxmehqmcD
 Xb2KNJkUeVfQAOSptiez0w1Y1gjCrID5BrkPvXhYFD9mQpZKYp6bq1UYVvg9AWgMucvZCLIpJKs
 atlLcgdzhmxGk99/lJlu05ANanGO6J31j2ugio8pjfn96dkQth7AdVTGnG7XpjtaQ3zXxH/K+Mr
 kb7uOOOjxISnBByh/G0M7nlO3dBYsJjmSGhq39l3y9gNDCUDSvRoCiNZQCuPZYQrg/RENrq3USV
 Z04nmQ1uv/hfNuh91FY9EkFmmlqAMpO25LDYqe6drkiEGKgM55v4D/ERGR7eY2H8vxwmoZS9bds
 uhiamICoGpv1iCYHipQ==
X-Proofpoint-ORIG-GUID: RVHnnE373c7EJMKqKxjB_Hr6fXurRG0t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240054


On Mon, 23 Nov 2026 09:57:21 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These two patches are left from my cleanup series, finishing off the
> work to turn off CONFIG_GPIOLIB_LEGACY by default, and removing the
> include/linux/gpio.h header.
> 
> This was planned for 7.3 originally[1], but kept conflicting with
> ongoing cleanups for the broken rsk7203 board. I've skipped the
> oneline rsk change now, which will be fixed properly by Dmitry's
> patch [2].
> 
> [...]

Applied, thanks!

[1/2] gpiolib: turn off legacy interface by default
      https://git.kernel.org/brgl/c/b52fb554b36ba37f86a591d0d27dc45fc5628920

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
