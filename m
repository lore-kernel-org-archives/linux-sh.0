Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423545;
	b=Ka/1X9eW672jWoNEtDogWKpCVvy2iMaPZ6n9JKSr649lrfM5zwj40Lwr7KydQxv9R7QV
	 AD10QXyyia5Z6UBdz7HfmvxRt/g0QxtLS7r9UB/Wb6MGLLHIP3BcX+7eSY3cHh+J0dyAq
	 lOEveydqQ7V9820MsJH8qRXC8+F3q7EcNK+VhkC3caXJrinD66TtNxY6wcEIpl0jmEDpB
	 LTAO3FU+TuhTjpI+DA7389ej8H1XICOf7g8VDrd8XkM5Pkusy/lYVrJ09xIk5O5Usj9s6
	 uSOf/D0G3esEsLnZLNOc9NUgeEfnNMfgzsM/7y5ftgSh+rm6ocxTmhF/K/ZdW6Hfdtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423545;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=/Hgc+pAKMaP9FmTtcl1kKyQ25NZRhB37bUz/okZNCiQ=;
	b=XjToKsqcHoKKpqtmZC4luH3ZeHdQb1qI+QXRbFT445vT2lqu2YOYnnyoc2ZNKusnyjQe
	 jLPDTo93E5zAE15iN2U/bTC1ygtcZvGw80GBRsG/eZv6QWVewrb5n0kY3sjtfuMBFLfeV
	 cQzT9d9uZjVFvxM7egeXkVSMgc95YJnLKCl0V4UaoAp8Cgy9UZVLv58aXoNZ8Sz6GH1SI
	 gVybAbm7xuTrEoZKGGx+Ozm0VF2/BeclvKoXNAL6+mAFtTEqMR+068s7NmfvzRS63EdT1
	 E9MGyxnqENXNQzcmkIS+PDwF5+oBfsSacxR73lUsN0oSPPpUJtqcMt/4xXe1iKsuL/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiqtUFTK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491E606A331;
	Mon, 23 Nov 2026 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiqtUFTK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417891F000C6;
	Mon, 23 Nov 2026 08:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795423545;
	bh=/Hgc+pAKMaP9FmTtcl1kKyQ25NZRhB37bUz/okZNCiQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=fiqtUFTKO55WLaOP9pAFLyzpGOrbeS6uhs230g3TsoWX9YmBUOx4cDIzABEm19Ku4
	 OCUst/NvZSUKZyLresoo1udqBRBdlyv3NRRrOthkXFss0192rhjka/aezz7wDYmvL1
	 gQxuclUNo2umSiycr7eXsNgtfX7Nhvv3NlIY71dGiLLhWFJGAPVFzOQM+NnL7O1EzX
	 dzRSySkmfdaPhNUAZXHLn2ybHUq7TwWjQTIFmt/scmMvj08er0WguF+0ZAjUSgU6JE
	 mcYEtWahIiF0bDOO7TFPifJvm6xbXGV23q6PnX1nt0t/q+/5R2PrSDLugz/7nWn4lS
	 OPvC854MzKG6Q==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 813A8198003A;
	Mon, 23 Nov 2026 03:45:42 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 23 Nov 2026 03:45:42 -0500
X-ME-Sender: <xms:M_0Da8s6-Vjm_ehY0feG1wVsML9MnjDGLOP7N8DSVkTMDpkrlNadgw>
    <xme:M_0Da0Q-o-U-rGQagsWhcGOOUER4LWK9yHhQEZJjT7E0SYj422TM0ZzsDro8P0UMc
    eKMF9d4HAPIiPuYZK4XH04EA-bN7vZMP4swUNRraZpGq9C8LYPrMv40zg>
X-ME-Proxy-Cause: dmFkZTFWBu9gCpKA/cqYsbbQXSqmPgKHrSSMwjz504DssOqrr8eAAL++nqiamc/VPV9J60
    3I7yhx1ndCLqHw/fVcckLlizUwscfRmR55drXaG0ncsX0/G0USPDsc0QHn/ptBUYHq+L0d
    aHg8nyNIRmYgvUcrItOvbNmKi4RR//wyBbluSitDqWVXLMGtsy/g4iMehAmRC2tK7wQIyA
    m7B2+j+u5duYNSBGD+PjeE/o0cls4dn03R6W5MJ4ns6PbCXq5bt/w5V+3KPBzq6lappp97
    O9GkiNGQllY2eQsCoqUfzy64IG4wi43GgVBksoMdB7WokYlzcUcvtJvhSYGBjmqIq+WItG
    iYFQG2Hs/o9RlKDUTqb9Espy+/kTIXNqTWH6/2bF9e2eadFurEu/ZX6mdxbKptYC3X0eyC
    6bj6P2Gbw5cDD4Ns56vwcAfsvKErKQnCSfguYZLmxffmgZBFuu99JzA3UvySsubyDx1M/k
    QhFYUTuL+eprryXyign4PuytqD7JL4xQkAswJzSokIUJIk/Z2yAcNIKQMpmR9AyYaCmag9
    ndwMc36eHIQC8Jjh/1CgzEEGHKsLrdW8sBECqnN3EfDls6usvT+H0qQ8PJCBgbq62mxyvk
    bSPQG0kID1L1flSIWtcIma8kCu7mBnktYV8p5Bb2HeHdCfgRnxltOFEXVzMXGZ/CEG6wSu
    uB1FXMyBYTDBoNXgKiFm+1V7BPiTWD7w/4CZwW7v0gpykt7fTEEpjkeK8lErJtyj/2Mn7E
    ka2646vvB6g75PjmGbMPlMOBU56+gxxxCakCB4xDuvCExkB1qQF2NV+gno/Cogrl+9Vns7
    hFvmjp9BlbkKOE9i/fFTJqxupdVMHwGJTdrFf0jUNh4LWDD8/2kVxm8JbDdoJMts8mg5Uo
    uXTYBNtiNjxP0/vVaGVeb+pJy8LRIu+9PJlnBqMv0tkVMWLvacmszgMOgPC+bt646pMODJ
    NEZdqz3E/tUpqv+NjzBT2cZcltph9yBRHBrdSaEtPFJTyb6wdoo
X-ME-Proxy: <xmx:Nv0DawrauUgSF8boyxgPKR9EXCM97yUXGnVZPHBagXVJuqCXDxVrGw>
    <xmx:Nv0Da2H2pbnL5K0_dBRkJFq1yZQzVWCwO5AdWCmBZf0gO47gs75JXg>
    <xmx:Nv0Da2QSnPo2AU-pHIT8tBNjNmBWrFVmiL8xbOlz9a-0bzMeyOwugA>
    <xmx:Nv0Da8Mf1Mxvh6zFXYVgQ2O8-NCujddoa5uHKe-QA_czaPOSQ3ngIQ>
    <xmx:Nv0Dazkogo2b8v_Uy7oo9YHVWNvCqSxaRV0bFMUpU4p5y3W_EplqDchi>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DB4AA32A009C; Mon, 23 Nov 2026 03:45:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A1EAYUxGQhrR
Date: Mon, 23 Nov 2026 09:45:19 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Rich Felker" <dalias@libc.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Linus Walleij" <linusw@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 linux-sh@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <6575adac-fb6f-4080-a69b-46e71a3f0bfe@app.fastmail.com>
In-Reply-To: <dea00f90c205f8359baca729d8b0f31a@gmail.com>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
 <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com>
 <arzKNhmoL6yiGrzH@ashevche-desk.local>
 <dea00f90c205f8359baca729d8b0f31a@gmail.com>
Subject: Re: [PATCH v3 0/5] sh: mach-rsk: rsk7203: switch to using static device
 property, drop legacy gpio API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 23, 2026, at 07:44, Dmitry Torokhov wrote:
> On Wed, Sep 30, 2026 at 11:37:10AM +0300, Andy Shevchenko wrote:
>> On Wed, Sep 30, 2026 at 09:23:21AM +0200, Arnd Bergmann wrote:
> ...
>> > The patches look good to me. I have build-tested this with the snippet
>> > below and my series from
>> > https://lore.kernel.org/all/20260907090956.2825703-2-arnd@kernel.org/
>> > to check that no use of the legacy interfaces remain.
>> > You can probably fold my one-liner into your last patch.
> ...
>> > I would guess even with access to hardware testing is going to be
>> > challenging, I noticed that the defconfig kernel does not fit on the
>> > 4MB flash any more (even without rootfs), and the USB support was
>> > never added for rsk7203, only for 7264/7269.
>>
>> ...which induces a practical question, shouldn't we just drop the whole thing
>> for good?
>
> Gentle ping on this series. Will you be applying these patches (possibly
> with Arnd's Kconfig tweak folded in), or would you prefer patches
> removing rsk7203 support altogether since it is not working anyway?

Hi Dmitry,

I just noticed that neither your series nor mine [1] has made it into
v7.4, so we have the same conflict again for 7.5. 

I would suggest that in order to get it moving, I'll send my patches
as v8 without the rsk7203 oneliner so we can merge that through the
gpio tree.

If you rebase yours to drop both the '#include linux/gpio.h' and
'select GPIOLIB_LEGACY', then your patch is correct both with and
without mine and there is no conflict other than rsk7203 having
an intermittent build failure that I hope nobody cares about.

     Arnd

[1] https://lore.kernel.org/all/CAMRc=McRc9Aw-5WBipW5QhqqHp4+UKch15ui3E8a0srk2CUN7g@mail.gmail.com/
