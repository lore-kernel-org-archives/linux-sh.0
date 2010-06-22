From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Tue, 22 Jun 2010 05:01:27 +0000
Subject: Re: [sh7785lcr proto] fails to boot since commit 6430a5987f8bb9a7c5187b343956aa8ef404d571
Message-Id: <AANLkTinEJKaCMUSA6tONrODojawB_tzcQjAofJ85vltv@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4C14ACDD.6050004@gentoo.org>
In-Reply-To: <4C14ACDD.6050004@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

2010/6/18 Ra=FAl Porcel <armin76@gentoo.org>:
> On 06/13/2010 12:03 PM, Ra=FAl Porcel wrote:
>> Hello list,
>>
>> I tried some weeks to upgrade the sh7785lcr prototype board using 32bits
>> to the latest released kernel(2.6.34.something). I've also tried with
>> latest git.
>>
> <snip>
>
> By Matt Fleming's request i've tested latest git again, and turns out
> that if i run the 'pmb' command on the 32bit uboot, the kernel boots.
>
> So i believe this is 'fixed'.

Yes, This is correct.
If you want to boot 32bit kernel, you need run pmb command.

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
