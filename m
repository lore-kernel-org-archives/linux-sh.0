Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66F0C433DB
	for <linux-sh@archiver.kernel.org>; Mon, 11 Jan 2021 15:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B8122795
	for <linux-sh@archiver.kernel.org>; Mon, 11 Jan 2021 15:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbhAKPFs (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 11 Jan 2021 10:05:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:37555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbhAKPFr (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 11 Jan 2021 10:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610377452;
        bh=3EJylRDIVB92ko0ziXyNuJcEzvFJ7aK75H2nlm6+7bk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KPXGCxLF3eU3I9fRnG2Q7A5ovJLjj1GPza+k/CxZHUUoBu/+zxOzdPyrW/TkPxcaZ
         +OaLZcc27+kSol5w4AtwkYw3rPw5ZnnYc9ASGkAD8Evhcjksu/+HNoNf0qH/SwgQoq
         IDkxIE/Llx1YbHLl+twpW07giCxxuoioiUZnzu5A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.81] ([82.59.212.144]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1jy2HH23GF-012tLd; Mon, 11
 Jan 2021 16:04:12 +0100
Subject: Re: Old platforms: bring out your dead
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
From:   Gerhard Pircher <gerhard_pircher@gmx.net>
Openpgp: preference=signencrypt
Autocrypt: addr=gerhard_pircher@gmx.net; prefer-encrypt=mutual; keydata=
 mQINBFJ8FFoBEACppfmJokJ5NMYp+JnpOH65xNtMBVfgUKW+nwuE1SsiQvao7V5/XrX+SsXI
 Enk9GGU/FDnEJrjOK2c0t7zticDhveZCaEtAXupJjnIMpZo0IGy8mkX91ypozyHWhIfiIgDM
 HY/mwyNdDYGwWIZahHdi+xrbkYrYj00ViXyv9OSFPHYHhGJI0kmoUzdc3+s5q53vUn2xrl2W
 BMolE+6fLS3ZjmVNdl9zjgwRM+rE1tIR61fFBuiMSxhrUtSO8eyWQbQpnyQp6OK4oBHioPLQ
 +yVgFFlyosF1DCxKX94mZ6hTOMUJeNug84gpQZRlsDGPr8ke4w7YSS18DJj8IJPWZzFvLqIF
 KRd+gfIvujAk4ScVvL0SMpMMHEqN6E64xwbMuPdanj4u5ZLbvmggXPbTZ1Lo2pZeNoPP9RGR
 2B7W1WomQiZEzGiV99pW5l4e0a3wIj9GldoDvGyS0SfW9T/kBH1vkbCstmhSrcvGPqxYXqFx
 c0mI5TliIH93jPhnDnJj5nHDN665hz1XSaYKAtWngJsm7HfqRuqbEe2PHoErj3H7bVbGNvfp
 BulXfCjAp+LcmfWlkH6lzd7mvqGFQ2lTguvL6ZCiWNWVq81wsJ8eUPlGikRg3rxY63+pfao5
 zDD4GaSxvePKI/kdZ7Q7UJgg9RLM1LQTCe7kD19g3YpJu9YdkQARAQABtClHZXJoYXJkIFBp
 cmNoZXIgPGdlcmhhcmRfcGlyY2hlckBnbXgubmV0PokCTQQTAQoANwQLCQgHAhUKAhYBAhkB
 Ap4BApsjFiEED327A82TVD0VemhZ0Yg+eBGoazYFAl3B9KAFCQ0nE8YACgkQ0Yg+eBGoazZj
 Wg/+IVmoUxbBUMnbrK/kvAKBAo1zhiVGRMXk5QAD//6VhKzb02pfH79sdnyOcYmQEWDh7dbv
 3kzjbmjLrhunf0pqOUPP/0Ad66acFsLfh/up/LgDcWUP5nE5YRbYaQ/Av5zFhJaBM5SqV1LB
 OiQ+dLKH5oNtx0W54d2YqSoIIFSHbUPt49RL4fvcX73w1sQT0KZZgRjCfyVuYvHWaW1CdEfi
 B0OWnIlenrXoVcQrrd99WKxy8sdzRfF3YmLwqVZmOGhcpp/PODeSbHMoPo2wfLMToKtcvYPH
 ilNwTQHGghoR8v0SdkDS+W4fkoX92xPdvADTHqXI4LOIDKPbaUPcqY62F0B55Dk2H6XgTg00
 84Yi5RDosFO7DteVuYpm4UOytrCoB/HfHduex7+ZP9bsT+W3Fyj1k7L/DXD7MT70Z68zyhEb
 W5eCoKe2OWEbYvMRNLVT8tUzMchJpra7LJzCg9uTWdcqywrZ2jNvgdO3jh+TBxcwj3O8LfWq
 UrZxoFcEB92Kufg68ACaHdKjl+geGFKBSPTrUb9befUSfv2WfBpdHmuRWRUEpSOG3SHAYurc
 HccFtJtcdF/a6gxwyHz0jeXPNcSxBOKnU9xh5oVTigxIERs5CUdfl9ugsNGAzfsRQn5XdJOL
 cWwysQhchRW6kXT386cHq25icairzwbcEpi7etg=
Message-ID: <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net>
Date:   Mon, 11 Jan 2021 16:04:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MlWhL7GVxwFDIJnrjVA2obGipsevKZ5cKIO62cjtF7D8u4+nJwH
 d1Izq11BC5a6SNTmeL9ar4zE6tB87dCgDWxDTAPWeBltg1bqFuO5l1i/7NUtg59bw+FIbap
 F144986xX+kAVuVsHMgEG+oVWhnxY+RYHC4oIBPCE4D1bvGmHfvZZzkLaFmJM5IUKDtEJ7u
 XZdXtMkMuyymWmfMbviRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YB6FUPUySdQ=:K2bton6tAZKZUNtEfShPUR
 YMOb3v9fDlMSrwCHOT4ih7757hwCODnHUVWi/6jXpBZtDMF0Q2druCim0kW39qnfPU74Xm+Py
 nP9cEsbYRxFnEaHDxjFEGbRu/wmQ8Qj2nX3SbrCMSEuY2trl63JUPWosZlSmFN4TI9PgPm8IQ
 8hk9+e+I1VwJJL0yv5GlGqT4UCp4jsXa7WCxBchlSXe3i96WKUqsp5BQhC72/G9JyOV34eeK4
 5PDeEJbiVC+cWJWlvyxGJLSmeeOt/uNfShJsaEkVi2vSGmFDiFL4kgtlAJRbgGDVBsfYhWbkK
 /n6jGkQpbCsS5arailGaJhfFmRGTgBnIuTMMXy5HL3J2b/i2wcOG1TxSecnZf7TFb2nfpzUm2
 ls+lC5352dGgHgwXjS0Mzg0DiIxpt76VSmJe6Q44MEON5Ug8WNxPmUAOTzUGYSjJMgox7DHPO
 dFmuG7BleCE8SykAajxBUiUS59dTIWKQ2OU7PQx2WIr3Gt+IR0DxnzhYNJ8RluTzWk4aR2Dov
 MvfJGtZaszx23O7CLk1PkycPID+73jxOIZ2CpDFZRCtrrhHQkOmQ6rBTal0dV/4alZDVRgLZa
 taxbOQfkTijZRKEpHoia0hI1fnca7s/rgoD0sYurotoYtpS4vR5j+vYXHK2eWqD81Tt3kJy6Y
 23UUpSiLuCrrhoJ3HWvqlFjMhaPLUQGbtoZAzwLQqTGe+W7Rr4foMsEk6y0a7hFekjL7WNR+U
 R2bDKTNGHDsTdiYBmzg0AEfDKa+VMfjUezZ0gjuNR1EYeZ1uM47UagdizbOvO97QF0VxiFHSQ
 Fb0suUMuioj2gNdviyNWHZpvVEP+ROmOf9Bp4Cxn47CSzzhW/oNvHpvVC3NVamF/n9Ls9AFRJ
 wJwTKfp0+oRWTrRSGvHQ==
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Am 10.01.21 um 18:35 schrieb John Paul Adrian Glaubitz:
> Hi Arnd!
>
> (Please let's have this cross-posted for more visibility. I only learned=
 about this
>  while reading Phoronix news)
Same for me!

>> I also looked at non-ARM platforms while preparing for my article. Some=
 of
>> these look like they are no longer actively maintained or used, but I'm=
 not
>> doing anything about those unless the maintainers would like me to:
>>
>> * h8300: Steven Rostedt has repeatedly asked about it to be removed
>>    or fixed in 2020 with no reply. This was killed before in 2013, adde=
d back
>>    in 2015 but has been mostly stale again since 2016
>
> As far as I know, Yoshinori Sato is actively maintaining H8300 support, =
see:
>
>> https://osdn.net/projects/uclinux-h8/
>
>> * c6x: Added in 2011, this has seen very few updates since, but
>>     Mark still Acks patches when they come. Like most other DSP platfor=
ms,
>>     the model of running Linux on a DSP appears to have been obsoleted
>>     by using Linux on ARM with on-chip DSP cores running bare-metal cod=
e.
>> * sparc/sun4m: A patch for removing 32-bit Sun sparc support (not LEON)
>>    is currently under review
>
> I don't think this has reached any agreement yet. Multiple people want i=
t to stay.
>
>> * powerpc/cell: I'm the maintainer and I promised to send a patch to re=
move it.
>>    it's in my backlog but I will get to it. This is separate from PS3,
>>    which is actively maintained and used; spufs will move to ps3
>> * powerpc/chrp (32-bit rs6000, pegasos2): last updated in 2009
>
> I'm still using this. Please keep it.
I can also confirm that Pegasos2 users in the Amiga scene are running Linu=
x
(Debian) on these machines.

>> * powerpc/amigaone: last updated in 2009
I still have 2 of the 3 types of the first generation AmigaOne machines (n=
ot
to be confused with the newer AmigaOne X1000 and X5000 machines based on
PASemi and P5020 CPUs) working here. A third machine needs a repair of the
G4 CPU module (replacement parts already available).
I have to admit however that I yet have to setup an environment that allow=
s
me to regularly test new Linux kernel versions on these machines. Especial=
ly
because there are not many Linux users for these machines - which is likel=
y
due to the fact that no distribution officially supports these machines ou=
t
of the box (the Pegasos2 platform had more luck here). Inputs on how to
automate tests would therefore be very welcome!
Given however that the Debian PowerPC port has a proper maintainer again
(kudos to Adrian!) and there is also another new PowerPC distro (Void Linu=
x),
I would like to ask for a period of grace. After all this is just a hobby
project for me, so keeping up with the pace of the Linux development isn't
always that easy (and no, work on this did not stop in 2009, but shifted m=
ore
towards distro support since then).

>> * powerpc/maple: last updated in 2011
>> * m68k/{apollo,hp300,sun3,q40} these are all presumably dead and have n=
ot
>>    seen updates in many years (atari/amiga/mac and coldfire are very mu=
ch
>>    alive)
>
> Dito. I have both sun3 and hp300 machines.
>
>> * mips/jazz: last updated in 2007
>> * mips/cobalt: last updated in 2010
>>
>> There might be some value in dropping old CPU support on architectures
>> and platforms that are almost exclusively used with more modern CPUs.
>> If there are only few users, those can still keep using v5.10 or v5.4 s=
table
>> kernels for a few more years. Again, I'm not doing anything about them,
>> except mention them since I did the research.
>> These are the oldest one by architecture, and they may have reached
>> their best-served-by-date:
>>
>> * 80486SX/DX: 80386 CPUs were dropped in 2012, and there are
>>   indications that 486 have no users either on recent kernels.
>>   There is still the Vortex86 family of SoCs, and the oldest of those w=
ere
>>   486SX-class, but all the modern ones are 586-class.
>> * Alpha 2106x: First generation that lacks some of the later features.
>>   Since all Alphas are ancient by now, it's hard to tell whether these =
have
>>   any fewer users.
>
> I don't see the point in crippling Alpha support. Does this achieve anyt=
hing?
>
>> * IA64 Merced: first generation Itanium (2001) was quickly replaced by
>>   Itanium II in 2002.
>> * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
>>   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
>>   supports these in DECstation and Toshiba Txx9, but it appears that mo=
st
>>   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc an=
d
>>   later are rather different and widely used.
>> * PowerPC 601 (from 1992) just got removed, later 60x, 4xx, 8xx etc
>>   are apparently all still used.
>> * SuperH SH-2: We discussed removing SH-2 (not J2 or SH-4)
>>   support in the past, I don't think there were any objections, but
>>   nobody submitted a patch.
>
> Isn't SH-2 basically J-2? I'm not sure what we would gain here.
>
>> * 68000/68328 (Dragonball): these are less capable than the
>>   68020+ or the Coldfire MCF5xxx line and similar to the 68360
>>   that was removed in 2016.
>
> Adrian
>
